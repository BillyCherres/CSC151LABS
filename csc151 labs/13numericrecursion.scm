;; CSC 151 fall
;; Lab: Numeric Recursion (numeric-recursion.scm)
;; Authors: Sam Bigham billy cherres
;; Date: 10/10/2022
;; Acknowledgements:
;;   got code from osera website

(import image)

;; -------------------
"Problem 1: Replicate"
;; -------------------

;; (Partner A drives!)

;; Implement a recursive function (replicate v n) that takes a value v and
;; natural number n as input and returns a list that contains n copies of v.
;;
;; (replicate "q" 5)
;; > (list "q" "q" "q" "q" "q")
;; (replicate "hello" 0)
;; > (list)
;;
;; Make sure to give a recursive decomposition, docstring, and test suite
;; for the function.
;;
;; (Note that replicate is really another name for make-list, so you can
;; use make-list to write easily write test cases for your function).
;;
;; To replicate a value v n times:
;; + If n is zero... return  null
;; + If n is non-zero... return v n times

; (replicate v n): lst?
; v;  any?
; n: integer? greater than 0
; returns v replicated n times
(define replicate
  (lambda (v n)
  (match n
  [0 null]
  [_ (cons v (replicate v (- n 1)))]
  )))
(replicate "q" 4)
(test-case "postive integer" equal? (list "q" "q" "q" "q") (replicate "q" 4) )
(test-case "null" equal? null (replicate "q" 0))


;; -----------------
"Problem 2: Harmony"
;; -----------------

;; (Partner B drives!)

;; Implement a recursive function (harmonic-sequence-sum n) that takes a
;; natural number n as input and returns the sum of the first n terms of the
;; harmonic sequence. The harmonic sequence is defined as follows:
;;
;; 0 + 1/1 + 1/2 + 1/3 + 1/4 + 1/5 + ...
;;
;; (harmonic-sequence-sum 5)
;; > 2.283333333333333
;; (harmonic-sequence-sum 100)
;; > 5.187377517639621
;; (harmonic-sequence-sum 0) 
;; > 0
;;
;; Make sure to give a recursive decomposition, docstring, and test suite
;; for the function.
;;
;; The sum of the first n terms of the harmonic-sequence is:
;; + If n is zero... return 0
;; + If n is non-zero... <add 1/n to harmonic sequence of 1/n-1>

;;(harmonic-sequence-sum n); num
;;n --> integer n > 0
;;returns the harmonic sequence of n
(define harmonic-sequence-sum
  (lambda (n)
  (match n
  [0 0]
  [_ (+ (/ 1 n) (harmonic-sequence-sum (- n 1)))]
  
  )) )
(test-case "works" equal? 2.283333333333333 (harmonic-sequence-sum 5))
(test-case "0" equal? 0 (harmonic-sequence-sum 0))
;; --------------
"Problem 3: Drop"
;; --------------

;; (Partner A drives!)

;; Implement a recursive function (my-drop n l) that takes a list l and natural
;; number n and returns l, but with the first n elements of l removed. If
;; n is greater than the length of l, then null is returned.
;;
;; (my-drop 3 (range 10))
;; > (list 3 4 5 6 7 8 9)
;; (my-drop 0 (range 10))
;; > (list 0 1 2 3 4 5 6 7 8 9)
;; (my-drop 5 null)
;; > null
;;
;; For my-drop, you will need to decompose both n and l! Consequently, write
;; your recursive decomposition in terms of the 4 cases we have based on the
;; recursive definitions for natural numbers and lists. To pattern match on
;; both n and l at the same time, you can use pair them up, e.g., (pair n 
;; ) creates a pair of n and l that you can pattern match on with
;; cons as the pattern. It turns out that pair is just an alias for cons!
;;
;; (Note that my-drop is really the drop function provided in the standard
;; library. Feel free to use drop in your test cases!)
;;
;; To drop n elements from l:
;; <if 0 ; returns lst>
;; if nonzero, returns cdr list n times
;; (drop n lst) --> list
;; n: int? n > 0
;; n: list 
;; (returns the list but with the first n elements dropped)

