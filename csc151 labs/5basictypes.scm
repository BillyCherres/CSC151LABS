
;; CSC 151 (SEMESTER)
;; Lab: Basic Types
;; Authors: Kevin Johanson Billy
;; Date: 9/7/22
;; Acknowledgements:
;;   ACKNOWLEDGEMENTS HERE

; In this lab you will be working with your partner to discover
; common ways we manipulate the basic primitive types of Racket.
; Please refer to the lab write-up as well as the reference page
; on the course website for more information about the various
; functions we introduce in this lab.

; For this lab, the A side will begin driving and B side will navigate.
; The A side of this lab consists of exploration of the primitive
; numeric types.

; Once you are done with the A side, switch to the B side problems
; that have your team explore the textual primitive types.  Here,
; B side should drive and A side should nevigate.  When you are done,
; combine both your files, rename them to basic-types.rkt, and upload
; the file to Gradescope.

; As a reminder, please make sure to work synchronously on this lab.
; That is, you should not take your individual parts and work on them
; in isolation.  The lab is designed for you to work together and
; collaborate on a solution!  In particular, the navigator should be
; focused on the problem the driver is working on and doing other
; stuff.  

; +-------------+----------------------------------------------------
; | Preparation |
; +-------------+

; 1. Make sure to introduce yourself to your partner.
; 2. Make sure to save this file as basic-types.scm.

; +----------------------------------------+-------------------------
; | Exercise 1: Simple numeric computation |
; +----------------------------------------+

; Partner A drives for the numeric exercises...

; (a) Determine the type DrRacket gives for the square root of two,
; computed by (sqrt 2).  Is it an integer or floating-point value?


; <floating point>

; (b) As we discussed last class, one way to check our answer
; is to "undo" the square root function via multiplication.
; We can even observe that the difference of this result and the
; expected value 2 evaluates to 0.

; Write a pair of expressions that calculates the square of
; (sqrt 2) via multiplication and then takes the difference of that
; result from the expected value.  We call this latter value
; the error of computation.

(define square-root-of-two-squared (expt(sqrt 2) 2))

(define difference-between-that-number-and-two 
  (- square-root-of-two-squared 2))
  difference-between-that-number-and-two

; c. You may find the values that these two values evaluate to a bit
; surprising!  In the space below, write a few sentences describing
; what you discovered and why you believe that to be the case.
;
; <we got an incredibly large number in the difference value>

; (d) In the space below, describe whether you expect your answer
; to be the same if you instead used (sqrt 4) rather than (sqrt 2).
; Explain your reasoning and check your work experimentally with
; the explorations panel of Scamper.
; 
; <TODO: We believed that it would give us 2 because the square root of 4 is exact unlike 2>

; +------------------------+-----------------------------------------
; | Exercise 2: Remainders |
; +------------------------+

; As the reading suggests, the remainder procedure computes the amount
; "left over" after you divide one number by another.  The reading
; suggests that remainder provides an interesting alternative to using
; max and min to limit (but not cap) the values of functions.

; (a) `(remainder x y)` gives you the amount "left over" when you 
; divide x by y.  For example (remainder 13 3) should give you 1,
; because 13 divided by 3 is 4 with 1 left over.

; Predict the values of each expressions in the space provided
; below.  **Do not use the interpreter yet!**

; > (remainder 8 3)
; <TODO: 2>
; > (remainder 3 8)
; <TODO: 3>
; > (remainder 8 8)
; <TODO: 0>
; > (remainder 9 8)
; <TODO: 1>
; > (remainder 16 8)
; <TODO: 0>
; > (remainder 827 8)
; <TODO: 3>
; > (remainder 0 8)
; <TODO: 0>
; > (remainder -8 8)
; <TODO: 0>
; > (remainder -7 8)
; <TODO: -7>
; > (remainder -9 8)
; <TODO: -1>
; > (remainder -8 3)
; <TODO: -2>
; > (remainder -3 8)
; <TODO: -3>

; (b) Check your answers experimentally with Scamper, one at a time.
; If you any of your answers disagree, try to come up with an explanation
; why.  If you cannot come up with one, feel free to hail down a
; member of the course staff for help.

; <TODO: Insert any notes you have>

; +------------------------------------+-----------------------------
; | Exercise 3: From reals to integers |
; +------------------------------------+

; As the reading on numbers suggests, Racket provides four
; functions that convert real numbers to nearby integers: floor,
; ceiling, round, and truncate.  The reading also claims there are
; differences between all four.

; To the best of your ability, figure out what each does, and what
; distinguishes it from the other three.  In your test, you should
; try both positive and negative numbers, numbers close to integers,
; and numbers far from integers.  (Numbers whose fractional part is
; 0.5 are about as far from an integer as any real number can be.)

