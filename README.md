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
