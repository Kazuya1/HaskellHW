> {-# LANGUAGE NoMonomorphismRestriction #-}

> module Hw11S17
>    where

Homework:

You should remove most of the comments when you submit you solutions.  
Your solution should be about a page.



Problem 1: Write new definitions of this function:

> f = \xs -> [ mod 17 x | x <- xs, even x ]
  
   ...> f [4, -8, 99, 6, 3 ]
   [1,-7,5]
   

   Using explicit recursion and pattern-matching, without guards-- OR --
   using explicit recursion with guards but without pattern-matching.  You
   may use explicit arguments.
   
Problem 1 ANSWER:  

> f' lst
>	| lst == [] = []
>	| even (head lst) = [mod 17 (head lst)] ++ f' (tail lst)
>	| otherwise = f' (tail lst)

Problem 2
Define a primitive recursive function 'merge' that given two sorted lists returns 
a sorted list with all the unique elements from lists.  This can be used to help solve
the last problem.
e.g.
   ....> merge [1,8,9,100] [3,7,9,99,100]    
   [1,3,7,8,9,99,100]


Problem 2 ANSWER: 

> merge [] lst = lst
> merge lst [] = lst
> merge (x:xs) (y:ys)
>	| x>y = [y] ++ merge(x:xs) ys
>	| x==y = [x] ++ merge xs ys
>	| otherwise = [x] ++ merge xs (y:ys)

Problem 3:
Define a function replicate' which given a list of numbers returns a 
list with each number duplicated its value.   USE List Comprehension
Notation (this is a repeat of problem 8 from Haskell1 homework) 
     
     Hw11> replicate' [2, 4, 1]
     [2,2,4,4,4,4,1]

Problem 3 Answer:

> replicate' :: (Eq a, Num a, Enum a) => [a] -> [a]
> replicate' = \xs -> [ x | x <- xs, y <- [1..x] ]

Problem 4:
Define funcTuple that takes a list of binary operators and returns a list values.  
The values are the result of appling the operator to a tuple, t . 
You need to use List Comprehension Notation in your solution.  
Hint you may want to use  'uncurry'. 

       Hw11> funcTuple [(+), (-), mod, \x y -> div (x+y) 2] (7,51)
       [58,-44,7,29]


Problem 4 ANSWER:  

> funcTuple = \ops (a,b) -> [ op a b | op <- ops ]

Problem 5:  
Given the following definition of a binary tree:

> data Tree a = Nil | Node a (Tree a) (Tree a) deriving (Show)

A (Tree a) data type is considered to be equal if 
 1) the parameterized type a is an instance of Eq
 2) the trees same structure and equal values. 
Implement the Haskell code to make the Tree data type an instances of 
the type Class Eq. 

Look up the the Class Functor.  (Do not assume the parameterized is an instance
of Eq.)  Make (Tree b) an instance of the type Class Functor

Problem 5 ANSWER:

> instance (Eq a) => Eq (Tree a) where
>	Nil == Nil = True
> 	Node a b c == Node d e f = (a==d) && (b==e) && (c==f)
>	_ == _ = False

> instance Functor Tree where
>	fmap f Nil = Nil
>	fmap f (Node a b c) = Node (f a) (fmap f b) (fmap f c)

Problem 6: (Thompson)
  Find functions f1 and f2 so that
 
   s1 =  map f1 . filter f2

  has the same effect as
 

> p1 = filter (>0) . map (+1)

 
  ....> p1 [-4,4, -3,3,12,-12]
  [5,4,13]
 
  ....> s1 [-4,4, -3,3,12,-12]
  [5,4,13]
 
  
Problem 6 ANSWER:  

> f1' = (+1)
> f2' = (>1)
> s1 =  map f1' . filter f2'

Problem 7. 
Using higher order functions (map, fold or filter) and if necessary lambda
expressions. Write a definition for f1 and f2 so the following evaluation 
is valid:  (hint: a lambda expressions could be useful).

     f1 (f2 (*) [1,2,3,4]) 5  ~> [5,10,15,20]

     Main> f1 ( f2 (*) [1,2,3,4]) 5
     [5,10,15,20]


