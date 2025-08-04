#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import rospy
from geometry_msgs.msg import Pose, Point, Quaternion
from std_msgs.msg import String
from mbf_msgs.msg import MoveBaseAction, MoveBaseGoal
from mbf_msgs.msg import MoveBaseResult
import actionlib
from xju_pnc.srv import xju_task, xju_taskRequest

class voice_navi:
    def __init__(self):
        rospy.init_node('voice_navi')
        rospy.on_shutdown(self.cleanup)

        #rospy.wait_for_service('/xju_task')
        self.xju_task_service = rospy.ServiceProxy('/xju_task', xju_task)

        # Define target points
        self.goals = [
            Pose(Point(-9.56376838684, -8.22468852997, 0.0), Quaternion(0.0, 0.0, -0.617649073962, 0.786453826638)),
            Pose(Point(-14.4185314178, 9.63815307617, 0.0), Quaternion(0.0, 0.0, 0.954199715996, 0.299170356139)),
            # Pose(Point(-0.139, 0.124, 0.0), Quaternion(0.0, 0.0, -0.64162563583, 0.7670179551)),
            # Pose(Point(-2.00412654877, 8.74836540222, 0.0), Quaternion(0.0, 0.0, 0.692881192263, 0.721051768882)),
        ]

        # Initialize SimpleActionClient, specify move_base_flex's move_base as action server
        self.client = actionlib.SimpleActionClient('move_base_flex/move_base', MoveBaseAction) 
        self.client.wait_for_server()

        # Subscribe to voice output
        rospy.Subscriber('speech_result', String, self.speechCb)

    def speechCb(self, msg):
        rospy.loginfo(msg.data)

        # if "Office" in msg.data or "office" in msg.data:
        #     print(111)
        #     self.send_goal(self.goals[0])

        #     # 创建请求对象
        #     req = xju_taskRequest(type=0, command=0, dir='/home/penghui/pioneer_ws/path', path_name='room6666')
        
        #     # 调用服务并等待响应
        #     response = self.xju_task_service(req)

        # elif "Gate" in msg.data or "gate" in msg.data:
        #     self.send_goal(self.goals[1])

        #     # 创建请求对象
        #     req = xju_taskRequest(type=0, command=0, dir='/home/penghui/pioneer_ws/path', path_name='room7777')
        
        #     # 调用服务并等待响应
        #     response = self.xju_task_service(req)

        if "Clean" in msg.data:
            self.send_goal(self.goals[0])

            # 创建请求对象
            req = xju_taskRequest(type=0, command=0, dir='/home/penghui/pioneer_ws/path', path_name='room6666')
        
            # 调用服务并等待响应
            response = self.xju_task_service(req)

            rospy.sleep(200)

            self.send_goal(self.goals[1])
            
            # 创建请求对象
            req = xju_taskRequest(type=0, command=0, dir='/home/penghui/pioneer_ws/path', path_name='room7777')
        
            # 调用服务并等待响应
            response = self.xju_task_service(req)
            
            rospy.sleep(200)

            self.send_goal(self.goals[0])

    def send_goal(self, goal):
        move_goal = MoveBaseGoal()
        move_goal.target_pose.header.frame_id = "map"
        move_goal.target_pose.pose = goal
        self.client.send_goal(move_goal)
        self.client.wait_for_result()

        # Handle the result with mbf_msgs
        result = self.client.get_result()
        # if result.outcome == mbf_msgs.MoveBaseResult.SUCCESS:
        #     rospy.loginfo("Navigation succeeded.")
        # else:
        #     rospy.logerr("Navigation failed: %s" % result.message)

    def cleanup(self):
        self.client.cancel_all_goals()

if __name__ == "__main__":
    try:
        voice_navi()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
