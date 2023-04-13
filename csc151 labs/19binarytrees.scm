;; CSC-151-02 (Fall)
;; Lab: Binary Trees (binary-trees.rkt)
;; Authors: Boston Gunderson, Billy Cherre, Ellen Hengesbach
;; Date: 11/9/2022
;; Acknowledgements:
;;   ACKNOWLEDGEMENTS HERE

; +-----------------------------------------+------------------------
; | Provided code: The definition of a tree |
; +-----------------------------------------+

(struct leaf ())
(struct node (value left right))
(define tree?
  (lambda (v) (or (leaf? v) (node? v))))

; +-----------------------------+------------------------------------
; | Provided code: tree->string |
; +-----------------------------+

(define tree-level->string
  (let ([bullets (vector "* " "+ " "- " ". ")]
        [make-spaces (lambda (n)
                       (list->string (make-list n #\space)))])
    (lambda (level tree)
      (let* ([spaces (make-spaces (* 2 level))]
             [bullet
               (string-append
                 spaces
                 (vector-ref bullets (remainder level (vector-length bullets))))])
        (match tree
          [(leaf) ""]
          [(node value (leaf) (leaf)) (string-append bullet value)]
          [(node value left (leaf))
           (string-append
             (string-append bullet value)
             "\n"
             (tree-level->string (+ level 1) left))]
          [(node value (leaf) right)
           (string-append
             (string-append bullet value)
             "\n"
             (tree-level->string (+ level 1) right))]
          [(node value left right)
          (string-append
            (string-append bullet value)
            "\n"
            (tree-level->string (+ 1 level) left)
            "\n"
            (tree-level->string (+ 1 level) right))])))))

(define tree->string
  (lambda (tree)
    (tree-level->string 0 tree)))

; +----------------------------------------------+-------------------
; | Provided code: The legendary management tree |
; +----------------------------------------------+

(define management-tree
  (node
    "Board"
    (leaf)
    (node
      "CEO"
      (node
        "Head of Engineering"
        (node "Software Developer" (leaf) (leaf))
        (node "Tester" (leaf) (leaf)))
      (node
        "Head of Legal"
        (leaf)
        (node "Lawyer" (leaf) (leaf))))))

(tree->string management-tree)

; +-----------+------------------------------------------------------
; | Exercises |
; +-----------+

; ------------------------
"Exercise 1: Making trees"
; ------------------------

; (Partner A drives!)

; a. Consider the following trees of numbers drawn with ASCII art:

; i. tree-i
;           "b"
;           / \
;          /   \
;        "a"   "c"

; ii. tree-ii
;            "e"
;            / \
;           /   \
;          "b"  "f"
;          / \    \
;         /   \    \
;       "a"   "c"  "g"
;             /
;            "d"

; iii. tree-iii
;           "f"
;           /
;         "e"
;         /
;       "d"
;       /
;     "c"
;     /
;   "b"
;   /
; "a"

; For each of these trees, use the tree-making functions from the
; reading to complete the definitions of `tree-i`, `tree-ii`, and
; `tree-iii` below. 

;     > (tree? tree-i)
;     #t
;     > (tree->string tree-i)
;     * b
;       + a
;       + c
;     > (binary-tree? tree-ii)
;     #t
;     > (display-binary-tree tree-ii)
;     * 5
;       + 2
;         - 1
;         - 4
;       + 7
;         - 9
;           . 8
;     > (binary-tree? tree-iii)
;     #t
;     > (display-binary-tree tree-iii)
;     * 5
;       + 4
;         - 3
;           . 2
;             . 1
;               . 0

(define tree-i
  (node "b"
    (node "a"
      (leaf)
      (leaf))
    (node "c"
      (leaf)
      (leaf))))
(tree->string tree-i)

(define tree-ii
  (node "e"
    (node "b"
      (node "a"
        (leaf)
        (leaf))
      (node "c"
        (node "d"
          (leaf)
          (leaf))
        (leaf)))
    (node "f"
      (leaf)
      (node "g"
        (leaf)
        (leaf)))))

(tree->string tree-ii)

(define tree-iii
(node "f"
  (node "e" 
    (node "d"
      (node "c"
        (node "b"
          (node "a" (leaf) (leaf)) 
          (leaf))
        (leaf))
      (leaf))
    (leaf))
  (leaf)

)
)
(tree->string tree-iii)
; b. Note that tree-iii is a left-leaning tree. That is, all its children are
; left children. Complete the definition of tree-iv below which is
; the same as tree-iii except that its leaves grow to the right rather
; than the left.

; "a"
;   \
;   "b"
;     \
;     "c"
;       \ 
;       "d"
;         \ 
;         "e"
;           \
;           "f"

; > (tree? tree-iv)
; #t
; > (tree->string tree-iv)
; * 5
;   + 4
;     - 3
;       . 2
;         * 1
;           + 0

(define tree-iv 
  (node "a"
    (leaf)
    (node "b"
      (leaf)
      (node "c"
        (leaf)
        (node "d"
          (leaf)
          (node "e"
            (leaf)
            (node "f"
              (leaf) (leaf))))))))
(tree->string tree-iv)
; d. Finally, in the space below describe in a few sentences the
; differences and similarities between tree-iii and tree-iv. Do you
; consider these trees to be the same tree or different trees?
; Why?

; For tree-iii, we put all of the nodes before the leaves because it was left
; leaning but for tree-iv we put a leaf before each new node because it was right
; leaning. Both have the same shape just flipped. We PERSONALLY don't think it is 
; a different tree because it doesn't matter whether you put the information in the 
; right-branch or the left-branch, the same information is being put in the tree.

; ------------------
"Exercise 2: Leaves"
; ------------------

; (Partner B drives!)

; a. As you may have noted, in the sample code, we use the very verbose
;
; (node val (leaf) (leaf))
;
; To create a node with no children. This is a bit tedious! Write a
; helper function 'node-nc' (short for "no children") that takes a value
; as input and produces a node with no children as output. Document
; the function appropriately.
;(node-nc)-> node?
;v: any?
;returns a node of value v with leaf's as its second and third arguments
(define node-nc
  (lambda (v)
    (node v 
      (leaf)
      (leaf))))

; Now, write a function 'childless?' that takes a tree as input and
; returns #t if and only if the tree has no children. Use the query
; functions produced by our struct declarations leaf? and node? in
; conjunction with operations over booleans for this task.  Document
; and test this function appropriately.
; (childless? v)-> boolean?
; v: node?
; returns #t if v is a node with arguments 2 and 3 as leaves else returns #f
(define childless?
  (lambda (v)
    (match v
      [(node _ (leaf)(leaf)) #t]
      [_ #f])))

(test-case "Works" equal? #t (childless? (node-nc "p")))
(test-case "False" equal? #f (childless? (node "p" (node-nc "p") (leaf))))
; ----------------------------
"Exercise 3: Traversing trees"
; ----------------------------

; (Partner C drives!)

; Recall from our discussion of structs that we can get out the
; fields of a struct in two ways:
;
; 1. Using struct projection functions.
; 2. Pattern matching.
;
; For our tree structs, we have:
;
; + The (leaf) pattern to match a leaf.
; + The (node-value n), (node-left n), and (node-right n) functions
;   to retrieve the value, left child, and right child of a node.
;   We also have the pattern (node value left right) to pattern
;   match a node and bind its value, left, and right fields all
;   at once.
;
; In the space below, write two expressions to retrieve the given
; value from the trees you created above:
;
; + One expression using combinations of projection functions.
; + One expression using a pattern matching consisting of a single
;   pattern. Recall that you can nest patterns inside of other
;   patterns.

; a. "b" from tree-i
(node-value tree-i)
(match tree-i 
[(node v l r) v]
)
; b. "c" from tree-ii
(node-value (node-right (node-left  tree-ii)))

(match tree-ii
[(node _ (node _ _ (node v _ _)) _) v ]

)
; c. "b" from tree-iii
(node-value (node-left (node-left (node-left (node-left  tree-iii)))))
(match tree-iii
[(node _ (node _ (node _ (node _  (node v _ _)_) _)_)_) v ])


; d. "Head of Legal" from management-tree
(node-value (node-right (node-right  management-tree)))
(match management-tree
[(node _ _ (node _ _ (node v _ _)) ) v ])
; e. "Software Developer" from management-tree
(node-value (node-left (node-left (node-right  management-tree))))
(match management-tree
[(node _ _(node _  (node _ (node v _ _) _)_) ) v ])
; ------------------------------------
"Exercise 4: Exploring tree recursion"
; ------------------------------------

; (Partner D drives!)

; From the reading, we noted that a binary tree is recursively defined like a
; list. A binary tree is either:

; + *Empty*, or
; + *Non-empty* where the tree contains a value and up to two *children*
;   (*subtrees*) that are, themselves, trees.

; Like lists, our tree operations mirror this recursive decomposition of
; the list. As a first example, consider the following function which
; computes the *size* of the input tree, *i.e.*, the number of values it
; contains.

;;; (tree-size tree) -> integer?
;;;   tree : tree?
;;; Determine how many values are in binary tree.
(define tree-size
  (lambda (t)
    (match t
      [(leaf) 0]
      [(node _ l r) (+ 1 (tree-size l) (tree-size r))])))

; a. For reference, copy and paste your definitions from tree-i and
; tree-ii from a previous problem within this comment below:

; (define tree-i undefined)
; (define tree-i
;   (node "b"
;     (node "a"
;       (leaf)
;       (leaf))
;     (node "c"
;       (leaf)
;       (leaf))))
; ; (define tree-ii undefined)
; (define tree-ii
;   (node "e"
;     (node "b"
;       (node "a"
;         (leaf)
;         (leaf))
;       (node "c"
;         (node "d"
;           (leaf)
;           (leaf))
;         (leaf)))
;     (node "f"
;       (leaf)
;       (node "g"
;         (leaf)
;         (leaf)))))
; Now, use your mental model of computation to give an evaluation trace
; of the following expression in the space below. In your derivation,
; you may take the following short-cuts:
;
; + You may evaluate a recursive call to tree-size directly to the
;   branch of the pattern match that is selected.
; + You may elide the contents of the tree's children during evaluation.
;
; Make sure to check your work in the explorations pane when you are
; done!

; a. (tree-size tree-i)
; --> (tree-size tree-i)
; (node "a"
    ;   (leaf)
    ;   (leaf))
    ; (node "c"
    ;   (leaf)
    ;   (leaf)))))

    ; (match (node "b" (node "a"
    ;   (leaf)
    ;   (leaf))
    ; (node "c"
    ;   (leaf)
    ;   (leaf)))))
    ;   [(leaf) 0]
    ;   [(node _ l r) (+ 1 (tree-size l) (tree-size r))])))

; (+ 1 (tree-size (node "a"
    ;   (leaf)
    ;   (leaf))) (tree-size  (node "c"
    ;   (leaf)
    ;   (leaf)))))))

    ; (+ 1 (match (node "a"
    ;   (leaf)
    ;   (leaf))
    ;   [(leaf) 0]
    ;   [(node _ l r) (+ 1 (tree-size l) (tree-size r))]))) tree-size  (node "c"
    ;   (leaf)
    ;   (leaf)))))))

    ;(+ 1 (+ 1 (tree-size (leaf)) (tree-size (leaf))(tree-size node "c" (leaf)(leaf))

    ;(+1(+1 (match (leaf) [(leaf) 0]
    ;   [(node _ l r) (+ 1 (tree-size l) (tree-size r))(tree-size leaf))(tree-size (node "c" (leaf)(leaf))))\
    ;(+ 1(+ 1 0 (tree-size (leaf)) (tree-size (node "c" (leaf)(leaf))))
    ;(+ 1(+ 1 0 (match (leaf) [(leaf) 0] [(node _ l r) (+1 (tree-size l) (tree-size r))])) (tree-size (node "c" (leaf)(leaf))))
    ;(+ 1(+ 1 0 0)(tree-size (node "c" (leaf)(leaf))))
    ;(+ 1 1 (tree-size (node "c" (leaf)(leaf))))
    ;(+ 1 1 (match (node "c" (leaf)(leaf) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l)(tree-size r))])))
    ;(+ 1 1 (+ 1 (tree-size (leaf)) (tree-size (leaf))))
    ;(+ 1 1 (+ 1 (match (leaf) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))])(tree-size (leaf))))
    ;(+ 1 1 (+ 1 0 (tree-size (leaf))))
    ;(+ 1 1 (+ 1 0 (match (leaf)[(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))])))
    ;(+ 1 1 (+ 1 0 0))
    ;(+ 1 1 1)
    ;3

