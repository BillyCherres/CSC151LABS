
; In shapes.scm, write definitions for blue-circle, a solid circle of radius 40, red-square, a solid red square of edge-length 80, and black-rectangle, an outlined black rectangle of width 120 and height 40.
(import image)

(define blue-circle 
    (circle 40 "solid" "blue"))

(define red-square 
    (square 80 "solid" "red"))

(define black-rectangle
    (rectangle 120 40  "outline" "black"))

(beside blue-circle red-square)
(beside red-square blue-circle)
(beside blue-circle blue-circle)
(beside blue-circle red-square blue-circle red-square blue-circle)
(beside red-square black-rectangle)
(above blue-circle black-rectangle)
(beside red-square (above black-rectangle black-rectangle) red-square)
(above black-rectangle (beside red-square blue-circle))

(define image
    (beside red-square black-rectangle red-square (above blue-circle red-square)))

(beside image)

(above black-rectangle (beside red-square blue-circle))

; these dont work because its not the right syntax
;   (2 + 3)
   ; 7 * 9
  ;  sqrt(49)
;    (+ (87) (23))
