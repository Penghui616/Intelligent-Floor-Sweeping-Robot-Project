1. Say two places by voice and let the robot go 
to these two places in turn to sweep.

roslaunch p3dx_navigation pioneer.launch

roslaunch xju_pnc move_base_flex.launch

roslaunch trobot_voice voice_clean.launch


3. Battery monitoring and back to the charging 
station.

roslaunch p3dx_navigation pioneer.launch

roslaunch p3dx_navigation move_base_rosaria.launch

roslaunch p3dx_navigation rviz_p3dx.launch

rosrun p3dx_navigation battery_sub.py 

rosrun p3dx_navigation multi_point_navigation.py

rosrun p3dx_navigation battery_percentage.py

Intelligent Floor Sweeping Robot
This project involves the design and development of an autonomous floor sweeping robot powered by ROS (Robot Operating System). The robot is capable of performing voice-controlled navigation, full-coverage path cleaning, battery monitoring, and autonomous recharging. It is suitable for both residential and commercial cleaning applications.

Key Features
Voice Control: Users can speak the names of two rooms, and the robot will sweep them in sequence.

Full-Coverage Cleaning: Optimized path planning using Bézier curves ensures that the robot covers the entire area without missing any spots.

Low Battery Return: When battery drops below 30%, the robot sends an email to the user and returns to the charging station automatically.

Autonomous Mapping & Navigation: The robot can navigate and avoid obstacles based on live map generation.

Email Feedback: Battery status is communicated to the user via email for monitoring.

System Architecture
PathPlanningNode: The core ROS node that manages overall path planning.

CoveragePathPlanner: Generates complete coverage paths based on input maps.

BezierTrajectoryGeneratorWaypoint: Optimizes and smooths the path for better motion control.

FreeSpaceCalculator: Determines navigable space to ensure feasibility of planned paths.

Project Launch Instructions
Voice-Activated Sweeping:

roslaunch p3dx_navigation pioneer.launch
roslaunch xju_pnc move_base_flex.launch
roslaunch trobot_voice voice_clean.launch
Battery Monitoring and Auto-Charging:

roslaunch p3dx_navigation pioneer.launch
roslaunch p3dx_navigation move_base_rosaria.launch
roslaunch p3dx_navigation rviz_p3dx.launch
rosrun p3dx_navigation battery_sub.py 
rosrun p3dx_navigation multi_point_navigation.py
rosrun p3dx_navigation battery_percentage.py

Tech Stack
ROS (Robot Operating System)

Python

Move Base Flex

RViz (for visualization)

Custom ROS Services and Topics

Application Scenarios
Home cleaning

Office and commercial space maintenance

Adaptable to agriculture, warehousing, and other area coverage tasks

Email Notification System
Once battery percentage drops below 30%, the robot:

Sends a notification email to the user.

Navigates autonomously back to the charging dock.

This feature helps ensure uninterrupted operation without manual intervention.

Development Status
Voice-controlled room-to-room cleaning fully functional

Real-time autonomous navigation and mapping working

Battery monitoring and auto-docking tested and reliable
