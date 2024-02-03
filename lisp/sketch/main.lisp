(defpackage :sketches
  (:use :cl :sketch)
  (:export :main))

(in-package :sketches)

(defsketch tutorial
    ((title "Sinewave")
     (width 400)
     (height 400)
     (frame-count 1)
     (num-frames 60)
     (r 100)
     (2pi (* pi 2)))

  (let* ((i (*  1.0 (/ (- frame-count 1) num-frames)))
	 (x (+ (/ width 2) (* r (cos (* 2pi i)))))
	 (y (+ (/ height 2) (* r (sin (* 2pi i))))))
    (incf frame-count)
    (background (rgb 0.2 0.2 0.2))
    (text (format nil "ok ~a" time) 10 10)
    (circle x y 10)))

(make-instance 'tutorial)
