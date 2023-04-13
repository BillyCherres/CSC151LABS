;; CSC 151 (1)
;; Lab: Docs and Music (docs-and-music.scm)
;; Authors: billy cherres Boston gunderson
;; Date: 9/16/2022
;; Acknowledgements:
;;   ACKNOWLEDGEMENTS HERE

(import image)
(import music)

; +----------------------------------------------------------------------------- 
; + Problem 1: It's a Mystery |
; +----------------------------

"Problem 1: It's a Mystery"
"========================="

; (A and B sides switch driver-navigator roles for each function.)

; For each of the following functions:
;number?
; (a) Look up their documentation in the Scamper sidebar menu in VSCode.
; (b) Write down at least three test cases exercising the function on a variety
;     of inputs.
; (c) List the preconditions on the parameters of the function.
; (d) In a sentence or two, describe the postcondition of the function in your
;     own words.

; (path ...) from the image library
+;(path 10 90 (list 10 8 4 65 756 89) "solid" "red")
(path 100 900 (list (pair 40 50) (pair 70 60) (pair 80 90) (pair 790 890)) "solid" "red")
(path 100 100 (list (pair 0 0) (pair 100 0) (pair 0 100) (pair 100 100)) "solid" "red")
(path 1000 1000 (list (pair 750 0) (pair 0 750) (pair 750 750) (pair 0 0))"outline" "blue")

;   width: number?
; height: number?
; points: list?, a list of points, pairs of numbers
; fill: string?, either "solid" or "outline"
; color: string?, either a color name or the form "rgba(r, g, b, a)"

;outputs the width and height of the drawing and takes all points and connects 
;them with straight lines. In the color of color and full or not with fill.

; (with-dashes ...) from the image library
(with-dashes (list 1 2 3 4 5) (rectangle 100 15 "solid" "red"))
(with-dashes (list 10 20 30 40) (rectangle 100 150 "outline" "red"))
(with-dashes (list 30 53 4 567 3) (rectangle 156 159 "outline" "red"))

;  (got from library)  dash-spec: list?, a list of numbers
; (got from library) d: drawing?

; outputs a shape with the outline as dashes specified by the list of numbers input
; +----------------------------------------------------------------------------- 
; + Problem 2: What's up, Doc? |
; +-----------------------------

"Problem 2: What's up Doc?"
"========================="

; (A and B sides switch driver-navigator roles for each function.)

; Consider each of the following function definitions that are undocumented
; and poorly named. Note that these functions use techniques and libraries that
; we may not have introduced or used yet; that is fine! The purpose of this
; exercise is to get us to think about the _contract_ of these functions rather
; than how they work precisely.

;;; n: number? 0 <= n (please)
;;; r: number?
;;; e: integer?, 0 <= e <= 255
;;; g: integer?, 0 <= g <= 255
;;; b: integer?, 0 <= b <= 255
;;; Returns a set (amount denoted by n) of overlaying outline triangles that get smaller until they finish. 
;;; The size is determined by r and the remaining n and the color is the rgb values provided by e g and b.
(define func-1
  (lambda (n r e g b)
    (if (zero? n)
        (triangle 0 "outline" "black")
        (overlay (triangle (* n r) "outline" (color e g b 1))
                 (func-1 (- n 1) r e g b)))))

; (func-1 10 37 50 90 89)
"----- func-1 tests -----"
(func-1 10 37.967 50 90 89)
(func-1 20 39 58 20 19)
(func-1 20 3 0 0 255)
;;; s: string?
;;; n: integer? integer>0 integer<= (string-length s)
(define func-2
  (lambda (s n)
    (string-append (substring s n (string-length s))
                   (substring s 0 n))))

; takes the end of the string denoted by (n), and adds the end to the beggining of the string
(func-2 "animal" 3)
(func-2 "train" 2)
(func-2 "pig" 2)
"----- func-2 tests -----"

;;; s: string?
;;; k: char?
;;; returns the string (s) but with any numerical 
;;; characters replaced by k
(define func-3
  (lambda (s k)
    (string-map (lambda (c)
                  (if (char-numeric? c) k c))
                s)))

