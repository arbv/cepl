(in-package :cepl.pipelines)

(defmacro map-g (pipeline-func stream &rest uniforms)
  `(with-viewport (current-viewport)
     (%map-g ,pipeline-func ,stream ,@uniforms)))

(defmacro %map-g (pipeline-func stream &rest uniforms)
  (labels ((function-formp (x) (eq (first x) 'function)))
    `(progn
       (funcall ,pipeline-func ,+mapg-constant+ ,stream ,@uniforms)
       %current-fbo)))

(defmacro map-g-into (fbo pipeline-func stream &rest uniforms)
  `(with-fbo-bound (,fbo)
     (map-g ,pipeline-func ,stream ,@uniforms)))

(defmacro map-g-into* ((fbo &key (target :framebuffer) (with-viewport t)
			    (attachment-for-size 0) (with-blending t))
			      pipeline-func stream &rest uniforms)
  `(with-fbo-bound (,fbo :target ,target
			 :unbind t
			 :attachment-for-size ,attachment-for-size
			 :with-viewport ,with-viewport
			 :with-blending ,with-blending
			 :draw-buffers t)
     (map-g ,pipeline-func ,stream ,@uniforms)))
