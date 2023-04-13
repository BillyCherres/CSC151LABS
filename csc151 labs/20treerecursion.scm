;; CSC-151-02 (Fall)
;; Tree Recursion (tree-recursion.scm)
;; Authors: Boston Gunderson, Ellen Hengesbach, billy cherres
;; Date: 11/11/2022
;; Acknowledgements:
;; ACKNOWLEDGEMENTS HERE

;; -------------------------
"Preamble: Tree Definitions"
;; -------------------------

;; A tree is either:
;; + Empty (a leaf) or
;; + Non-empty (a node) with a value, left subtree, and right subtree.
(struct leaf ())
(struct node (value left right))

;;; (singleton v) -> tree?
;;; v: any
;;; Returns a tree consisting of a single value, i.e., a node with no children.
(define singleton
  (lambda (v)
    (node v (leaf) (leaf))))

;; Example trees for testing purposes

(define empty-tree (leaf))

(define small-tree
  (singleton 5))

(define large-tree
  (node 5
    (node 3
      (node 1
        (leaf)
        (singleton 2))
      (singleton 4))
    (node 8
      (node 7
        (singleton 6)
        (leaf))
      (node 9
        (leaf)
        (singleton 10)))))

(define left-leaning-tree
  (node 5
    (node 4
      (node 3
        (node 2
          (singleton 1)
          (leaf))
        (leaf))
      (leaf))
    (leaf)))

(define right-leaning-tree
  (node 1
    (leaf)
    (node 2
      (leaf)
      (node 3
        (leaf)
        (node 4
          (leaf)
          (singleton 5))))))

;; ----------------------
"Problem 1: Tree Product"
;; ----------------------

;; Consider the following recursive skeleton for a function that computes the
;; combined product of all the elements in a tree of numbers.
;;
;; To compute the product of a binary tree:
;; + If the tree is empty, the product is 1.
;; + If the tree is non-empty, the product is the value at the root of the tree
;; times the products of left and right subtrees.
;;
;; Use this skeleton to complete the implementation of tree-product below:

;;; (tree-product t) -> number
;;; t: tree? of numbers
;;; Returns the product of all the elements in the tree t.
(define tree-product
  (lambda (t)
    (match t
      [(leaf) 1]
      [(node v l r) (* v (tree-product l) (tree-product r))]
      )))

(test-case "empty tree-product" equal? 1 (tree-product empty-tree))
(test-case "small tree-product" equal? 5 (tree-product small-tree))
(test-case "large tree-product" equal? 3628800 (tree-product large-tree))
(test-case "left-leaning tree-product" equal? 120 (tree-product left-leaning-tree))
(test-case "right-leaning tree-product" equal? 120 (tree-product right-leaning-tree))

;; -------------------------
"Problem 2: Tree Leaf Count"
;; -------------------------

;; (B side drives!)

;; Consider the following recursive skeleton for a function that computes the
;; number of leaves in a tree.
;;
;; To compute the number of leaves in the tree:
;; + If the tree is empty, the tree is a leaf, so the number of leaves is 1.
;; + If the tree is non-empty, the number of leaves is the sum of the number of
;; leaves in the left and right subtrees
;;
;; Use this skeleton to complete the implementation of tree-leaf-count below:

;; (tree-leaf-count t) -> number
;; t: tree?
;; Returns a count of the number of leaves in tree t.
(define tree-leaf-count
  (lambda (t)
    (match t
      [(leaf) 1]
      [(node v l r) (+ (tree-leaf-count l) (tree-leaf-count r))]
      )
    ))

(test-case "empty tree-leaf-count" equal? 1 (tree-leaf-count empty-tree))
(test-case "small tree-leaf-count" equal? 2 (tree-leaf-count small-tree))
(test-case "large tree-leaf-count" equal? 11 (tree-leaf-count large-tree))
(test-case "left-leaning tree-leaf-count" equal? 6 (tree-leaf-count left-leaning-tree))
(test-case "right-leaning tree-leaf-count" equal? 6 (tree-leaf-count right-leaning-tree))

;; ---------------------------------------------
"Problem 3: Finding the largest value in a tree"
;; ---------------------------------------------

;; (Partner A drives!)

;; In the reading, we developed a partially correct implementation of a
;; function that finds the largest value in a tree of numbers. The
;; implementation is replicated below for reference:

;;; (tree-largest t) -> number?
;;; t: tree? of numbers, non-empty
;;; Returns the largest number in tree t.
(define tree-largest
  (lambda (tree)
    (match tree
      [(node v (leaf) (leaf)) v]
      [(node v l (leaf)) (max v (tree-largest l))]
      [(node v (leaf) r) (max v (tree-largest r))]
      [(node v l r) (max v (tree-largest l) (tree-largest r))]
      [(leaf) "How?"])))

(test-case "empty tree-largest" equal? "How?" (tree-largest empty-tree))
(test-case "small tree-largest" equal? 5 (tree-largest small-tree))
(test-case "large tree-largest" equal? 10 (tree-largest large-tree))
(test-case "left-leaning tree-largest" equal? 5 (tree-largest left-leaning-tree))
(test-case "right-leaning tree-largest" equal? 5 (tree-largest right-leaning-tree))


