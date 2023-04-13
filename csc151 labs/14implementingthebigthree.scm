;; CSC 151 (SEMESTER))
;; Lab: Implementing the Big Three
;; Authors: billy cherres, Sam Bigham
;; Date: 10/12/22
;; Acknowledgements:
;;   ACKNOWLEDGEMENTS HERE

;; Whew! We've spent a solid week and a half drilling recursive design 
;; techniques over lists and the natural numbers. But this only the beginning!
;; We will deepen our knowledge of recursive design throughout the remainder
;; course as we explore more intricate and complex problems. As a starting
;; point in this conversation, we'll look at the patterns of recursion that
;; we have developed so far and how they relate to the "big three" operations
;; over lists we encountered earlier in the course.

;; -------------------------
"Problem 1: Transformations"
;; -------------------------

;; Consider the following pair of recursive functions:

;;; (double lst) -> list?
;;;   lst: list? of numbers
;;; Returns lst but with every element of lst doubled.
(define double
  (lambda (lst)
    (match lst
      [null null]
      [(cons head tail) (cons (* 2 head) (double tail))])))

(test-case "double empty"
           equal?
           null
           (double null))

(test-case "double non-empty"
           equal?
           (list 0 2 4 6 8)
           (double (range 5)))

;;; (flip lst) -> list?
;;;   lst: list? of booleans
;;; Returns lst but with every element of lst flipped, i.e., #t becomes #f
;;; and #f becomes true
(define flip
  (lambda (lst)
    (match lst
      [null null]
      [(cons head tail) (cons (not head) (flip tail))])))

(test-case "flip empty"
           equal?
           null
           (flip null))