Problem 7 ANSWER:  

> f2 op lst = map (\x -> op x) lst
> f1 lst n = map (\x -> x n) lst


Problem 8:


In a previous homework you defined a function composeList which composes 
a list of functions into a single function.
 
    ...> composeList [ (-) 2, (*) 5, (-) 3] 10
   37


Redo this problem using hof. The definition should use a 'fold' and it 
   should be only be one line AND no explicit arguments (i.e. complete
   composeHOF = ?????).
   
Problem 8 ANSWER:  

> composeHOF = (\lst n -> (foldr (\x y-> x y) n lst))

Problem 9: (from http://en.wikipedia.org/wiki/Thue%E2%80%93Morse_sequence )
In previous homework 10 problem 6 you wrote a primitive recursive function to
produce the next element in the Thue-Morse sequence, 
(also know as Prouhet-Thue-Morse sequence)

One possible solution is 

> thue (s:sx) = (mod s  2 ) : (mod (s +1)  2): thue sx
> thue [ ] = [ ]



  a) Redefine thue using 'map' instead of explicit recursion. My solution 
     was coded using (++), map, lambda expression and mod.  Call this
     function 'thueMap'.  This can be done with 1 line of code.

  b) Define thueSeq which is a sequence of "thue elements" using the circular
     list illustrated in class for fibseq
      (http://bingweb.binghamton.edu/~head/CS471/NOTES/HASKELL/4hF02.html)
       -- Call this function 'thueMapSeq'.  You may use thue OR thueMap in your
       definition of thueMap.  This can be done with one line of code.
 
     *.......> thueMap [0,1,1,0,1,0,0,1]
      [0,1,1,0,1,0,0,1,1,0,0,1,0,1,1,0]
     *.......> take 4 thueMapSeq 
      [[0],[0,1],[0,1,1,0],[0,1,1,0,1,0,0,1]]


Problem 9 ANSWER:  

> thueMap lst = lst ++ map (\x -> (mod (x+1) 2)) lst
> thueMapSeq = [0] : [ thue b | (a,b) <- zip [1..] thueMapSeq ]

Problem 10.
Using an  HOF (map, fold and/or filter) define flattenT that returns a list of
value in each tuple.  

The output should be in the same order as the values appear in the 
     original list.
e.g.

   ...> flattenT  [(1,2), (3,4), (11,21),(-5,45)] 
   [1,2,3,4,11,21,-5,45]

Problem 10 ANSWER:  

> flattenT lst = foldl1 (++) (map (\(x,y) -> [x,y]) lst)

Problem 11: flattenR is the same as 3, however, the values appear in the reverse order
   from the original list.
e.g.
   ...> flattenR  [(1,2), (3,4), (11,21),(-5,45)] 
   [45,-5,21,11,4,3,2,1]
--------------------
   
Problem 11 ANSWER:  
   
> flattenR lst = foldr1 (\ a b -> b++a) (map (\(x,y) -> [y,x]) lst)

Problem 12:  (Thompson 17:30/17.24)
Define the list of numbers whose only prime factors are 2, 3, and 5, the
so-called Hamming numbers:


   ...> take 15 hamming
   [1,2,3,4,5,6,8,9,10,12,15,16,18,20,24]


 You may consider using any combinition of the following techiques
       to express your solution  list comprehension notation, HOF,
       and/or explicit recursion, and/or local definitions .  You may include your
       merge defined above.

(Hint: Apply the circular list idea demostrated in fibSeq
  (http://bingweb.binghamton.edu/%7Ehead/CS471/NOTES/HASKELL/4hF02.html)) 
           

Problem 12 ANSWER:  

> helper 1 = True
> helper x
>	| mod x 5 == 0 = helper (div x 5)
>	| mod x 3 == 0 = helper (div x 3)
>	| mod x 2 == 0 = helper (div x 2)
>	| otherwise = False
> hamming = filter helper [1..]