; b. 
;(tree-size tree-ii)
;(tree-size (node "e" (node ...) (node ...)))
;(match (node "e" (node ...) (node ...)) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))]))
;(+ 1 (tree-size (node "b" (node ...) (node ...))) (tree-size (node "f" (leaf) (node ...))))
;(+ 1 (match (node "b" (node ...) (node ...)) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))])(tree-size (node "f" (leaf) (node ...))))
;(+ 1 (+ 1 (tree-size (node "a" (leaf)(leaf))) (tree-size (node "c" (node ...) (leaf)))) (tree-size (node "f" (leaf) (node ...))))
;(+ 1 (+ 1 (match (node "a" (leaf)(leaf)) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))])(tree-size (node "c" (node ...) (leaf)))) (tree-size (node "f" (leaf) (node...))))
;(+ 1 (+ 1 (+1 (tree-size (leaf))(tree-size (leaf)))(tree-size (node "c" (node ...)(leaf))))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 (+1 (match (leaf) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))])(tree-size (leaf)))(tree-size (node "c" (node ...)(leaf))))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 (+1 0 (tree-size (leaf)))(tree-size (node "c" (node ...)(leaf))))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 (+1 0 (match (leaf) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))]))(tree-size (node "c" (node ...)(leaf))))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 (+1 0 0)(tree-size (node "c" (node ...)(leaf))))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 1 (tree-size (node "c" (node ...)(leaf))))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 1 (match (node "c" (node "d" (leaf)(leaf)) (leaf)) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))]))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 1 (+1 (tree-size (node "d" (leaf) (leaf)))(tree-size (leaf)))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 1 (+1 (match (node "d" (leaf) (leaf)) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))])(tree-size (leaf)))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 1 (+1 (+ 1 (tree-size (leaf))(tree-size (leaf)))(tree-size (leaf)))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 1 (+1 (+ 1 (match (leaf) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))])(tree-size (leaf)))(tree-size (leaf)))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 1 (+1 (+ 1 0(tree-size (leaf)))(tree-size (leaf)))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 1 (+1 (+ 1 0(match (leaf) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))]))(tree-size (leaf)))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 1 (+1 (+ 1 0 0)(tree-size (leaf)))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 1 (+1 1 (tree-size (leaf)))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 1 (+1 1 (match (leaf) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))]))(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 1 (+1 1 0)(tree-size (node "f" (leaf)(node ...))))
;(+ 1 (+ 1 1 2)(tree-size (node "f" (leaf)(node ...))))
;(+ 1 4 (tree-size (node "f" (leaf)(node ...))))
;(+ 1 4 (match (node "f" (leaf)(node "g" (leaf)(leaf)))[(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))]))
;(+ 1 4 (+ 1 (tree-size (leaf)) (tree-size (node "g" (leaf) (leaf)))))
;(+ 1 4 (+ 1 (match (leaf) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))]) (tree-size (node "g" (leaf) (leaf)))))
;(+ 1 4 (+ 1 0 (tree-size (node "g" (leaf) (leaf)))))
;(+ 1 4 (+ 1 0 (match (node "g" (leaf) (leaf)) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))])))
;(+ 1 4 (+ 1 0 (+ 1 (tree-size (leaf)) (tree-size (leaf)))))
;(+ 1 4 (+ 1 0 (+ 1 (match (leaf) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))]) (tree-size (leaf)))))
;(+ 1 4 (+ 1 0 (+ 1 0 (tree-size (leaf)))))
;(+ 1 4 (+ 1 0 (+ 1 0 (match (leaf) [(leaf) 0] [(node _ l r) (+ 1 (tree-size l) (tree-size r))]))))
;(+ 1 4 (+ 1 0 (+ 1 0 0)))
;(+ 1 4 (+ 1 0 1))
;(+ 1 4 2)
;7

 ;(define tree-ii
;   (node "e"
;     (node "b"
;       (node "a"
;         (leaf)
;         (leaf))
;       (node "c"
;         (node "d"
;           (leaf)
;           (leaf))
;         (leaf)))
;     (node "f"
;       (leaf)
;       (node "g"
;         (leaf)
;         (leaf)))))
; Fill out the following high-level description of `tree-size` in
; terms of the base and recursive cases of the function above.

; The size of a tree is:
; + ... in the base case
; + ... in the recursive case