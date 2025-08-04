; Auto-generated. Do not edit!


(cl:in-package costmap_plugins-srv)


;//! \htmlinclude keepOutZone-request.msg.html

(cl:defclass <keepOutZone-request> (roslisp-msg-protocol:ros-message)
  ((command
    :reader command
    :initarg :command
    :type cl:fixnum
    :initform 0)
   (cost
    :reader cost
    :initarg :cost
    :type cl:fixnum
    :initform 0)
   (zone
    :reader zone
    :initarg :zone
    :type (cl:vector geometry_msgs-msg:PointStamped)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:PointStamped :initial-element (cl:make-instance 'geometry_msgs-msg:PointStamped)))
   (id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0))
)

(cl:defclass keepOutZone-request (<keepOutZone-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <keepOutZone-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'keepOutZone-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name costmap_plugins-srv:<keepOutZone-request> is deprecated: use costmap_plugins-srv:keepOutZone-request instead.")))

(cl:ensure-generic-function 'command-val :lambda-list '(m))
(cl:defmethod command-val ((m <keepOutZone-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader costmap_plugins-srv:command-val is deprecated.  Use costmap_plugins-srv:command instead.")
  (command m))

(cl:ensure-generic-function 'cost-val :lambda-list '(m))
(cl:defmethod cost-val ((m <keepOutZone-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader costmap_plugins-srv:cost-val is deprecated.  Use costmap_plugins-srv:cost instead.")
  (cost m))

(cl:ensure-generic-function 'zone-val :lambda-list '(m))
(cl:defmethod zone-val ((m <keepOutZone-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader costmap_plugins-srv:zone-val is deprecated.  Use costmap_plugins-srv:zone instead.")
  (zone m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <keepOutZone-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader costmap_plugins-srv:id-val is deprecated.  Use costmap_plugins-srv:id instead.")
  (id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <keepOutZone-request>) ostream)
  "Serializes a message object of type '<keepOutZone-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'command)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'cost)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'zone))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'zone))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <keepOutZone-request>) istream)
  "Deserializes a message object of type '<keepOutZone-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'command)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'cost)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'zone) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'zone)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:PointStamped))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<keepOutZone-request>)))
  "Returns string type for a service object of type '<keepOutZone-request>"
  "costmap_plugins/keepOutZoneRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'keepOutZone-request)))
  "Returns string type for a service object of type 'keepOutZone-request"
  "costmap_plugins/keepOutZoneRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<keepOutZone-request>)))
  "Returns md5sum for a message object of type '<keepOutZone-request>"
  "b77ce4a77ca03e6be1804558a2836ebc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'keepOutZone-request)))
  "Returns md5sum for a message object of type 'keepOutZone-request"
  "b77ce4a77ca03e6be1804558a2836ebc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<keepOutZone-request>)))
  "Returns full string definition for message of type '<keepOutZone-request>"
  (cl:format cl:nil "uint8 command # 0 - add; 1 - remove; 2 - clear; 3 - start record; 4 - stop record~%uint8 cost~%geometry_msgs/PointStamped[] zone~%uint32 id~%~%================================================================================~%MSG: geometry_msgs/PointStamped~%# This represents a Point with reference coordinate frame and timestamp~%Header header~%Point point~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'keepOutZone-request)))
  "Returns full string definition for message of type 'keepOutZone-request"
  (cl:format cl:nil "uint8 command # 0 - add; 1 - remove; 2 - clear; 3 - start record; 4 - stop record~%uint8 cost~%geometry_msgs/PointStamped[] zone~%uint32 id~%~%================================================================================~%MSG: geometry_msgs/PointStamped~%# This represents a Point with reference coordinate frame and timestamp~%Header header~%Point point~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <keepOutZone-request>))
  (cl:+ 0
     1
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'zone) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <keepOutZone-request>))
  "Converts a ROS message object to a list"
  (cl:list 'keepOutZone-request
    (cl:cons ':command (command msg))
    (cl:cons ':cost (cost msg))
    (cl:cons ':zone (zone msg))
    (cl:cons ':id (id msg))
))
;//! \htmlinclude keepOutZone-response.msg.html

(cl:defclass <keepOutZone-response> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0))
)

(cl:defclass keepOutZone-response (<keepOutZone-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <keepOutZone-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'keepOutZone-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name costmap_plugins-srv:<keepOutZone-response> is deprecated: use costmap_plugins-srv:keepOutZone-response instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <keepOutZone-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader costmap_plugins-srv:id-val is deprecated.  Use costmap_plugins-srv:id instead.")
  (id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <keepOutZone-response>) ostream)
  "Serializes a message object of type '<keepOutZone-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <keepOutZone-response>) istream)
  "Deserializes a message object of type '<keepOutZone-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<keepOutZone-response>)))
  "Returns string type for a service object of type '<keepOutZone-response>"
  "costmap_plugins/keepOutZoneResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'keepOutZone-response)))
  "Returns string type for a service object of type 'keepOutZone-response"
  "costmap_plugins/keepOutZoneResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<keepOutZone-response>)))
  "Returns md5sum for a message object of type '<keepOutZone-response>"
  "b77ce4a77ca03e6be1804558a2836ebc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'keepOutZone-response)))
  "Returns md5sum for a message object of type 'keepOutZone-response"
  "b77ce4a77ca03e6be1804558a2836ebc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<keepOutZone-response>)))
  "Returns full string definition for message of type '<keepOutZone-response>"
  (cl:format cl:nil "uint32 id~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'keepOutZone-response)))
  "Returns full string definition for message of type 'keepOutZone-response"
  (cl:format cl:nil "uint32 id~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <keepOutZone-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <keepOutZone-response>))
  "Converts a ROS message object to a list"
  (cl:list 'keepOutZone-response
    (cl:cons ':id (id msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'keepOutZone)))
  'keepOutZone-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'keepOutZone)))
  'keepOutZone-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'keepOutZone)))
  "Returns string type for a service object of type '<keepOutZone>"
  "costmap_plugins/keepOutZone")