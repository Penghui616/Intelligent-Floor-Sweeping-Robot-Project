
(cl:in-package :asdf)

(defsystem "costmap_plugins-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "keepOutZone" :depends-on ("_package_keepOutZone"))
    (:file "_package_keepOutZone" :depends-on ("_package"))
  ))