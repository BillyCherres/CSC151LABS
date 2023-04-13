(import image)
; 3∗(4−1/7)

(* 3(- 4(/ 1 7)))
; step 1: 1/7
; step 2 : 4 - 1/7
; step 3: 3 x (4 - 1/7)

; (3 + 5)^ 1/2

(expt (+ 3 5) (/ 1 2))
;step 1: 3+5
;step 2: 1/2
;step 3: 8^.5

;1+(−2+(3+(4+−5)))

(+ 1(- (+ 3(- 4 5))2) )
; step 1: 4 - 5
; step 2: 3 - 1
; step 3: 2 - 2 
; step 4: 0 + 1

; 8 + 3 * 2 - 1/5
(- (+ 8 (* 3 2)) (/ 1 5))
;step 1: 3 * 2
;step 2: 1 / 5
;step 3: 8 + 6
;step 4: 14 - (1/5)


; (a)
(string-length
  (string-append "hello"
                 " "
                 "world!"))

; string-length obtains the # of characters in the string. String-append adds the values into a string. So adding up all the characters including the spaces makes the output 12.

; (b)
(+ 32 (* 8 60) (* (/ 1 2) 4 (expt 60 2)))

; First, the expt command makes us square 60(3600), then we use the * command and multiply the 1/2(.5) by 4 by 3600 (7200) then we add the (* 8 60) and the 32 to get our final value of 7712.

; (c)
 (odd? (length (string-split "4,9,10,11,2,3" ",")))

; string split splits the list into 6 seperate values . Length counts the values in the list. and odd? checks if the length is odd. Its not odd so the output is false or #f

; (d)
(define width 100)
(define height 100)
(define alpha 0.5)

(overlay
  (beside
    (rectangle width height "solid" (color 255 0 0 alpha))
    (rectangle (* width 0.75) (* height 0.75) "solid" (color 0 255 0 (* alpha 0.75)))
    (rectangle (* width 0.5) (* height 0.5) "solid" (color 0 0 255 (* alpha 0.5)))
    (rectangle (* width 0.25) (* height 0.25) "solid" (color 0 0 0 (* alpha 0.25))))
  (beside
    (rectangle (* width 0.25) (* height 0.25) "solid" (color 0 0 0 (* alpha 0.25)))
    (rectangle (* width 0.5) (* height 0.5) "solid" (color 0 0 255 (* alpha 0.5)))
    (rectangle (* width 0.75) (* height 0.75) "solid" (color 0 255 0 (* alpha 0.75)))
    (rectangle width height "solid" (color 255 0 0 alpha))))
    ; First, our three definitions allow us to call back these three values throughout our drawing. Next, the overlay command tells us to put the first drawing on top of the second in a way. Next, the drawings themselves, the command rectangle defines what shape we are drawing and how many dimensions this shape needs. the subexpression "solid" tells us that all of these rectangles are full and not outlines. Lastly, the demensions given call back ourdefenitions and multiply them by the value given, for example (height .5) would lead to a rectangle witha hight of 50. Additionally, the "beside" command helps us to place these rectangles next to one another in the correct spot to create our final drawring of two big red rectangles on top of one geen two blue and two red rectangles. 

    ; When reading Scheme expressions, read them “inside-out” or “right-to-left.”
    ; this makes sense because the sub exressions tell you how to use the intitial commands 

    (define x 10)


    (+ x 1)
; (+ (define x 10) 1)
;(* 3 (define x 8))
;(/ 3 (define x 5) (define x 6))

(define y 7)
; In this case, "define" tells us that every time we use "y" the value would be 7. 

(define a 5)
(define b (* 5 8))
(define c (+ 1 1))

(+ a b c)

; step 1: assign "a" to the value of 5
; step2: assign b to the value of (* 5 8) = 40
; step3: assign c to the value of (+ 1 1) = 2
; step 4: (a + b + C) = (5 + 40 + 2) = 47

; (ii)
(define d 20)
(define e (* d 20))
(define f (* e e))

(+ d e f)
; step 1: assign "d" to the value of 20
; step2: assign "e" to the value of (* d 20) = 400
; step3: assign "f" to the value of (* e e) = 160000
; step 4: (d + e + f) = (20 + 400 + 160000) = 160420

; (iii)
;(define g 10)
;(define h (+ g i))
;(define i (* g 2))

;(+ g h i)

; I is not defined in the second line so thats why there is an error. But we are going to perseverre
; step 1: g=10
; step2: h = 30
; step 3: i = 20
; step 4: 10 + 30 + 20

; (iv)
(define j 10)
(define k (+ j 1))
(define l (* k 2))

(+ j k)
; step 1 j=10
; step 2 k=10+1=11
; step 3 l=11*2=22
;step 4 10+11=21


; well formed expressions consist of a identifier followed by either a number or a string
;  well formed programs consists of statements
; well formedd statements start with "define" which binds a value to an identifier