(define drop
  (lambda (n lst)
  (match n
  [0 lst]
  [_  (drop (- n 1) (cdr lst))])))

(test-case "dropworks" equal? (list 3 4 5 6 7 8 9) (drop 3 (range 10)))
(test-case "null" equal? null (drop 0 (range 0)))
;; --------------
"Problem 4: Take"
;; --------------

;; (Partner A drives!)

;; Implement a recursive function (my-take n l) that takes a list l and natural
;; number n and returns the first n elements of l as a list. If n is greater
;; than l, then l is returned.
;;
;; (my-take 3 (range 10))
;; > (list 3 4 5)
;; (my-drop 0 (range 10))
;; > (list)
;; (my-drop 5 null)
;; > null
;;
;; Like my-drop, my-take will need to decompose both n and l. Your recursive
;; decomposition should have 4 cases based on the recursive definitions for
;; natural numbers nad lists.
;;
;; (Note that my-take is really the take function provided in the standard
;; library. Feel free to use take in your test cases!)
;;
;; To take n elements from l:
;; n is 0 : return null list
;; n > 0: add car lst to take (- n 1) times

;(take n lst): list?
; n : integer? greater than or equal to 0
; lst: list?
; returns the first n values of th elist
(define take
  (lambda ( n lst)
  (match n
  [0  null]
  [_ (cons (car lst) (take (- n 1) (cdr lst)))]
  )))
(take 3 (range 10))
(test-case "greater than 0" equal? (list 0 1 2) (take 3 (range 10)) )
(test-case "equal to 0" equal? null (take 0 (list 1 2 3)))
;; -------------------
"Problem 6: Triangles"
;; -------------------

;; Sierpinski triangles are a fractal drawing composed of a collection of
;; triangles nested inside of each other according to the following rules
;; (taken from: https://en.wikipedia.org/wiki/Sierpi%C5%84ski_triangle):
;; 
;; 1. Start with an equilateral triangle.
;; 2. Subdivide it into four smaller congruent equilateral triangles and
;;    remove the central triangle.
;; 3. Repeat step 2 with each of the remaining smaller triangles infinitely.
;;
;; Call each layer of Sierpinski triangles a level. At level 0, we draw no
;; triangles.
;;
;; Examples of Sierpinski Triangles for nesting level n = 1, n = 2, and n = 3
;; can be found on the webpage for this lab.
;;
;; Write a recursive function (sierpinski size color n) that draws n levels
;; of sierpinski triangles in a size × size drawing. Again, proceed by
;; numeric recursion, give a recursive decomposition and appropriate docstring.
;;
;; (Partner A, drive for the recursive decomposition of the function!)
;;
;; To draw n levels of Sierpinski Triangles:
;; + When n = 0: return a trinagle siz3 0
;; + When n > 0: aboves serspensky onto another serspensky beside triangle. when equal to 1 then put 1 triangle on the top
;;
;; (Partner B, drive for the implementation of the function!)

; (sierspinski size color n); image?
; size: integer greater than 0?
; color: string?
; n: integer?
; returns the seirspinksi triangles
(define sierpinski
  (lambda (size color n)
    (match n
    [0 (triangle (* 0 size) "solid" color)]
    [1 (triangle size "solid" color)]
    [_ 
    
    (above 
    (sierpinski size color (- n 1))
    (beside  (sierpinski size color (- n 1)) (sierpinski size color (- n 1))))]
    )))
(sierpinski 100 "red" 4)
; cant do test cases with functions that output images


;; ------------------------------
"Extra Problem: Fractal Drawings"
;; ------------------------------

;; Sierpinsky triangles are an example of a fractal, an infinitely recursive
;; drawing:
;;
;; https://en.wikipedia.org/wiki/Fractal
;;
;; There are many kinds of fractals out there! A simple example is the
;; Cantor set:
;;
;; https://en.wikipedia.org/wiki/Cantor_set
;;
;; Or the Koch snowflake:
;;
;; https://en.wikipedia.org/wiki/Koch_snowflake
;;
;; Try implementing a function that draws one of these recursive images to
;; an arbitrary level of depth. Or try designing your own fractal drawing using
;; the image library primitives!