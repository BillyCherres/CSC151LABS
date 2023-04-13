;; CSC 151 (Semester 1)
;; Lab: Local Bindings (local-bindings.scm)
;; Authors: Billy Cherres Boston Gunderson
;; Date: 09/12/2022
;; Acknowledgements:
;; ACKNOWLEDGEMENTS HERE

; In this lab, you and your partner will write some more complicated
; code than previous labs and manage that complexity with let-bindings.
; Side-A should drive first with Side-B navigating. Once you are
; done with Side A's exercises, you can switch roles and move to Side B's
; exercises. 

; You may find these are bit more involved than previous problems,
; so make sure to collaborate well together and work efficiently!


; +--------------------------------------+---------------------------
; | Exercise 1: Nesting let expressions. |
; +--------------------------------------+

; (A side drives)

; a. Write a *nested* `let`-expression that binds a total of five
; names, `alpha`, `beta`, `gamma`, `delta`, and `epsilon`. With
; `alpha` bound to the value 7, and each subsequent value to twice
; the previous value. That is, `beta` should be 2 times `alpha`, 
; `gamma` should be two times `beta`, , and so on and so forth. The
; body of the innermost `let` should make a list from those values.

; Your result will look something like this:

; (let ([___ ___])
  ; (let ([___ ___])
    ; (let ([___ ___])
      ; (let ([___ ___])
        ; (let ([___ ___])
          ; (list alpha beta gamma delta epsilon))))))

; The final value should be something like

; (list 7 14 28 56 112)

(define nested-let-7
  (let ([alpha 7])
    (let ([beta (* alpha 2)])
      (let ([gamma (* beta 2)])
        (let ([delta (* gamma 2)])
          (let ([epsilon (* delta 2)])
            (list alpha beta gamma delta epsilon)))))))

; b. Duplicate `nested-let-7` below but bind `alpha` to `(/ 1 3)`. The
; remaining name should still be bound to subsequently doubled versions
; of `alpha`. Observe how little of the code you need to change to make
; this work!

(define nested-let-1/3
  (let ([alpha (/ 1 3)])
    (let ([beta (* alpha 2)])
      (let ([gamma (* beta 2)])
        (let ([delta (* gamma 2)])
          (let ([epsilon (* delta 2)])
            (list alpha beta gamma delta epsilon)))))))

; c. Create a `let*`-expression equivalent to `nested-let-1/3` above.

(define nested-let*
  (let* ([alpha (/ 1 3)]
      [beta ( * alpha 2)]
      [gamma (* beta 2)]
      [delta (* gamma 2)]
      [epsilon (* delta 2)])
    (list alpha beta gamma delta epsilon)))

; d. It is likely that you came up with a solution to part b that
; looks something like the following.

; (let* ([alpha 1/3]
    ; [beta (* 2 alpha)]
    ; [gamma (* 2 beta)]
    ; ...)
  ; (list alpha beta gamma delta epsilon))

; What if you decided that instead of doubling each previous value, you
; wanted to add three to that value? You'll have four different
; expressions to change, which is annoying to modify in your code.

; Rewrite the expression to use the name `fun` for what needs to be done
; to each element of the list. Your expression should look something
; like the following.

; (let* ([fun (lambda (x) (* 2 x))]
    ; [alpha 1/3]
    ; [beta (fun alpha)]
    ; ...)
  ; ...)

(define nested-let*-fun
  (let* ([fun (lambda (x) (+ x 3))] [alpha (/ 1 3)]
      [beta ( fun alpha )]
      [gamma ( fun beta )]
      [delta (fun gamma )]
      [epsilon (fun delta )])
    (list alpha beta gamma delta epsilon)))

; e. Duplicate and modify nested-let*-fun so that `alpha` starts at 1
; and `fun` divides its parameter by 3. Before running your code,
; predict the result. Finally, check your answer experimentally.

