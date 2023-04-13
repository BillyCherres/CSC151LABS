;; CSC-151 (SEMESTER)
;; Lab: More Fun with Lists
;; Authors: Wallis Shepard Noor Yahyaoui Billy Cherres
;; Date: october 2nd 2022
;; Acknowledgements:
;;   ACKNOWLEDGEMENTS HERE

(import image)

; +-------------+----------------------------------------------------
; | Preparation |
; +-------------+

; In this lab, you and your partner will practice manipulating lists
; using the big-three higher-order functions: map, filter, and reduce.
; There are five exercises; here's the division.

; Exercise 1: A-Side
; Exercise 2: B-Side
; Exercise 3: A-Side
; Exercise 4: B-Side
; Extra 1: Both; Not to be turned in.

; The person with the problem description should drive and their
; partner should navigate.  Again, make sure to be good partners and
; focus completely on solving the current problem together rather than
; working ahead on your own.


; +---------------------------------+--------------------------------
; | Exercise 1: Manipulating a list |
; +---------------------------------+

; (Side A drives)

; Complete each of the definitions that manipulate ex-1-list in various sorts
; of ways using one or more of the big three functions.  You may also use the
; other standard library functions for lists (e.g., length) when appropriate.

(define ex-1-list (list 25 25 23 5 21 20 20 18 10 1 22 21))

; Increments the value of each element of the list `ex-1-list` by 5
(define ex-1-list-adjusted (map (lambda (l) (+ l 5)) ex-1-list))
ex-1-list-adjusted
; (test-case "Adjusting the list"
;            equal?
;            ex-1-list-adjusted
;            (list 30 30 28 10 26 25 25 23 15 6 27 26))

; Keeps only the elements of the list that are greater than 10.
(define ex-1-list-filtered (filter (lambda (l) (> l 10)) ex-1-list))
; (test-case "Filtering the list"
;            equal?
;            ex-1-list-filtered
;            (list 25 25 23 21 20 20 18 22 21))
ex-1-list-filtered
; Computes the average of the list (Hint: this computation is more
; than just a single reduce call!)

(define exlist (list 1 2 3))
(define ex-1-list-average (/ (reduce + exlist) (length  exlist)))
; (test-case "Averaging the list"
;            equal?
;            ex-1-list-average
;            (/ 211 12))
ex-1-list-average
; +----------------------------------+-------------------------------
; | Exercise 2: Higher-order corners |
; +----------------------------------+

; (B side drives!)

; Suppose we want to add 5 to every element of a list.  Some of you
; may have tried the following.

;  (define numbers (list 3 1 4 1 5 9 2 6))
; (define numbers-plus-5a (map + numbers 5))

; a. Why doesn't that work?
; the function mapped on to the list need to be a function that takes in a value and adds 5 to the value. 
; In this situation, map is taking in 3 arguments which will not work at the end of the day

; b. Correct the mistake in the previous definition when defining
; numbers-plus-five-b. (Hint: make sure you use a lambda expression
; as the function passed to map!)

(define numbers (list 3 1 4 1 5 9 2 6))
(define numbers-plus-five-b (map (lambda (l) (+ 5 l) )numbers ))
numbers-plus-five-b

; c. Provide an alternative implementation with numbers-plus-five-c
; where you use two lists and the multi-list form of map to perform
; the repeated addition.

(define numbers-plus-five-c1
  (map + (make-list (length numbers) 5) numbers))
numbers-plus-five-c1

; d. Which of those definitions do you most prefer?  Why?
; the second definition is more efficient because if you manipulate the list "numbers", then the (make-list) function will adjust to it

; +------------------------------------+-----------------------------
; | Exercise 3: Party people revisited |
; +------------------------------------+

; (A side drives)

; One of the things that `map` allows us to do is perform repetitive
; behavior.  We'll demonstrate this by generalizing one of the images
; we created in our first lab on decomposition and then using our list
; functions to generate repeated instances of that images.

; a. Recall in the first exercise of our decomposition lab
; you created an image that consisted of five people with party hats.
; Using this code as a base, write a function `(party-person scale)`
; that draws a single person, *i.e.*, a person with a party hat but
; scales the person's width and height by a factor of `scale`.  For example:

; + If `scale` is `1`, then the image is drawn at its original dimensions.
; + If `scale` is `0.5`, then the image is drawn at half size.
; + If `scale` is `2`, then the image is drawn at 2x size.

; Note: You should not use anything new for this part of the exercise.
; Just return to the days of old, when we were generalizing individual
; images to procedures.

(define original-party-person
  (above (triangle 20 "solid" "green")
         (circle 20 "outline" "black")
         (rectangle 10 40 "solid" "black")))
original-party-person

(define party-person
  (lambda (scale)
    (above (triangle (* scale 20) "solid" "green")
         (circle (* scale 20) "outline" "black")
         (rectangle (* scale 10) (* scale 40) "solid" "black"))))
