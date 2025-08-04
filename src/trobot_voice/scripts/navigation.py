#!/usr/bin/env python 
# -*- coding: utf-8 -*-
 
from typing import Counter, Sequence
import roslib;
import rospy  
import actionlib  
from actionlib_msgs.msg import *  
from geometry_msgs.msg import Pose, PoseWithCovarianceStamped, Point, Quaternion, Twist  
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal  
from random import sample  
from math import pow, sqrt  
from std_msgs.msg import String

class NavTest():  
    def __init__(self):  
        rospy.init_node('random_navigation', anonymous=True)  
        rospy.on_shutdown(self.shutdown)  
 
        # Pause time at each target location  
        self.rest_time = 5

        # The state of reaching the goal  
        goal_states = ['PENDING', 'ACTIVE', 'PREEMPTED',   
                       'SUCCEEDED', 'ABORTED', 'REJECTED',  
                       'PREEMPTING', 'RECALLING', 'RECALLED',  
                       'LOST']  
 
        # Set the location of the target point  
        # If you want to get the coordinates of a certain point, click the 2D Nav Goal button in rviz, and then select a point on the stand-alone map  
        # You will see the coordinate information in the terminal  
        locations = dict()  

        locations['p1'] = Pose(Point(-3.27943, -1.53989, 0.000), Quaternion(0.000, 0.000, 0.030704,  0.9995))  
        locations['p2'] = Pose(Point(0.3319, 3.12863, 0.0), Quaternion(0.000, 0.000,-0.699575, 0.714559)) 
        locations['p3'] = Pose(Point( 0.46704, -0.04647, 0.0), Quaternion(0.0, 0.0, 0.963497, 0.26771)) 
        locations['p4'] = Pose(Point(-2.86834,  2.0988, 0.000), Quaternion(0.000, 0.000, 0.9557, 0.29416))  
        
        # locations = [  
        #     [(1.2653, -0.830, 0.000), (0.000, 0.000, 0.92, 0.39)],
        #     [(-3.37, 1.76, 0.0), (0.0, 0.0, -0.152, 0.9884)],
        #     [(0.45266, 3.175594, 0.0), (0.0, 0.0, -0.702027, 0.7)],
        #     [(2.1, 2.2, 0.0), (0.0, 0.0, 0.0, 1.0)]
        # ]


        # Publish a message to control the robot  
        self.cmd_vel_pub = rospy.Publisher('cmd_vel', Twist, queue_size=5)  
        self.pub_loc=rospy.Publisher("loc",String,queue_size=1)
 
        # Subscribe to messages from the move_base server  
        self.move_base = actionlib.SimpleActionClient("move_base", MoveBaseAction)  

        rospy.loginfo("Waiting for move_base action server...")  

        # 60s waiting time limit  
        self.move_base.wait_for_server(rospy.Duration(60))  
        rospy.loginfo("Connected to move base server")  

        # Save the robot's initial position in rviz  
        initial_pose = PoseWithCovarianceStamped()  

        # Variables that hold success rate, running time, and distance  
        n_locations = len(locations)  
        n_goals = 0  
        n_successes = 0  
        i = n_locations  
        distance_traveled = 0  
        start_time = rospy.Time.now()  
        running_time = 0  
        location = ""  
        last_location = ""
        global sequence
        i=0
        #   Make sure there is an initial position
        while initial_pose.header.stamp == "":  
            rospy.sleep(1)  

        rospy.loginfo("Starting navigation test")  

        # Start the main loop and navigate randomly  
        while not rospy.is_shutdown():    
            # If all points have been visited, start sorting again  
            if i>3:  
                i =i %4
            sequence =   ['p1','p2','p3','p4']
            # Get the next target point in the current sort 
            location = sequence[i]  
            
            # Track distance traveled  
            # Use updated initial position  
            if initial_pose.header.stamp == "":  
                distance = sqrt(pow(locations[location].position.x -   
                                    locations[last_location].position.x, 2) +  
                                pow(locations[location].position.y -   
                                    locations[last_location].position.y, 2))  
            else:  
                rospy.loginfo("Updating current pose.")  
                distance = sqrt(pow(locations[location].position.x -   
                                    initial_pose.pose.pose.position.x, 2) +  
                                pow(locations[location].position.y -   
                                    initial_pose.pose.pose.position.y, 2))  
                initial_pose.header.stamp = ""  

            # Store the last position and calculate the distance 
            last_location = location  

            # Counter increments by 1  
            i += 1  
            n_goals += 1  

            # Set next target point 
            self.goal = MoveBaseGoal()  
            self.goal.target_pose.pose = locations[location]  
            self.goal.target_pose.header.frame_id = 'map'  
            self.goal.target_pose.header.stamp = rospy.Time.now()  

            # 让用户知道下一个位置  
            rospy.loginfo("Going to: " + str(location))  

            # 向下一个位置进发  
            self.move_base.send_goal(self.goal)  

            # 五分钟时间限制  
            finished_within_time = self.move_base.wait_for_result(rospy.Duration(300))   

            # 查看是否成功到达  
            if not finished_within_time:  
                self.move_base.cancel_goal()  
                rospy.loginfo("Timed out achieving goal")  
            else:  
                state = self.move_base.get_state()  
                if state == GoalStatus.SUCCEEDED:  
                    rospy.loginfo("Goal succeeded!")  
                    n_successes += 1  
                    distance_traveled += distance  
                    rospy.loginfo("State:" + str(state))  
                else:  
                    rospy.loginfo("Goal failed with error code: " + str(goal_states[state]))  

            # 运行所用时间  
            running_time = rospy.Time.now() - start_time  
            running_time = running_time.secs / 60.0  

            # 输出本次导航的所有信息  
            rospy.loginfo("Success so far: " + str(n_successes) + "/" +   
                        str(n_goals) + " = " +   
                        str(100 * n_successes/n_goals) + "%")  

            rospy.loginfo("Running time: " + str(trunc(running_time, 1)) +   
                        " min Distance: " + str(trunc(distance_traveled, 1)) + " m")  
            ##########
            if i==1:
                strs="卧房"
            elif i==2:
                strs="书房"
            elif i==3:
                strs="走廊"
            elif i==4:
                strs="客厅"
            else:
                strs="FALSE"
            count=0
            #发送五次
            while count<6:
                self.pub_loc.publish(strs)
                count+=1
                rospy.sleep(self.rest_time)  

    def update_initial_pose(self, initial_pose):  
        self.initial_pose = initial_pose  

    def shutdown(self):  
        rospy.loginfo("Stopping the robot...")  
        self.move_base.cancel_goal()  
        rospy.sleep(2)  
        self.cmd_vel_pub.publish(Twist())  
        rospy.sleep(1)  

def trunc(f, n):   
    slen = len('%.*f' % (n, f))  

    return float(str(f)[:slen])  

if __name__ == '__main__':  
    try:  
        NavTest()  
        rospy.spin()  

    except rospy.ROSInterruptException:  
        rospy.loginfo("Random navigation finished.")
