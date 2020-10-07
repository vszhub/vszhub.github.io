---
layout: post
title: Reading "Structure and Interpretation of Computer Programs, 2nd Edition"
categories: Notes
tags: [programming, lisp, scheme]
toc: true
math: true
---

[*Structure and Interpretation of Computer Programs*, 2nd Edition](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book.html) written by [Harold Abelson](http://groups.csail.mit.edu/mac/users/hal/hal.html) and [Gerald Jay Sussman](http://groups.csail.mit.edu/mac/users/gjs/gjs.html) with Julie Sussman and foreword by [Alan J. Perlis](https://en.wikipedia.org/wiki/Alan_Perlis) was published in 1996.

This book is freely available [online](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book.html). Besides, there is a [more beautiful unofficial online version](http://sarabander.github.io/sicp/).

Since the first edition was published in 1985, this book was formerly used as the textbook for MIT's introductory course in electrical engineering and computer science, until it was replaced with [*Introduction to Computation and Programming Using Python*](https://mitpress.mit.edu/books/introduction-computation-and-programming-using-python-second-edition) later.

This book uses a dialect of [Lisp](https://en.wikipedia.org/wiki/Lisp_(programming_language)) called [Scheme](https://groups.csail.mit.edu/mac/projects/scheme/) to describe computational processes. Lisp was invented in the late 1950s as a formalism for reasoning about the use of certain kinds of logical expressions, called *recursion equations*, as a model for computation. The language was conceived by [John McCarthy](https://en.wikipedia.org/wiki/John_McCarthy_(computer_scientist)) and is based on his paper [*Recursive Functions of Symbolic Expressions and Their Computation by Machine*](http://www-formal.stanford.edu/jmc/recursive.pdf).

Lisp is [not a mainstream programming language](https://www.tiobe.com/tiobe-index/). Why did the authors use it in this book? The most important reason the authors gave us is that Lisp handles *procedures* and data. Many powerful program-design techniques are dependent on this feature.

I had created a repository as a [playground](https://github.com/vszhub/sicp2e) for this book.
{: .message }

## Notes on Each Chapter

### Chapter 1. Building Abstractions with Procedures

#### 1.1 The Elements of Programming

A powerful programming language is more than just a means for instructing computers. It also serves as a framework within which we organize our ideas, i.e. we can combine simple ideas to form more complex ones. For accomplishing this, every programming language should provide three mechanism:

- **primitive expressions**, which represent the simplest entities the language is concerned with,
- **means of combination**, by which compound elements are built from simpler ones, and
- **means of abstraction**, by which compound elements can be named and manipulated as units.

##### 1.1.1 Expressions

The Scheme interpreter runs in *read-eval-print* loop: It reads an expression from the terminal, evaluates the expression, and prints the result. Everything in Scheme has a value.

[The MIT Scheme](https://www.gnu.org/software/mit-scheme/) is the suggested interpreter in this book, but I will use [ChezScheme](https://github.com/cisco/ChezScheme) when I walk through this book because it is open-source and has more powerful features.

##### 1.1.2 Naming and the Environment

Defining variables is the simplest means of abstraction. This feature can let us retrieve a complex object via a simple name.

The general form of a variable definition is

    (define ⟨name⟩ ⟨body⟩)

The memory that keeps track of the name-object pairs is called the environment.

##### 1.1.3 Evaluating Combinations

The process of evaluating a combination in the interpreter:

1. Evaluate the subexpressions of the combination.
2. Apply the procedure that is the value of the leftmost subexpression (the operator) to the arguments that are the values of the other subexpressions (the operands).

This process is recursive in nature. We can draw this process as a tree accumulation. For example,

```scheme
(* (+ 2 (* 4 6)) (+ 3 5 7))
```

The tree accumulation of evaluating above combination is

{% include image.html name="tree-accumulation.png" alt="tree accumulation" width="30%" class="align-center" %}

##### 1.1.4 Compound Procedures

Defining procedures is a more powerful means of abstraction.

The general form of a procedure definition is

    (define (⟨name⟩ ⟨formal parameters⟩) ⟨body⟩)

##### 1.1.5 The Substitution Model for Procedure Application

The substitution model is for describing the process of evaluating a compound procedure: To apply a compound procedure to arguments, evaluate the body of the procedure with each formal parameter replaced by the corresponding argument.

There are two orders of the evaluation:

1. *Normal order*: fully expand and then reduce.
2. *Applicative order*: evaluate the arguments and then apply.

Apparently, the applicative order is more efficient.

##### 1.1.6 Conditional Expressions and Predicates

The general form of a conditional expression is

    (cond (⟨p_1⟩ ⟨e_1⟩)
          (⟨p_2⟩ ⟨e_2⟩)
          ...
          (⟨p_n⟩ ⟨e_n⟩))

Or

    (cond (⟨p_1⟩ ⟨e_1⟩)
          (⟨p_2⟩ ⟨e_2⟩)
          ...
          (else ⟨e_n⟩))

And there is another conditional expression:

    (if ⟨predicate⟩ ⟨consequent⟩ ⟨alternative⟩)

#### 1.2 Procedures and the Processes They Generate

## Solutions to Exercises

### Exercise 1.3

> Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.

```scheme
(define (square x) (* x x))

(define (sum-of-larger-squares x y z)
        (if (> x y)
            (+ (square x) (if (> y z)
                              (square y)
                              (square z)))
            (+ (square y) (if (> x z)
                              (square x)
                              (square z)))))
```

### Exercise 1.7

> The `good-enough?` test used in computing square roots will not be very effective for finding the square roots of very small numbers. Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers. Explain these statements, with examples showing how the test fails for small and large numbers. An alternative strategy for implementing `good-enough?` is to watch how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess. Design a `square-root` procedure that uses this kind of end test. Does this work better for small and large numbers?

Here is the original implementation of `good-enough?`:

```scheme
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
```

If `x` is far smaller than the error (here is `0.001`), then as long as the distance between `(square guess)` and `x` is smaller than the error, the iteration would stop immediately, so the accuracy cannot be improved anymore. For smaller `x`, the square root calculated is the same.

For example,

```scheme
> (sqrt 0.0000000000000001)
0.03125000000000106
> (sqrt 0.00000000000000001)
0.03125000000000011
> (sqrt 0.000000000000000001)
0.03125000000000001
> (sqrt 0.0000000000000000001)
0.03125
> (sqrt 0.00000000000000000001)
0.03125
```

Since computers always store floating-point numbers in the form of precision + exponent, when two very large numbers are subtracted, the large exponent will shift the floating point to the right by a large margin, so that the final result will always be greater than the precision. Therefore, the calculation process will fall into infinite recursion.

For example,

```scheme
> (sqrt 100000000000)
316227.7660168379
> (sqrt 1000000000000)
1000000.0
> (sqrt 10000000000000)
# Infinite recursion
```

Watching how `guess` changes from one iteration to the next can solve both cases to a certain degree because it can avoid to call `(square guess)` that makes small number smaller and large number larger.

```scheme
(define (sqrt-iter guess last-guess x)
  (if (good-enough? guess last-guess)
      guess
      (sqrt-iter (improve guess x) guess x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess last-guess)
  (< (abs (- guess last-guess)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 0 x))
```

### Exercise 1.8

> Newton’s method for cube roots is based on the fact that if `y` is an approximation to the cube root of `x`, then a better approximation is given by the value
>
> $$
> \frac{x/y^2+2y}{3}
> $$
>
> Use this formula to implement a cube-root procedure analogous to the square-root procedure.

```scheme
(define (improve guess x)
    (/ (+ (/ x (* guess guess))
          (* 2 guess))
       3.0))

(define (good-enough? guess last-guess)
  (< (abs (- guess last-guess)) 0.001))

(define (cbrt-iter guess last-guess x)
    (if (good-enough? guess last-guess)
        guess
        (cbrt-iter (improve guess x) guess x)))

(define (cbrt x)
    (cbrt-iter 1.0 0.1 x))
```