; Write your descriptions of each function in the spaces below:

; (floor r): <TODO: floor rounds down even in negatives>
; (ceiling r): <TODO: ceiling rounds up even in negatives>
; (truncate r): <TODO: truncate completely gets rid of the decimal part of the integer>
; (round r): <TODO: round rounds the number. if its 0.5 it rounds up>

; When you are done, feel free to read the notes on this problem
; which can be found in the lab page.

; +---------------------------+-------------------------------------
; | Exercise 4: Large numbers |
; +---------------------------+

; Many programming languages have limits on the size of the numbers they
; represent. In some cases, if the number is large enough, they
; approximate it. In other cases, if the number is large enough, the
; calculations you do with the error are erroneous. (You’ll learn why in
; a subsequent course.) And in still others, the language treats large
; enough values as the special value "infinity".

; See what happens if you try to have Scheme compute with some very
; large integers. You may find the expt function helpful here.
;
; Describe what you observe in your file in a few sentences below.
(expt -999 999)

; <TODO: big enough values will just be counted as infinity and just big values will be represented using e.
; you can also get a - infinity>

; +--------------------------+---------------------------------------
; | Exercise 5: Digit tricks |
; +--------------------------+

; For these programming problems over numbers, think carefully about
; how you might use integer division and rounding to accomplish the
; desired behavior.

; (a) Write a procedure, (ones-digit-of n), that takes an integer n as
; input and returns the value of the ones digit (i.e., the rightmost
; digit) in that number.  For example:

; > (ones-digit-of 21904)
; 4
; > (ones-digit-of 0)
; 0

(define ones-digit-of
  (lambda (n)
    (remainder n 10)))


; b. Write a procedure (truncate-ones-from n) that takes an integer n
; and returns n, but with the digit in the ones position removed.  If
; the number has only one digit, then 0 is returned.  For example:

; > (truncate-ones-from 4210)
; 421
; > (truncate-ones-from 3)
; 0

(define truncate-ones-from
  (lambda (n)
    (truncate (/ n 10))))


; c. Check your functions on negative numbers.  Do they work as expected?
; If not, how might you fix that issue?
;

; > (ones-digit-of -42)
; 2 ; -2 would also be okay
; > (truncate-ones-from -42)
; -4

; <TODO: function works as expected for - numbers>

; +--------------------------+---------------------------------------
; | Exercise 6: Creating @'s |
; +--------------------------+

; Now partner B is the driver for the remainder of the lab!

; Develop three ways of constructing the string "@@@": one using a call
; to make-string, one a call to string, and one a call to list->string.


