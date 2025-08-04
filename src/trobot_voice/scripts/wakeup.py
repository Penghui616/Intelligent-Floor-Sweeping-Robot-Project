#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
from std_msgs.msg import String

rospy.init_node('wakeup_topic')
pub=rospy.Publisher('voiceWakeup',String,queue_size=1)
rate=rospy.Rate(10)
stri="wake up!"
while not rospy.is_shutdown():
    pub.publish(stri)
    rate.sleep()