;; Recall that we designed tree-largest so that it only accepts non-empty
;; trees because an empty tree does not have any values that can be
;; considered the largest. However, when we go to write this function,
;; our recursive calls to tree-largest are potentially made with empty
;; trees because the sub-trees of a node may be empty.
;;
;; Share your answer to this reading problem with your partner and come up
;; with a shared solution. Fix the implementation of tree-largest above
;; and develop a collection of test cases below that demonstrate that your
;; implementation works.

; TODO: write your test cases here!

;; ---------------
"Problem 4: Tree?"
;; ---------------

;; (Partner B drives!)

;; Observe that we defined a tree in terms of two structs, leaf and node.
;; These functions provide two query functions, leaf? and node?. To implement
;; the tree? function which tests whether a value is a tree, it is tempting to
;; implement it as follows:

(define tree-first-attempt?
  (lambda (v)
    (or (leaf? v) (node? v))))

(test-case "is large-tree a tree?" equal? #t (tree-first-attempt? large-tree))
(test-case "is large-tree a tree?" equal? #f (tree-first-attempt? (node 1 2 3)))
;; It seems like it works, but the function has a critical flaw! Describe the
;; bug in a sentence below and demonstrate the bug with a test case:
;;
(tree-first-attempt? empty-tree)

; TODO: write your test case here!

;; Now, let's implement a correct version of the tree? function. We'll do so
;; recursively. First, fill out the recursive skeleton that defines when a tree
;; is indeed a tree:
;;
;; To check if a tree is indeed a tree?
;; + When the tree is empty (a leaf), <<TODO: fill me in!>>
;; + When the tree is non-empty (a node), <<TODO: fill me in!>>
;;
;; Finally, fill in a correct implementation of tree?, document the function,
;; and give a test suite demonstrating its correctness:

; TODO: fill me in!
(define tree?
  (lambda (t)
    (match t
      [(leaf) #t]
      [(node _ l r) (and (tree? r) (tree? l) )]
      [ _ #f]
      )
    ))

(test-case "is large-tree a tree?" equal? #t (tree? large-tree))
(test-case "is small-tree a tree?" equal? #t (tree? small-tree))
(test-case "is empty-tree a tree?" equal? #t (tree? empty-tree))
(test-case "is not-tree tree?" equal? #f (tree? (node 1 2 3)))
;; ------------------------------
"Extra Problem: Expression Trees"
;; ------------------------------

;; So far, we have only looked at binary trees that hold arbitrary values.
;; However, trees can model a wide variety of things, both concrete and abstract.
;; In doing so, we will sometimes change the structure of the tree slightly to
;; better capture the object we are modeling.
;;
;; It turns out that arithmetic expressions are trees! For example, the following
;; arithemtic expressions:
;;
;; 5
;; 1 + 1
;; 3 * (8 + 2) - 4
;;
;; All form trees! Here is the recursive definition of a simple artithmetic
;; expression:
;;
;; An arithmetic expression is either:
;; + A value, i.e., a number
;; + A binary expression consisting of a binary operation, "+", "-", "*", or "/",
;; and two sub-expressions, a left-hand and right-hand one.
;;
;; Here are the expressions above, but in tree form:
;;
;; 5
;;
;; +
;; / \
;; 1 1
;;
;; -
;; / \
;; / \
;; * 4
;; / \
;; 3 +
;; / \
;; 8 2
;;
;; Observe how our values appear as leaves of the tree. The binary operations
;; are our nodes! Furthermore, note how the tree encodes the precedence of the
;; operators, e.g., the '-' associates the '*' and '4'. rather than the '*'
;; associating the '3' and the '-'.
;;
;; With this in mind, here are a pair of structs that captures this definition:

(struct value (num))
(struct expr (op lhs rhs))

;; (Lhs and rhs stand for left-hand side and right-hand side, respectively.
  ;;
  ;; First, let's focus on the case where the only binary operation is addition.
  ;; Try writing our definitions that capture the following arithmetic expressions
  ;; using value and expr structs:
  
  ;; expr-1:
  ;; 5
  (define expr-1
    ; TODO: fill me in
    0)
  
  ;; expr-2:
  ;; +
  ;; / \
  ;; 1 1
  (define expr-2
    ; TODO: fill me in
    0)
  
  ;; expr-3:
  ;; +
  ;; / \
  ;; / \
  ;; + 2
  ;; / \
  ;; 3 5
  (define expr-3
    ; TODO: fill me in
    0)
  
  ;; Recall how we evaluate an arithmetic expression assuming that the expression
  ;; is fully parenthesized! It is actually recursive in nature! Here is a
  ;; recursive description of how to evaluate an arithmetic expression:
  ;;
  ;; Given an arithmetic expression:
  ;; + If the expression is a value, it evaluates to that value.
  ;; + If the expression is an operation, we evaluate the left-hand side,
  ;; evaluate the right-hand side, and combine the two resulting values with
  ;; the operation.
  ;;
  ;; Use this recursive skeleton as a guide to implement the arith-eval function
  ;; below! At first, try to implement this function for just addition. Once it
  ;; works on the examples you worked on above, try extending it to handle all
  ;; four arithmetic operations!
  
  (define arith-eval
    (lambda (e)
      ; TODO: fill me in!
      0))