
;; CSC 151 (SEMESTER)
;; Lab: Counting Operations (counting-operations.scm)
;; Authors: billy cherres Talia Foley
;; Date: THE DATE HERE
;; Acknowledgements:
;; ACKNOWLEDGEMENTS HERE

;; In today's reading, we explored the idea of characterizing the efficiency
;; of a program by counting the number of function calls it makes. We did this
;; via step-by-step execution with the exploration's panel as well as using
;; side-effects to maintain a mutable vector of function calls.
;;
;; For today's lab, you'll repeat the same endeavour for the list reversal
;; functions given in the reading.

;; +-------------------------------+-------------------------------------------
;; | List reversal implementations |
;; +-------------------------------+

; TODO: for problem 2, you will need to introduce a top-level vector to
; store counts of function calls here!

;;; (list-append l1 l2) -> list?
;;; l1, l2 : list?
;;; Returns the list formed by placing the elements of l2 after the elements
;;; of l1, preserving the order of the elements of l1 and l2.
(define list-append
  (lambda (l1 l2)
    (cond
      [(null? l1) l2]
      [else
        (cons (car l1)
          (list-append (cdr l1) l2))])))

;;; (list-reverse lst) -> list?
;;; lst : list?
;;; Returns a list with the elements of lst in the opposite order.
(define list-reverse-1
  (lambda (lst)
    (match lst
      [null null]
      [(cons head tail)
        (list-append (list-reverse-1 tail) (list head))])))

(define list-reverse-2-helper
  (lambda (so-far remaining)
    (match remaining
      [null so-far]
      [(cons head tail)
        (list-reverse-2-helper (cons head so-far) tail)])))

;;; (list-reverse lst) -> list?
;;; lst : list?
;;; Returns a list with the elements of lst in the opposite order.
(define list-reverse-2
  (lambda (lst)
    (list-reverse-2-helper null lst)))

(list-reverse-2 (list 1 2 3 4))
;; ---------------------------------------------------
"Problem 1: Understanding the list reversal functions"
;; ---------------------------------------------------

;; (Partner A drives!)
;;
;; Before we analyze the efficiency of the two list reversal functions,
;; list-reverse-1 and list-reverse-2, we should understand how they operate.
;; Let's begin with list-reverse-1. Review the code for list-reverse-1,
;; try out some test cases in the space below, and once you have a sense of
;; how the function works, fill out the recursive skeleton below.

; TODO: write code to explore list-reverse-1 here.

;; To reverse a list:
;; + When the list is empty: we will return null
;; + When the list is non-empty: return a list of elements in the opposite order
;; (Partner B drives!)
(test-case "list of integers" equal? (list 3 2 1) (list-reverse-1 (list 1 2 3)))
(test-case "null" equal? null (list-reverse-1 (list )))
(test-case "different types" equal? (list "b" "a" 2 1) (list-reverse-1 (list 1 2 "a" "b" )))
;; Now, let's take a look at list-reverse-2. While list-reverse-1 has a
;; standard recursive skeleton, list-reverse-2 employs the husk/kernel
;; pattern where the "work" of the function is done by a helper function,
;; list-reverse-2-helper. Let's focus on the helper function first. Review
;; the code for list-reverse-2-helper, try out some tests cases, and when
;; you are ready, fill out the recursive skeleton below.

; TODO: write code to explore list-reverse-2-helper here:

;; To help reverse a list with so-far:
;; + When the list is empty: returns null
;; + When the list is non-empty: returns a list of elements in the opposite order

;; Finally, in a sentence or two, describe why list-reverse-2's implementation,
;; which simply calls list-reverse-2-helper, works to reverse a list.
;;
(test-case "list of integers 2" equal? (list 3 2 1) (list-reverse-2-helper null (list 1 2 3)))
(test-case "null 2" equal? null (list-reverse-2-helper null (list )))
(test-case "different types" equal? (list "a" 2 1) (list-reverse-2-helper null (list 1 2 "a")))
;; ---------------------------------------
"Problem 2: Counting, counting, counting!"
;; ---------------------------------------

;; (Partner A drives!)
;;
;; Now that we understand how the functions work, let's instrument our code
;; as in the reading to count the number of function calls each reversal
;; implementation makes. Feel free to use some of the helper functions
;; introduced in the reading to clear and increment counters easily. You
;; should instrument the functions so that calls to the helper functions,
;; i.e., list-append and list-reverse-2-helper, are counted under their
;; respective "main" functions, i.e., list-reverse-1 and list-reverse-2.
;;
(define increment
  (lambda (vec i)
    (vector-set! vec i (+ 1 (vector-ref vec i)))))



(define reset
  (lambda (vec)
    (vector-fill! vec 0)))

(define count (vector 0 0))

(define list-append
  (lambda (l1 l2)
    (begin (increment count 0)
      (cond
        [(null? l1) l2]
        [else
          (cons (car l1)
            (list-append (cdr l1) l2))]))))

