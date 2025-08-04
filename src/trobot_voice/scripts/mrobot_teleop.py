#!/usr/bin/env python
import rospy
from geometry_msgs.msg import Twist
from std_msgs.msg import String
t=None
msg = """
Control mrobot!
---------------------------
Moving around:
   u    i    o
   j    k    l
   m    ,    .

q/z : increase/decrease max speeds by 10%
w/x : increase/decrease only linear speed by 10%
e/c : increase/decrease only angular speed by 10%
space key, k : force stop
anything else : stop smoothly

CTRL-C to quit
"""

moveBindings = {
        'i':(1,0),
        'o':(1,-1),
        'j':(0,1),
        'l':(0,-1),
        'u':(1,1),
        ',':(-1,0),
        '.':(-1,1),
        'm':(-1,-1),
        'k':(0,0),
           }


speed =0.1
turn = 0.3

target_speed = 0
target_turn = 0

def keys_cb(msg,twist_pub):
    global t,speed,turn
    if len(msg.data)==0 or not moveBindings.has_key(msg.data[0]):
        return
    vels=moveBindings[msg.data[0]]
    
    t.linear.x=speed*vels[0]
    t.angular.z=turn*vels[1]
    twist_pub.publish(t)

 
     
if __name__=="__main__":
    rospy.init_node('voice_teleop')
    twist_pub = rospy.Publisher('/cmd_vel', Twist, queue_size=1)
    rospy.Subscriber('keyCmd',String,keys_cb,twist_pub)
    rate=rospy.Rate(10)
    t=Twist()
    while not rospy.is_shutdown():
        twist_pub.publish(t)
        rate.sleep()
  
    
