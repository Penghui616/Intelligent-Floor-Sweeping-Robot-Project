;; Auto-generated. Do not edit!


(when (boundp 'costmap_plugins::keepOutZone)
  (if (not (find-package "COSTMAP_PLUGINS"))
    (make-package "COSTMAP_PLUGINS"))
  (shadow 'keepOutZone (find-package "COSTMAP_PLUGINS")))
(unless (find-package "COSTMAP_PLUGINS::KEEPOUTZONE")
  (make-package "COSTMAP_PLUGINS::KEEPOUTZONE"))
(unless (find-package "COSTMAP_PLUGINS::KEEPOUTZONEREQUEST")
  (make-package "COSTMAP_PLUGINS::KEEPOUTZONEREQUEST"))
(unless (find-package "COSTMAP_PLUGINS::KEEPOUTZONERESPONSE")
  (make-package "COSTMAP_PLUGINS::KEEPOUTZONERESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass costmap_plugins::keepOutZoneRequest
  :super ros::object
  :slots (_command _cost _zone _id ))

(defmethod costmap_plugins::keepOutZoneRequest
  (:init
   (&key
    ((:command __command) 0)
    ((:cost __cost) 0)
    ((:zone __zone) (let (r) (dotimes (i 0) (push (instance geometry_msgs::PointStamped :init) r)) r))
    ((:id __id) 0)
    )
   (send-super :init)
   (setq _command (round __command))
   (setq _cost (round __cost))
   (setq _zone __zone)
   (setq _id (round __id))
   self)
  (:command
   (&optional __command)
   (if __command (setq _command __command)) _command)
  (:cost
   (&optional __cost)
   (if __cost (setq _cost __cost)) _cost)
  (:zone
   (&rest __zone)
   (if (keywordp (car __zone))
       (send* _zone __zone)
     (progn
       (if __zone (setq _zone (car __zone)))
       _zone)))
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:serialization-length
   ()
   (+
    ;; uint8 _command
    1
    ;; uint8 _cost
    1
    ;; geometry_msgs/PointStamped[] _zone
    (apply #'+ (send-all _zone :serialization-length)) 4
    ;; uint32 _id
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _command
       (write-byte _command s)
     ;; uint8 _cost
       (write-byte _cost s)
     ;; geometry_msgs/PointStamped[] _zone
     (write-long (length _zone) s)
     (dolist (elem _zone)
       (send elem :serialize s)
       )
     ;; uint32 _id
       (write-long _id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _command
     (setq _command (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _cost
     (setq _cost (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; geometry_msgs/PointStamped[] _zone
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _zone (let (r) (dotimes (i n) (push (instance geometry_msgs::PointStamped :init) r)) r))
     (dolist (elem- _zone)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; uint32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass costmap_plugins::keepOutZoneResponse
  :super ros::object
  :slots (_id ))

(defmethod costmap_plugins::keepOutZoneResponse
  (:init
   (&key
    ((:id __id) 0)
    )
   (send-super :init)
   (setq _id (round __id))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:serialization-length
   ()
   (+
    ;; uint32 _id
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _id
       (write-long _id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass costmap_plugins::keepOutZone
  :super ros::object
  :slots ())

(setf (get costmap_plugins::keepOutZone :md5sum-) "b77ce4a77ca03e6be1804558a2836ebc")
(setf (get costmap_plugins::keepOutZone :datatype-) "costmap_plugins/keepOutZone")
(setf (get costmap_plugins::keepOutZone :request) costmap_plugins::keepOutZoneRequest)
(setf (get costmap_plugins::keepOutZone :response) costmap_plugins::keepOutZoneResponse)

(defmethod costmap_plugins::keepOutZoneRequest
  (:response () (instance costmap_plugins::keepOutZoneResponse :init)))

(setf (get costmap_plugins::keepOutZoneRequest :md5sum-) "b77ce4a77ca03e6be1804558a2836ebc")
(setf (get costmap_plugins::keepOutZoneRequest :datatype-) "costmap_plugins/keepOutZoneRequest")
(setf (get costmap_plugins::keepOutZoneRequest :definition-)
      "uint8 command # 0 - add; 1 - remove; 2 - clear; 3 - start record; 4 - stop record
uint8 cost
geometry_msgs/PointStamped[] zone
uint32 id

================================================================================
MSG: geometry_msgs/PointStamped
# This represents a Point with reference coordinate frame and timestamp
Header header
Point point

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z
---
uint32 id

")

(setf (get costmap_plugins::keepOutZoneResponse :md5sum-) "b77ce4a77ca03e6be1804558a2836ebc")
(setf (get costmap_plugins::keepOutZoneResponse :datatype-) "costmap_plugins/keepOutZoneResponse")
(setf (get costmap_plugins::keepOutZoneResponse :definition-)
      "uint8 command # 0 - add; 1 - remove; 2 - clear; 3 - start record; 4 - stop record
uint8 cost
geometry_msgs/PointStamped[] zone
uint32 id

================================================================================
MSG: geometry_msgs/PointStamped
# This represents a Point with reference coordinate frame and timestamp
Header header
Point point

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z
---
uint32 id

")



(provide :costmap_plugins/keepOutZone "b77ce4a77ca03e6be1804558a2836ebc")


