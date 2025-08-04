# CMake generated Testfile for 
# Source directory: /home/penghui/pioneer_ws/src/urg_node
# Build directory: /home/penghui/pioneer_ws/build/urg_node
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_urg_node_roslint_package "/home/penghui/pioneer_ws/build/catkin_generated/env_cached.sh" "/usr/bin/python2" "/opt/ros/melodic/share/catkin/cmake/test/run_tests.py" "/home/penghui/pioneer_ws/build/test_results/urg_node/roslint-urg_node.xml" "--working-dir" "/home/penghui/pioneer_ws/build/urg_node" "--return-code" "/opt/ros/melodic/share/roslint/cmake/../../../lib/roslint/test_wrapper /home/penghui/pioneer_ws/build/test_results/urg_node/roslint-urg_node.xml make roslint_urg_node")
add_test(_ctest_urg_node_roslaunch-check_launch_urg_lidar.launch "/home/penghui/pioneer_ws/build/catkin_generated/env_cached.sh" "/usr/bin/python2" "/opt/ros/melodic/share/catkin/cmake/test/run_tests.py" "/home/penghui/pioneer_ws/build/test_results/urg_node/roslaunch-check_launch_urg_lidar.launch.xml" "--return-code" "/usr/bin/cmake -E make_directory /home/penghui/pioneer_ws/build/test_results/urg_node" "/opt/ros/melodic/share/roslaunch/cmake/../scripts/roslaunch-check -o \"/home/penghui/pioneer_ws/build/test_results/urg_node/roslaunch-check_launch_urg_lidar.launch.xml\" \"/home/penghui/pioneer_ws/src/urg_node/launch/urg_lidar.launch\" ")
