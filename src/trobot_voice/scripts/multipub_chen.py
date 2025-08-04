#!/usr/bin/env python
import rospy
import time
from geometry_msgs.msg import PoseWithCovarianceStamped
from tf.transformations import quaternion_from_euler
from math import radians
from std_msgs.msg import String
import re


LOCATION_MAPPING = {
    "one": (-3.88, -6.99, 0.00101), #corridor
    "kitchen": (-11.2, -5.86, 0.00238),
    "office": (-12.5, 0.869, 0.0032), #dean office
   
}
KEYWORDS = ["one", "kitchen", "office"]

def init_node():
    """Initializes the ROS node and subscribes to the speech result topic."""
    rospy.init_node('goal_publisher', anonymous=True)
    rospy.Subscriber("/speech_result", String, speech_callback)
    rospy.spin()

def speech_callback(message):
    """Callback function for speech result subscription."""
    recognized_text = message.data.lower()
    detected_keywords = extract_keywords(KEYWORDS, recognized_text)
    goals = [LOCATION_MAPPING[keyword] for keyword in detected_keywords if keyword in LOCATION_MAPPING]
    
    if goals:
        publish_goals(goals)

def extract_keywords(keywords, text):
    """Extracts matching keywords from the given text."""
    pattern = r'\b(' + '|'.join(map(re.escape, keywords)) + r')\b'
    return re.findall(pattern, text, re.IGNORECASE)

def publish_goals(goals):
    """Publishes goal positions to the '/goal_pose' topic."""
    pub = rospy.Publisher('/goal_pose', PoseWithCovarianceStamped, queue_size=10, latch = True)
    for x, y, yaw_degrees in goals:
        publish_goal(pub, x, y, yaw_degrees)

def publish_goal(publisher, x, y, yaw_degrees):
    """Publishes a single goal position."""
    yaw_radians = radians(yaw_degrees)
    goal_pose = PoseWithCovarianceStamped()
    goal_pose.header.stamp = rospy.Time.now()
    goal_pose.header.frame_id = "map"
    goal_pose.pose.pose.position.x = x
    goal_pose.pose.pose.position.y = y

    quaternion = quaternion_from_euler(0, 0, yaw_radians)
    goal_pose.pose.pose.orientation.x = quaternion[0]
    goal_pose.pose.pose.orientation.y = quaternion[1]
    goal_pose.pose.pose.orientation.z = quaternion[2]
    goal_pose.pose.pose.orientation.w = quaternion[3]

    publisher.publish(goal_pose)
    rospy.loginfo("Published goal pose: x=%f, y=%f, yaw=%f degrees" % (x, y, yaw_degrees))
    time.sleep(1)

if __name__ == '__main__':
    init_node()
