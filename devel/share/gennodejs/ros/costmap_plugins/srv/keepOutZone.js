// Auto-generated. Do not edit!

// (in-package costmap_plugins.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------


//-----------------------------------------------------------

class keepOutZoneRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.command = null;
      this.cost = null;
      this.zone = null;
      this.id = null;
    }
    else {
      if (initObj.hasOwnProperty('command')) {
        this.command = initObj.command
      }
      else {
        this.command = 0;
      }
      if (initObj.hasOwnProperty('cost')) {
        this.cost = initObj.cost
      }
      else {
        this.cost = 0;
      }
      if (initObj.hasOwnProperty('zone')) {
        this.zone = initObj.zone
      }
      else {
        this.zone = [];
      }
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type keepOutZoneRequest
    // Serialize message field [command]
    bufferOffset = _serializer.uint8(obj.command, buffer, bufferOffset);
    // Serialize message field [cost]
    bufferOffset = _serializer.uint8(obj.cost, buffer, bufferOffset);
    // Serialize message field [zone]
    // Serialize the length for message field [zone]
    bufferOffset = _serializer.uint32(obj.zone.length, buffer, bufferOffset);
    obj.zone.forEach((val) => {
      bufferOffset = geometry_msgs.msg.PointStamped.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [id]
    bufferOffset = _serializer.uint32(obj.id, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type keepOutZoneRequest
    let len;
    let data = new keepOutZoneRequest(null);
    // Deserialize message field [command]
    data.command = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [cost]
    data.cost = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [zone]
    // Deserialize array length for message field [zone]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.zone = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.zone[i] = geometry_msgs.msg.PointStamped.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [id]
    data.id = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.zone.forEach((val) => {
      length += geometry_msgs.msg.PointStamped.getMessageSize(val);
    });
    return length + 10;
  }

  static datatype() {
    // Returns string type for a service object
    return 'costmap_plugins/keepOutZoneRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2e4d007d03a9492c1e9db89ba981e084';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 command # 0 - add; 1 - remove; 2 - clear; 3 - start record; 4 - stop record
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new keepOutZoneRequest(null);
    if (msg.command !== undefined) {
      resolved.command = msg.command;
    }
    else {
      resolved.command = 0
    }

    if (msg.cost !== undefined) {
      resolved.cost = msg.cost;
    }
    else {
      resolved.cost = 0
    }

    if (msg.zone !== undefined) {
      resolved.zone = new Array(msg.zone.length);
      for (let i = 0; i < resolved.zone.length; ++i) {
        resolved.zone[i] = geometry_msgs.msg.PointStamped.Resolve(msg.zone[i]);
      }
    }
    else {
      resolved.zone = []
    }

    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    return resolved;
    }
};

class keepOutZoneResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type keepOutZoneResponse
    // Serialize message field [id]
    bufferOffset = _serializer.uint32(obj.id, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type keepOutZoneResponse
    let len;
    let data = new keepOutZoneResponse(null);
    // Deserialize message field [id]
    data.id = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'costmap_plugins/keepOutZoneResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '309d4b30834b338cced19e5622a97a03';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 id
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new keepOutZoneResponse(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: keepOutZoneRequest,
  Response: keepOutZoneResponse,
  md5sum() { return 'b77ce4a77ca03e6be1804558a2836ebc'; },
  datatype() { return 'costmap_plugins/keepOutZone'; }
};