(define updated-nested-let*-fun
  (let* ([fun (lambda (x) (/ x 3))] [alpha 1]
      [beta ( fun alpha )]
      [gamma ( fun beta )]
      [delta (fun gamma )]
      [epsilon (fun delta )])
    (list alpha beta gamma delta epsilon)))

updated-nested-let*-fun 
; +--------------------------------+---------------------------------
; | Exercise 2: Observing bindings |
; +--------------------------------+

; let* and let allow to perform the same behavior: binding local
; names to reduce redundancy in our programs. However, the way that
; they mechanically operate is different!
;
; Use the explorations pane to explore how let behaves versus let*
; in your various definitions. Answer the following questions in the
; space below:
;
; (a) What is the difference in how let binds names versus let*?
; (b) In general, we want to avoid binding names that will not be
; used. Such unused names potentially make our code less
; readable e.g., our future selves asking "why did I bind this
; name and not use it?"
;
; let* binds the expression and the value sequentially so you can use the value later on in an expression
; let evaluates all the expressions at the same time before binding them to the values


; With this in mind, in what situations do we want to prefer
; using let versus let*? Which of the two should be our "default"
; option when needing to bind local names?

; the default is up to you based of convienience

; +-------------------------------+----------------------------------
; | Exercise 3: Ordering bindings |
; +-------------------------------+

; In the reading, we noted that it is possible to move bindings outside
; of the lambda in a procedure definition. In particular, we noted
; that the first of the two following versions of years-to-seconds
; required recomputation of seconds-per-year every time it was called
; while the second required that computation only once.

; a. Confirm that both appear to work correctly.
; yes works correcly
; c. Using the explorations pane, confirm that years-to-seconds-a does,
; in fact, recompute the values each time it is called.
; yes it recompute the values each time it is called
; d. Confirm that years-to-seconds-b does not recompute the values each
; time it is called.
; it does not recompute the values each time it is called
; e. Given that years-to-seconds-b does not recompute each time, when
; does it do the computation?
; it does the computation when its bound

(define years-to-seconds-a
  (lambda (years)
    (let* ([days-per-year 365.24]
        [hours-per-day 24]
        [minutes-per-hour 60]
        [seconds-per-minute 60]
        [seconds-per-year (* days-per-year hours-per-day
            minutes-per-hour seconds-per-minute)])
      (* years seconds-per-year))))

(define years-to-seconds-b
  (let* ([days-per-year 365.24]
      [hours-per-day 24]
      [minutes-per-hour 60]
      [seconds-per-minute 60]
      [seconds-per-year (* days-per-year hours-per-day
          minutes-per-hour seconds-per-minute)])
    (lambda (years)
      (* years seconds-per-year))))

; +---------------------------+--------------------------------------
; | Exercise 4: Making change |
; +---------------------------+

; (B side drives)

; Write a function `(make-change cents)` that takes a positive integer
; as input and returns a list of four integers. These integers
; correspond to the number of quarters (25 cents), dimes (10 cents),
; nickels (5 cents), and pennies (1 cent) used to make change for
; `cents`. The amounts returned should reflect the *minimal number
; of coins* used to make up the desired number of cents. For example:

; > (make-change 118)
; (list 4 1 1 3)

; Note that the `list` function makes a list of values drawn from its
; arguments.

; The standard change-making algorithm is an example of an *greedy
; algorithm*. You compute the change by first figuring out the number of
; quarters to use, then the number of dimes, then nickels, and final
; cents, in-order. To do this, you will find the functions `quotient`
; and `remainder` useful.

; make-change takes cents value and returns lowest amount of coins
;divide by 25 then truncate to get the amount of quarters
;remainder the divide by 25 to get the remaining cents value
;divide by 10 then truncate to get the amount of dimes
;remainder the post quarter value by 10 to get the remaining cents after dimes
;divide the new value by 5 and then truncate to get the value of nickels
;remainder the post dime value by 5 to get the remaining pennies
;list the Quarters, Dimes, Nickels, Pennies