(define list-reverse-1-count
  (lambda (lst)
    (begin (increment count 0)
      (match lst
        [null null]
        [(cons head tail)
          (list-append (list-reverse-1 tail) (list head))]))))


(define list-reverse-2-helper-count
  (lambda (so-far remaining)
    (begin (increment count 1)
      (match remaining
        [null so-far]
        [(cons head tail)
          (list-reverse-2-helper-count (cons head so-far) tail)]))))

(define list-reverse-2-count
  (begin (increment count 1)
    (lambda (lst)
      (list-reverse-2-helper-count null lst))))


;; Next, in the space below, use your instrumented functions to count the number
;; of operations each implementation on no less than five different lists
;; of varying sizes and contents.
(list-reverse-1-count (list 1 ))
(list-reverse-2-count (list 1 ))
count
(reset count)
(list-reverse-1-count (list 1 3 4 5 6 7))
(list-reverse-2-count (list 1 3 4 5 6 7))
count 
(reset count)

(list-reverse-1-count (list ))
(list-reverse-2-count (list ))
count
(reset count)
(list-reverse-1-count (list "a" "b" "c"))
(list-reverse-2-count (list "a" "b" "c"))
count
(reset count)
(list-reverse-1-count (list "a" 2 "b" "c" 1))
(list-reverse-2-count (list "a" 2 "b" "c" 1))
count
(reset count)
(list-reverse-1-count (list "a" 2 "b" "c" 1 1 1 1 1 1  1 1  1 1 1  1 1 1 1 1 1 1 1 1 1  1 1  1 1 1  1 1 1 1 1 1 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1 1  1 1  1 1 1  1 1 1 1))
(list-reverse-2-count (list "a" 2 "b" "c" 1 1 1 1 1 1  1 1  1 1 1  1 1 1 1 1 1 1 1 1 1  1 1  1 1 1  1 1 1 1 1 1 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1 1  1 1  1 1 1  1 1 1 1))
count
(reset count)
(list-reverse-1-count (list "a" 2 "b" "c" 1 1 1 1 1 1  1 1  1 1 1  1 1 1 1 1 1 1 1 1 1  1 1  1 1 1  1 1 1 1 1 1 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1  1 1  1 1 1  1 1 1 1))
(list-reverse-2-count (list "a" 2 "b" "c" 1 1 1 1 1 1  1 1  1 1 1  1 1 1 1 1 1 1 1 1 1  1 1  1 1 1  1 1 1 1 1 1 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1  1 1  1 1 1  1 1 1 1))
count
(reset count)
(length (list "a" 2 "b" "c" 1 1 1 1 1 1  1 1  1 1 1  1 1 1 1 1 1 1 1 1 1  1 1  1 1 1  1 1 1 1 1 1 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1  1 1  1 1 1  1 1 1 11 1 1 1 1  1 1  1 1 1  1 1 1 1))

(list-reverse-1-count (range  51 ))
(list-reverse-2-count (range  51 ))
count
(reset count)
;; (Partner B drives!)
;;
;; First, answer this quick question regarding how you test reverse. Does it
;; matter what the specific values of the input lists are, e.g., particular
;; numbers or strings? In a sentence or two, answer why or why not:
;;
;; TODO: it should not matter the type of the value because all data types are handled the same when using the reverse function/implementation

;;
;; Continue to use your instrumented functions to count the number of operations
;; for a few additional runs. Write your results in the table below: the size
;; of the input list in the first column and the number of counts in the
;; subsequent columns:
;;
;; size of list (n) | list-reverse-1 | list-reverse-2
;; ----------------------------------------------------------
;; 0                 |       1        |      1
;; 1                 |       2        |      3
;; 3                 |       7         |      4
;; 5                 |       16         |      6
;; 6                 |         22       |      8
;; 50                 |        1327         |      52
;; 77                 |       3004         |      78
;; 103                 |       5357         |      104
;; From your table, graph the resulting data with the list size on the x-axis
;; and the number of function calls for list-reverse-1 and list-reverse-2 on
;; the y-axis as two separate curves. From this data, answer the following
;; questions in a sentence or two each:
;;
;; 1. What class of arithmetic function does the number of function calls for
;; list-reverse-1 and list-reverse-2 each approximate as a function of the
;; input list size? For example, does the count of function calls that
;; list-reverse-1 make approximate a constant function (f(n) = c), a linear
;; function (f(n) = n), or a quadratic function (f(n) = n^2)?
; list reverse 1 : exponential function
; list reverse 2 is a linear function
;;
;; 2. When the input list size is small (say n = 10 elements or less), does
;; it matter which reversal function we use? Why or why not? 
; 5 elements or less there is a small difference between the 2 functions
; by 10 elements the difference is a bit more noticiable
;; 3. When the input list size is large (say n = 1000000 elements or more),
;; does it matter which reversal function we use? Why or why not?

;  When the input list size is large then list reverse 1 will take up significantly more storage and time to execute than list reverse 2