
(in-package :sherpa)

(defun make-spatial-relation-cost-function (location axis pred)
  "This function is used for resolving spatial relations such as left-of, behind etc.
   Returns a lambda function which for any (x y) gives a value in [0; 1]."
  (let ((world->location-transformation (cl-transforms:transform-inv location)))
    (lambda (x y)
      (let* ((point (cl-transforms:transform-point world->location-transformation
                                                   (cl-transforms:make-3d-vector x y 0)))
             (coord (ecase axis
                      (:x (cl-transforms:x point))
                      (:y (cl-transforms:y point))))
             (mode (sqrt (+ (* (cl-transforms:x point) (cl-transforms:x point))
                            (* (cl-transforms:y point) (cl-transforms:y point))))))
        (if (funcall pred coord 0.0d0)
            ;; projects the vector to the point (x, y) onto the `axis'
            ;; returns the ratio between the lengths of projection and the vector itself
            (abs (/ coord mode))
            0.0d0)))))