(test-case "flip non-empty"
           equal?
           (list #t #f #f #t #t #f)
           (flip (list #f #t #t #f #f #t)))

;; (Partner A drives!)
;;
;; Follow the style of these two functions to write a similar, third function
;; called digits->nums. (chars->codepoints lst) takes a list of characters as
;; input and returns a list where each character has been turned into its
;; integer codepoint value. For example:
;;
;; (chars->codepoints (list #\a #\0 #\; #\q #\!))
;; > (list 97 48 59 113 33)
;; (chars->codepoints null)
;; > null

; empty list: returns null
; non empty list: turns the uncide of the characters

; (chars-codepoints lst): list
; lst: list
; returns uniode of chaaracters in form of a list
(define chars->codepoints
  (lambda (lst)
  (match lst
  [null null]
  [(cons head tail) (cons (char->integer head) (chars->codepoints tail))]
  
  )
  ))
(test-case "non empty list" equal? (list 97 48 59 113 33) (chars->codepoints (list #\a #\0 #\; #\q #\!)))
(test-case "null" equal? null (chars->codepoints null))


;; (Partner B drives!)
;;
;; At this point, you should have noticed some redundancy between the
;; three implementations of these functions. In the space below, note which
;; parts of the three functions are shared and what is different between them.
;;
;; Shared: they all have match nnull null and cons head tail
;;
;; Different: what we do with the head is different in every function
;;
;; Before* 2 functions, let's do exactly what we learned at the beginning of this
;; course: write a function that factors out these differences. It turns out
;; that this function is precisely the map function over lists! Follow your
;; nose and implement the map function over lists by factoring out the
;; essential difference in the implementations above and making it a parameter
;; to your function. You should arrive at precisely the same function signature
;; as the Prelude map function. Give test cases for your implementation of map,
;; list-map, that show how you can use list-map to implement the behavior of
;; the three specialized functions above.

;; TODO: add documentation!
(define list-map
 (lambda ( conversion lst )
 (match lst
 [null null]
 [(cons head tail)(cons (conversion head)(list-map conversion tail))]
 )
 ))

(define doublept2
 
(list-map (lambda (n) (* 2 n)) (list 1 2 3 4)))
doublept2

(define flippt2
(list-map not (list #f #t #t #f #f #t))
)
flippt2

(define chars->codepointspt2
(list-map char->integer (list #\a #\0 #\; #\q #\!)))

(test-case "chars->codepointspt2" equal? (list 97 48 59 113 33) chars->codepointspt2)
(test-case "doublept2" equal? (list 2 4 6 8) doublept2)
(test-case "flippt2" equal? (list #t #f #f #t #t #f) flippt2)

chars->codepointspt2
;; TODO: add tests for list-map that implement the behavior of the three
;; example functions from before!

;; ------------------
"Problem 2: Deletion"
;; ------------------

;; Let's play the same game of observing similarities between functions and
;; factoring out the differences to create a new function! Consider these
;; specialized functions:

;;; (dropzeroes lst) -> list?
;;;   lst: list? of numbers
;;; Returns lst but with every zero removed from lst.
(define dropzeroes
  (lambda (lst)
    (match lst
      [null null]
      [(cons head tail)
       (if (zero? head) (dropzeroes tail)
                        (cons head (dropzeroes tail)))])))

(test-case "dropzeroes empty"
           equal?
           null
           (dropzeroes null))

(test-case "dropzeroes non-empty"
           equal?
           (list 1 1 2 1)
           (dropzeroes (list 1 0 0 1 2 0 1 0)))

;;; (length-less-than-five lst) -> list?
;;;   lst: list? of strings
;;; Returns lst but with every element with length greater than or equal to
;;; five removed from the output.
(define length-less-than-five
  (lambda (lst)
    (match lst
      [null null]
      [(cons head tail)
       (if (>= (
         head) 5) (length-less-than-five tail)
                                       (cons head (length-less-than-five tail)))])))

(test-case "length-less-than-five empty"
           equal?
           null
           (length-less-than-five null))

; (test-case "length-less-than-five non-empty"
;            equal?
;            (list "abba" "doo!")
;            (length-less-than-five (list "abba" "yabba" "dabba" "doo!")))




;; (Partner B drives!)
;;
;; Follow the style of these two functions to write a similar, third function
;; called dropfalses. (dropfalses lst) takes a list of booleans as input and
;; and returns a lst but with all the #f values removed from the result. For
;; example:
;;
;; (dropfalses (list #t #t #f #f #f #t #f #t))
;; > (list #t #t #t #t)
;; (dropfalses null)
;; > null

;; if empty list returns null
;; if non empty list, returns list but  (equal?  head #f)with #f removed
;; (drop-falses lst) -> list
;; lst : list (list of booleans)
(define drop-falses
  (lambda (lst)
    (match lst
      [null null]
      [(cons head tail)
       (if (equal?  head #f) (drop-falses tail)
                                       (cons head (drop-falses tail)))])))


(test-case "non empty" equal? (list #t #t #t #t) (drop-falses (list #t #f #f #t #t #f #t)))
(test-case "empty" equal? (list null) (drop-falses (list null)))

;; (Partner A drives!)(list-)

;; Different:the  of the if statement. 
;;
;; Check your work with a member of the course staff!
;;
;; Once you know the essential difference between these three functions, create
;; the list-filter function that factors out this redundancy. list-filter
;; should behave indentically to the filter function when you are done!

; (list-filter eqa lst ): any
; eqa : function
; list list
; ; retunrs the answer to a function call based off the function and list given

(define list-filter
  (lambda (eqa  lst)
    (match lst
      [null null]
      [(cons head tail)
       (if (eqa head ) (list-filter eqa tail)
                                       (cons head (list-filter eqa  tail)))])))


    
    "help me"
    (test-case "less than 5" equal? (list "abba" "doo!")
     (list-filter (lambda(x) (>= (string-length x) 5)) (list "abba" "yabba" "dabba" "doo!")))





(define lessthan5
(list-filter (lambda (n) (>= (string-length n) 5 )) (list "abba" "yabba" "dabba" "doo!")))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; TODO: add tests for list-filter that implement the behavior of the three
;; example functions from before!

;; -------------------
"Problem 3: Reduction"
;; -------------------

;; At this point, there's one function left to write from the big three---fold!
;; Let's, again, follow the same procedure: write some specific functions and
;; generalize from there. Here are two examples:

;; (sum-with-init result lst) -> number?
;;   result: number?
;;   lst: list? of numbers
;; Returns the sum of the numbers in lst, starting with result as the initial
;; value.
(define sum-with-init
  (lambda (result lst)
    (match lst
      [null result]
      [(cons head tail)
       (sum-with-init (+ head result) tail)])))

(test-case "sum-with-init empty"
           equal?
           22
           (sum-with-init 22 null))

(test-case "sum-with-init non-empty?"
           equal?
           50
           (sum-with-init 11 (list 27 2 10)))

;; (cons-onto-backwards result lst) -> list?
;;   result: lst?
;;   lst: list?
;; Returns the result of consing lst onto the front of result backwards.
(define cons-onto-backwards
  (lambda (result lst)
    (match lst
      [null result]
      [(cons head tail)
       (cons-onto-backwards (cons head result) tail)])))

(test-case "cons-onto-backwards empty"
           equal?
           (list 1 2 3)
           (cons-onto-backwards (list 1 2 3) null))

(test-case "cons-onto-backwards non-empty?"
           equal?
           (list 7 6 5 4 1 2 3)
           (cons-onto-backwards (list 1 2 3) (list 4 5 6 7)))

;; (Partner A drives!)
;;
;; Follow the style of these two functions to write a similar, third function
;; called string-append-backwards. (string-append-backwards result lst) takes
;; an initial string value, and a list of strings as input and returns the
;; strings of the list appended onto the front of the initial string in
;; backwards order. Note that the order of the individual characters in each
;; string is preserved, but they are appended in backwards order. For example:
;;
;; (string-append-backwards "abc" (list "def" "h" "gi"))
;; > "gihdefabc"
;; (string-append-backwards "abc" null)
;; > "abc"
"hhhhhhhhhhh"
(define string-append-backwards
  (lambda (result lst)
    (match lst
      [null result]
      [(cons head tail)
       (string-append-backwards (string-append head result) tail)])))


(string-append-backwards "abc" (list "def" "h" "gi"))
;; TODO: write test cases!
(test-case "backwards works" equal? "gihdefabc" (string-append-backwards "abc" (list "def" "h" "gi")))
(test-case "null" equal? "abc" (string-append-backwards "abc" null))
;; (Partner B drives!)
;;
;; Like the previous problems, first identify what is shared and different
;; between these three functions:
;;
;; Shared: <everything from the lambda to the cons head tail>
;;
;; Different: <the names , and the argument after the cons head tail>
;;
;; Again, check your work with a member of the course staff!
;;
;; Once you know the essential difference between these three functions, create
;; the list-foldl function that factors out this redundancy. list-foldl
;; should behave indentically to the foldl function when you are done!

;;( list-foldl f l): any?
;; f: function?
;; l : list?

; retunrs the answer to a function call based off the function and list given
(define list-foldl
 (lambda (result lst argument)
 (match lst
 [null result]
 [(cons head tail)
 (list-foldl (argument head result) tail argument)])))

(test-case "string-back" equal? "gihdefabc" (list-foldl "abc" (list "def" "h" "gi") string-append))
(test-case "cons-onto" equal? (list 7 6 5 4 1 2 3) (list-foldl (list 1 2 3) (list 4 5 6 7) cons))
(test-case "sumwithinit" equal? 50 (list-foldl 11 (list 27 2 10) + ))



;; ----------------------------
"Problem 4: Really, Reductions"
;; ----------------------------

;; (Partner A drives!)
;;
;; In our discussion of list transformations, rather than foldl, we introduced
;; reduce first! Reduce is similar to foldl but instead of providing an initial
;; value, we use the first element of the list as the initial value.
;;
;; Implement list-reduce below in terms of list-foldl. It should be
;; functionality identical to reduce when you are done!

;;( list-reducef l): any?
;; f: function?
;; l : list?
; retunrs the answer to a function call based off the function and list given
(define list-reduce
  (lambda (f l)
    (match l
    [(cons head null) head]
    [(cons head tail)(f (list-reduce f tail) head)]
    )))
(test-case "string-append" equal? "gihdef"(list-reduce string-append (list "def" "h" "gi")))
(test-case "+" equal? 6 (list-reduce + (list 1 2 3)))

;; With implementations of list-foldl and list-reduce in hand, you should
;; be in a better position to now talk about when you would use foldl versus
;; reduce. Based on your implementation, give 2 reasons when you would choose
;; foldl versus reduce:
;;
;; <TODO: write down your 2 reasons here>
;; 1. ... Foldl is more clear and easy to read
;; 2. ... Foldl is more versatile and you it has a starting element you can choose

; --------------------------
"Problem 5: That's Backwards"
;; --------------------------

;; (Partner B drives!)
;;
;; Awkwardly, foldl seems to "reverse" our computations. In our above examples
;; we saw that cons-onto and string-append operated in a backwards fashion
;; when implemented with foldl. Use your implementations to compare
;; how foldl operates between sum-on-init and string-append-backwards. Trace
;; through an example execution of each function to highlight these differences
;; below:
;;
;  (sum-with-init 11 (list 27 2 10))
;; --> ... (+ 11 (list 27 2 10))
; `       (+ 11 27 (list 2 10))
;;         (+ 11 27 2 10 (list null))
;;          50
;;
;; (string-append-backwards "abc" (list "def" "h" "gi"))
;; --> ... (string-append ghi (string-append-backwards "abc" (list "def" "h" ) )
;;      (string-append ghih (string-append-backwards "abc" (list "def" ) )
;;    (string-append ghihdef (string-append-backwards "abc"  )
;;    ;;    (string-append ghihdefabc)
;;
;; In a sentence or two, explain why string-append-backwards performs its
;; "backwards" behavior but sum-with-init seems to work as expected.
;;
;sum with init is numbers and tring to find the sum of a number does not matter even if the numbers are in different orders
; String append does matter on the order at which the string is appended unlike inding th esum of a number

;; foldl works through the elements of the list in a left-to-right fashion.
;; Counterintuitively, this results in backwards behavior! To get the desired
;; behavior for string-append, we need to go through the elements in
;; right-to-left fashion. This is a variant of fold call foldr!
;;
;; Implement list-foldr below which should behave functionally identically to
;; foldr when you are done. Implement this function using recursion without
;; appealing to any additional functions from the standard library, e.g.,
;; reverse.
;;
;; Note, in foldl, we assumed that the function behaved as follows:
;;
;; + The first argument is the accumulated result.
;; + The second argument is an element of the list.
;;
;; For foldr, we traditionally switch the order of arguments so the first
;; argument is the element from the list and the second is the accumulated
;; result. We'll see why this is useful shortly!
;;
;; (Hint: think about how you integrated the head of the list into the result
;; in foldl. To get the desired effect for foldr, you should integrate the
;; head into the result in the other possible way!

;;( list-foldr f l): any?
;; f: function?
;; l : list?
; retunrs the answer to a function call based off the function and list given
(define list-foldr
  (lambda ( f l)
  (match l
  [(cons head null) head ]
  
    [(cons head tail)(f (list-reduce f tail))]
  
  )
  
  
  
  ))
 
(test-case "string-append" equal? "gih"(list-foldr string-append (list "def" "h" "gi")))
(test-case "+" equal? 5 (list-foldr + (list 1 2 3)))

;; Finally, let's compare the behavior of foldl and foldr. If f is the
;; function we're folding over, init is the initial value, and
;; x1, ..., xk are the values of the list in l, there are two ways that
;; we can combine everything together to get the fold:
;; fold r because the head is at the beggining of the tracing call
;; f(x1, f(x2, f(x3, f(..., f(xk, init)))))
;; 
;; or
;; fold l becaue the head is at the end of the tracing call
;; f(f(f(f(f(init, x1), x2), x3), ...), xk)
;;
;; Above, label each of the computations as either the foldl computation
;; or the foldr computation along with a sentence explaining why.
