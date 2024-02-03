(defsystem "sketches"
  :version "0.1.0"
  :description ""
  :author ""
  :license ""
  :depends-on (:sketch)
  :serial t
  :components ((:module "."
		:components
		(
		 (:file "main")
		 
		 )))
  ;; :components ((:file "main"))
  :build-operation "program-op"
  :build-pathname "sketches"
  ;; :entry-point "sketches:main"
  )