(define make-change
  (lambda (cents)
    (let* 
      ([Coins (lambda (RemainingValue CoinValue) 
        (truncate (/ RemainingValue CoinValue)))]
      [Quarters (Coins cents 25)]
      [DCents (remainder cents 25)]
      [Dimes (Coins DCents 10)]
      [NCents (remainder DCents 10)]
      [Nickels (Coins NCents 5)]
      [Pennies (remainder NCents 5)])
      (list Quarters Dimes Nickels Pennies))))
  





; Side note: While the greedy "use as many quarters as possible" works
; for this set of denominations of coins, it turns out that it doesn't
; work for all sets. Suppose, for example, that there were no nickles.
; If we wanted to make 30 cents, we should use three dimes. However,
; the greedy algorithm says to take a quarter, which would then require
; five pennies to make thirty cents. 

; In your spare time (not now), consider how you might handle issues 
; like that. (If you continue with the CS major, you'll learn an
; algorithm in either CSC 207 or CSC 301.)

; +-----------------------------+------------------------------------
; | Exercise 5: Nested bindings |
; +-----------------------------+

; a. There are two examples related to nested define expressions in
; the reading, entitled sample-w/let and sample-w/define. Copy them
; into your source file below and confirm that they work as described.

;from https://osera.cs.grinnell.edu/csc151/readings/local-bindings.html
; (define sample-w/let
;   (lambda (x)
;     (let ([x (+ x 1)])
;       (list x x x))))

; (define sample-w/define
;   (lambda (x)
;     (define x (+ x 1))
;     (list x x x)))

; b. Consider the following `sample2` procedure. 
;
; Trace the computation of `(sample2 10)`.
;
; (sample2 10)
; ---> 

; (list 10
;   (let ([x (+ 10 1)])
;     (list x)))))


;   ([let 11])
;     (list x)))))
; 
;     (list 11)
; 



; After answering, check your answer.

(define sample2
(lambda (x)
(list x
  (let ([x (+ x 1)])
    (list x)))))

;Error in code

; c. Consider the following definition of `sample3`. What do you
; expect the output of (sample3 10) to be?
;
; Check your answer experimentally.
;
;lambda (10)
; (list x
;   (let ([x (+ x 1)]
;       [y (+ x 1)])
;     (list x y)))))
;
; (list 10
;   (let ([x (+ 10 1)]
;       [y (+ 10 1)])
;     (list x y)))))


;   (let ([x 11]
;       [y 11])
;     (list x y)))))


;     (list 11 11)
; If your answer doesn't match, trace the computation.
;
; (sample3 10)
; ---> 
;

(define sample3
(lambda (x)
(list x
  (let ([x (+ x 1)]
      [y (+ x 1)])
    (list x y)))))
;error variable x is not defined?

; d. Consider the following definition of `sample4`. What do you
; expect the output of (sample4 10) to be?
;
; <TODO: ENTER YOUR ANSWER HER
;lambda (10)
; (list x
;   (let ([x (+ x 1)]
;       [y (+ x 1)])
;     (list x y)))))
;
; (list 10
;   (let ([x (+ 10 1)]
;       [y (+ x 1)])
;     (list x y)))))


;   (let ([x 11](define sample4
(lambda (x)
(list x
  (let* ([x (+ x 1)]
      [y (+ x 1)])
    (list x y))))
;     (list 11 y)))))

;     
;     (list 11 12)))))

; (sample4 10)
; ---> 
;returns (list 10 (list 11 12))

(define sample4
(lambda (x)
(list x
  (let* ([x (+ x 1)]
      [y (+ x 1)])
    (list x y)))))

; +-------------+----------------------------------------------------
; | Wrapping up |
; +-------------+

; Make sure that you save local-bindings.scm as a text file and submit
; that file on Gradescope.