(define making-@s-with-make-string (make-string 3 #\@))
making-@s-with-make-string

(define making-@s-with-string (string #\@ #\@ #\@) )
making-@s-with-string

(define making-@s-with-list->string (list->string (list #\@ #\@ #\@)))
making-@s-with-list->string

; +-----------------------------+------------------------------------
; | Exercise 7: Textual corners |
; +-----------------------------+

; Each of the following expressions evaluates to a string.  For each
; expression write (a) its length of its resulting string value and
; (b) a sentence description of the resulting string.

; Length of corner-1: length 0
; Description of corner-1: an empty set of quotes
;define corner-1 "")



; Length of corner-2: 12
; Description of corner-2: The string "hello world!" 
; (define corner-2 "hello world!")


; Length of corner-3: 14
; Description of corner-3: the string "hello world!" with the quotes
;(define corner-3 "\"hello world!\"")


; Length of corner-4: 1
; Description of corner-4: just a space inside quotes
;(define corner-4 (string #\space))

; Length of corner-5: error
; Description of corner-5: error runtime asks us for an argument when none is given
;(define corner-5 (string))

; Enter any notes on what you've learned from this exercise here:
; index starts at 0 for string length will return error if a proper string isnt given

; +------------------------+-----------------------------------------
; | Exercise 8: Substrings |
; +------------------------+

; Consider the string "Department". Using the substring procedure, we
; can extract a wide variety of words from this one string. Write a
; Racket expression to extract each of the requested words below. You
; may use substring multiple times in combination with string-append,
; but please do not use string constants (e.g. "apart"), characters, or
; any other procedures.

; a. Write an expression to extract the string "Depart" from "Department".

; b. Write an expression to extract the string "part" from "Department".
; c. Write an expression to extract the string "ment" from "Department".
; d. Write an expression to extract the string "a" from "Department".
; e. Write an expression to extract the empty string from "Department".
; f. Write an expression to extract the string "Dent" from
;    "Department". Note that you may need to use two calls to substring
;    along with a call to string-append.
; g. Write an expression to extract the string "apartment" from
;    "Department". Once again, you may need multiple calls.

; Use the explorations pane to check that each of your defined
; expressions produces the desired value.

(define substring-ex-a (substring "Department" 0 6))
substring-ex-a

(define substring-ex-b (substring "Department" 2 6))
substring-ex-b

(define substring-ex-c (substring "Department" 6 10))

(define substring-ex-d (substring "Department" 3 4))

(define substring-ex-e (substring "Department" 0 0))

(define substring-ex-f (string-append(substring "Department" 0 2) (substring "Department" 8 10)))

(define substring-ex-g (string-append(substring "Department" 3 4) (substring "Department" 2 3) (substring "Department" 3 10)))

; +---------------------------------+--------------------------------
; | Exercise 9: Referencing lengths |
; +---------------------------------+

; Here are two opposing views about the relationship between
; string-length and string-ref:

; a. "No matter what string str is, provided that it is not the empty
;    string, (string-ref str (string-length str)) will return the last
;    character in the string."
; b. "No matter what string str is,
;    (string-ref str (string-length str)) is an error."

; Which, if either, of these views is correct? Why? Experiment with code
; in the explorations pane, substituting concrete strings for str (e.g.,
; "hello world!"), to arrive at an answer. Answer this in a sentence or
; two in the space below.

; <TODO: B (string-ref str (string-length str)) will always return an error>

; +---------------------------------------+--------------------------
; | Exercise 10: Collating your sequences |
; +---------------------------------------+

; In the reading, we discussed the fact that Racket assigns each of its
; characters a unique integer.  These numbers are called a collating
; sequence.  In this exercise, we'll explore these sequences in more
; detail.

; (a) Compare notes with your partner about your answers to Check 2:
; Collating sequences from the reading.  Use this acquired knowledge
; to answer the following question:

; > What are the collating sequence numbers for the uppercase English
; > letters (A--Z)?  Write your answer in the space below:

; <TODO: 60-59>

; (Hint: the description should be shorter than listing 26 letter-number
; pairs!)

; (b) Use your answer from part (a) to describe in a few sentences a
; method for determining if a character is an upper-case English letter
; by using collating sequences and subtraction.

; <TODO: if its between 65 and 90 inclusive it is a capitol english letter. 
;>

; (c) Describe how you would extend your answer to part (b) to also
; include lower-case English letters.  Can you just use the numbers
; corresponding to 'A' (the beginning of the uppercase letter sequence)
; and 'z' (the end of the lowercase letter sequence) or do we need to do
; something more complicated?

; <TODO: If the collating sequence is between 97 and 122 its a lowercase english letter

; d. Finally, let's think a little bit more broadly!  What about other
; languages?  For example, below are lowercase and uppercase alpha and
; omega, the beginning and end of the Greek alphabet:

; Α (uppercase alpha---note: *not* A!)
; α (lowercase alpha)
; Ω (uppercase omega)
; ω (lowercase omega)

; Describe in a few sentences how you would incorporate other languages
; into your technique.  If you have the capability, try out letters in
; other languages to see if your technique still works!

; <TODO: We would use the char-upper-case? function to see if characters are capitol in other languages
; +-------------+----------------------------------------------------
; | Wrapping Up |
; +-------------+

; Congratulations on finishing this lab!  To turn in your work:

; a. Ensure that your source file runs correctly without errors.
; b. Ensure this file is named `basic-types.scm`
; c. Send this completed file to your partner for their records.
; d. Submit this final file to Gradescope.  Make sure, if appropriate,
;    to submit your work as a group submission and include your
;    partner in the submission.

; +---------------------------+--------------------------------------
; | For those with extra time |
; +---------------------------+

; If you find that you finish all of these problems early, try one
; or more of the following problems.  Note that some of these problems
; require you to write functions which we will learn about in a day
; or two.  For now feel free to try to write expressions for concrete
; values, *e.g.*, strings, numbers, and lists that produce the effect
; described, and come back once we learn about functions to generalize
; the results with functions!

; +-----------------------------+------------------------------------
; | Extra 1: Rounding revisited |
; +-----------------------------+

; You may recall that we have a number of mechanisms for rounding real
; numbers to integers. But what if we want to round not to an integer,
; but to only two digits after the decimal point? Scheme does not include
; a built-in operation for doing that kind of rounding. Nonetheless,
; it is fairly straightforward.

; Suppose we have a value, `val`. Write instructions that give val rounded
; to the nearest hundredth. For example,

;     > (define val 22.71256)
;     > (your-instructions val)
;     22.71
;     > (define val 10.7561)
;     > (your-instructions val)
;     10.76

; Hint: You know how to round at the decimal point.  Thik about ways
; to shift the decimal point.

; It's fine if your procedure does not work perfectly for all values.