(party-person 2)
; double the size
; b. Using `map` and `party-person` define a *list of images* called
; `party-list` that consists of six party people scaled by the following
; factors.

    ; 1.5, 1, 0.25, 2, 1.75, 0.5

; Hint: start with a list of these scaling factors as a list of fractions.
; What functions can we use in combination to transform this list of factors 
; into a list of images?

(define party-list 
(map 
(lambda (scale)
    (above (triangle (* scale 20) "solid" "green")
         (circle (* scale 20) "outline" "black")
         (rectangle (* scale 10) (* scale 40) "solid" "black")))
(list 1.5 1 0.25 2 1.75 0.5)))
party-list 

; c. You might notice that the type of `party-list` isn't quite an
; image. To see this, attempt to rotate `party-list` using the `rotate`
; function. In the space below, report the error you receive and in a
; sentence or two explain what the problem is!

(rotate 90 party-list)

; rotate is expecting a drawing but a pair was given. Map returns a list not a drawing so you can't do drawing fucntions on a list unless you use reduce or apply

; d. To fix the problem, we need to combine the images of `party-list`
; into a single image.  To do so, we should use `beside` to place
; each person beside each other.  However, we can't just use `beside`
; directly with `party-list`.  Doing so should result in yet another
; error!  In the space below, report the error and in a sentence or
; two explain the problem!

 ( beside party-list)

; the error is given because beside is expecting a drawing but a pair was given. 

; e. As you might expect, it turns out that the fix is to use the
; `apply` function which takes a function `f` and a list of values
; as input and returns the result of applying `f` to the values of
; the list.  Use `apply` to complete the definition of `party` below
; and verify that it produces what you expect.  

; Please use `beside` and not `beside/align`.

(define party (apply beside party-list))
party
; f. It's also possible to do this with `reduce` rather than `apply`.
; (At least it should be.)  Try doing so.  Once again, please use
; `beside` rather than `beside-align`.

(define party-f (reduce beside party-list))
party-f
; g. Try using `reduce` with `beside/align` rather than `beside` to align
; the partygoers along the baseline.

; Note: You can't just write

;     (reduce beside/align 'baseline party-list)

; Remember: `reduce` needs a two-parameter procedure, so you'll need
; to build one from `beside/align`.

(define party-g 
(reduce 
(lambda (p1 p2) (beside/align "bottom" p1 p2))
party-list
))
party-g 
; +------------------------------------+-----------------------------
; | Exercise 4: Exercises in reduction |
; +------------------------------------+

; a. What does the following procedure do?
; the following procedure combines string 1 string 2 and then string 1 again

(define combine
  (lambda (s1 s2)
    (string-append s1 " and " s2 " and " s1)))

; b. What value do you expect to get for the following expressions?
; Check each as you go.

(define combine-2 (reduce combine (list "A" "B")))
(list "A and B and A")
combine-2
(define combine-1 (reduce combine (list "A")))
(list "A")
combine-1
(define combine-3-left (reduce combine (list "A" "B" "C")))
"A and B and A and C and A and B and A"
combine-3-left
(define combine-3-right (reduce-right combine (list "A" "B" "C")))
"A and B and C and B and A"
combine-3-right
(define left-and-right (equal? combine-3-left combine-3-right))
"false"
left-and-right
; c. What values do you expect for all-the-same below?  Why?
; Don't check yet!  Wait until you get to part d.

(define combine-abcde-1 (reduce combine (list "A" "B" "C" "D" "E")))

(define combine-abcde-2 (reduce combine (list "A" "B" "C" "D" "E")))

(define combine-abcde-3 (reduce combine (list "A" "B" "C" "D" "E")))

(define all-the-same 
   (and (equal? combine-abcde-1 combine-abcde-2)
        (equal? combine-abcde-1 combine-abcde-3)
        (equal? combine-abcde-2 combine-abcde-3)))
  "true"
  all-the-same 

; d. Check your answer experimentally.  That is, print out the value
; of `all-the-same` and see if it's what you expected.

; e. From these examples, summarize the differences in behavior between reduce
; and reduce-right. If you need more guidance, try augmenting the examples
; so it is more clear what the order of operations are for each call.

; i would say that the differences in behavior between reduce right and reduce are that reduce right would go through the list less then reduce would. 

; +----------------------+-------------------------------------------
; | Submitting your work |
; +----------------------+

; Congratulations on finishing this lab!  To turn in your work:

; a.  If you're working online, combine the two parts into a single file.
; b.  Ensure that your file runs properly.
; c.  Make sure you save as `lists-more.scm` using 
;     File -> Save Other -> Save Definitions As Text...
; d.  Send this completed file to your partner for their records.
; e.  Submit this final file to Gradescope.  Make sure, if appropriate,
;     to submit your work as a group submission and include your
;     partner in the submission.