(func-3 "12" #\h)
(func-3 "Hell0" #\o)
(func-3 "Please No" #\k)
"----- func-3 tests -----"

;;; l : list?
;;; .returns the list but every pair is switched
(define func-4
  (lambda (l)
    (if (< (length l) 2)
        l
        (let ([h1 (car l)]
              [h2 (car (cdr l))]
              [t (cdr (cdr l))])
          (cons h2 (cons h1 (func-4 t)))))))

(func-4 (list 123 324 234 1 345 32763 34525 3425 3256345 2345 23 33 3 345 5 5))
(func-4 (list 3 2 5))
(func-4 (list 3 2 5 4))
"----- func-4 tests -----"

; For each function:
;
; (a) Explore how the function works by writing down 3--5 test cases
;     illustrating its behavior on a variety of inputs. You can determine
;     what types of inputs the program expects by inspecting the code or
;     by trying out different values to see if they work.
; (b) Based on your results, write down a doc comment for each function
;     as described in the reading. Make sure to include a function
;     signature describing any preconditions on the function's parameters
;     (e.g., their types) as well as postconditions on the output of
;     the function.

; +----------------------------------------------------------------------------- 
; + Problem 3: Interval Theory |
; +-----------------------------

"Problem 3: Interval Theory"
"=========================="

; (A drives for this problem)

; Let's change gears and return back to the music library that we introduced in
; mini-project 1. Recall that the music library exposes the following functions:
; +----------------------------------------------------------------------------- 
; (par c1 ... ck)
;
; That forms musical compositions by composing together individual notes
; sequentially (seq) or in parallel (par).
;
; In this problem, we'll explore some basic music theory: the relationship
; between notes. Suppose that we pick a note that we'll call the _root_. Then we
; can explore the relationship between the root and other notes. In western music
; theory, we recognize the _semitone_ as the smallest interval, or distance,
; between notes. With our MIDI notes, the musical distance between two MIDI
; +----------------------------------------------------------------------------- 
; are between 0--12 semitones away from the root. The "0th interval" is the
; same note as the root while the note 12 semitones away is the same note but
; one _octave_ higher than the original note.
;
; Write a function (all-intervals root d) that takes a note value root and
; duration d as input and plays all the intervals of root from 0--12 semitones
; upwards. Make sure to:
;
; (a) Document your function including any relevant preconditions and
;     postconditions.
; (b) Use auxiliary defines and lets to minimize redundancy in your function.
;
; Once you are done, use your function to exercise your ear! Try your function
; on a few inputs to get a sense of what the different intervals sound like.
; You should observe that intervals sound more dissonant or harmonious than
; others. Some intervals might even invoke particular emotions or feelings!
;
; For each of the 13 intervals, in the space below, give a single word (or pair
; of words if you don't agree with your partner!) that captures how each
; interval sounds to your ears. Identifying such "flavors" to the intervals is
; the primary way that musicians build up their ability to recognize them in
; live music!
;
; 0 Meh
; 1 Bad 
; 2 Bad
; 3 Bad
; 4 Meh
; 5 Fine 
; 6 Clash
; 7 Good
; 8 Clash
; 9 Meh
; 10 Fine
; 11 Clash
; 12 Good
; ...

(define all-intervals
  (lambda (n)
  (let* ([s (lambda (h)(par (note n wn)(note (+ n h ) wn)))])
  (seq (s 0)
  (s 1)
  (s 2)
  (s 3)
  (s 4)
  (s 5)
  (s 6)
  (s 7)
  (s 8)
  (s 9)
  (s 10)
  (s 11)
  (s 12)))))
  (all-intervals 60)

;; n: integer? 0<= n <= 115
;; returns a sequence of intervals with the base note n
;; increasing in interval until it is 12 steps above

; +----------------------------------------------------------------------------- 
; + Problem 4: Chords, Oh My! |
; +----------------------------

"Problem 4: Chords, Oh My!"
"========================="

; (B drives for this problem)

; Using musical intervals, we can characterize the various _chords_, collections
; of tones played simultaneously. A list of common chord types can be found on
; Wikipedia:
;
; https://en.wikipedia.org/wiki/Chord_(music)#Examples
;
; The table found on Wikipedia describes for each common chord its components
; in terms of intervals. For example:
;
; + A major triad is composed of the root (P1) and then the note 4 semitones
;   away (major third or M3) and the note 7 semitones away (perfect fifth or
;   P5).
; + A minor seventh chord is composed of the root (P1), the note 3 semitones
;   away (minor third, m3), the note 7 semitones away (P5), and the note 10
;   semitones away (minor seventh, m7).
;
; Rather than expressing intervals in terms of semitones, it is much more
; natural to express intervals in terms of the shorthand names given in the
; table, e.g., P4 (perfect fourth) corresponds to five semitones.
;
; First, write a function `(interval->note root int)` that takes the MIDI
; note value of the root and a named interval (as a string) and returns the
; MIDI note value of that interval note. For example,
; (interval->note 60 "P4") -->* 65 since a perfect fourth (P4) is 5 semitones
; away from the root. If the user provides a named interval that does not
; exist, then interval->note should raise a runtime error with the `error`
; function.
;
; Make sure to document your function and test it on a variety of inputs!
(define interval->note 
  (lambda (root int)
    (let* ([str (lambda (interval) (string=? int interval))]
          [base (note root hn)]
          [parr (lambda (value) (par base(note (+ root value)hn)))])
     (cond 
        [(str "P1") base]
        [(str "m2") (parr 1)]
        [(str "M2") (parr 2)]
        [(str "m3") (parr 3)]
        [(str "M3") (parr 4)]
        [(str "P4") (parr 5)]
        [(str "d5") (parr 6)]
        [(str "P5") (parr 7)]
        [(str "A5") (parr 8)]
        [(or (str "M6")(str "d7")) (parr 9)]
        [(str "m7") (parr 10)]
        [(str "M7") (parr 11)]
        [else (error "Invalid Interval")]))))
; root: integer? 0<= root <= 115
; int: string? (must be equal to an interval)
; returns the base note root with a note that is the interval int higher than it
(interval->note 60 "P5")
(interval->note 5 "m2")
(interval->note 99 "P0")


; With interval->note, define a function `(triad root i1 i2 i3 dur appregio?)`
; that takes a MIDI note value as the root, three named intervals, a duration
; and a boolean, and creates a composition that plays a chord consisting of
; those three intervals played together. If appregio? is #f, then the notes
; of the chord are played in parallel. If appregio? is #t, then the notes
; are played separately, or appregiated, in sequence.

; As before, make sure to document your function and test it on a variety
; of inputs. Once you are done, use your function to play three chords from
; the table of common chords found on Wikipedia. Like the intervals, you
; should find that particular chord types evoke certain feelings or emotions!
; For each of the three chords you build, you should list in a comment below
; the one word that you feel when hearing that chord.
(define interval->notes
  (lambda (root int duration)
    (let* ([str (lambda (interval) (string=? int interval))]
          [base (note root duration)]
          [parr (lambda (value) (par base(note (+ root value)duration)))])
     (cond 
        [(str "P1") base]
        [(str "m2") (parr 1)]
        [(str "M2") (parr 2)]
        [(str "m3") (parr 3)]
        [(str "M3") (parr 4)]
        [(str "P4") (parr 5)]
        [(str "d5") (parr 6)]
        [(str "P5") (parr 7)]
        [(str "A5") (parr 8)]
        [(or (str "M6")(str "d7")) (parr 9)]
        [(str "m7") (parr 10)]
        [(str "M7") (parr 11)]
        [else (error "Invalid Interval")]))))

(define triad 
  (lambda (root i1 i2 i3 dur appregio?) 
    (cond 
    [appregio?  (par (interval->notes root i1 dur)
                     (interval->notes root i2 dur)
                     (interval->notes root i3 dur))]
    [(not (appregio?)) 
                (seq (interval->notes root i1 dur)
                     (interval->notes root i2 dur)
                     (interval->notes root i3 dur))]
    [else (error "Give a Boolean Value for Apppregio")])))
(triad 60 "P1" "m3" "d5" wn #t)
; root: integer? 0<= root <= 115
; i1 : interval? 
; i2 : interval? 
; i3 : interval? 
; dur: dur?
; appregio?: boolean?
; returns a traid with the base not of root and intervals of i1 i2 and i3
; with a duration of dur and in parralel if appregio?=#t or in seq
; if appregio? = #f

(triad 60 "P1" "m3" "d5" wn #t)
;Diminished Triad, Clash
(triad 60 "P1" "M3" "A5" wn #t)
;Augmented Triad, Suspence
(triad 60 "P1" "m3" "P5" wn #t)
;Minor Triad, Spooky