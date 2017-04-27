> module Hw10S17
>     where
     
Add your code to this file.  You will need to remove the spaces before ">" for the types to become part of your code.

The following 3 problems introduce the idea of currying (https://en.wikipedia.org/wiki/Currying).
Problem 1:  Given the following definition of s2:

 > s2 = (+)

To make things easy use the prefix notation for the operators.   For example: (*) 3 2 would evaluator to 6. 
What is the type of s2?  What is it's value in words.

s2 :: Integer -> Integer -> Integer
s2 will take two integers as the parameter and return an integer as the result of the function.

Problem 2:  Given the following definition of s1:

 > s1 = s2 99

What is the type of s1?  What is it's value in words.   What is the value of
10 applied to s1 ? (i.e) > s1 10
Problem 2 Answer:

Type is:
s1 :: Integer -> Integer
When 10 is applied to s1, the result is:
109

Problem 3:

Write a function "sumAll" that takes a list of numbers and returns their sum.  This must be a recursive solution.

Problem 3 Answer:

> sumALL :: Num a => [a] -> a
> sumALL [] = 0
> sumALL (x:xs) = x + sumALL xs

Problem 4:

Write a function "binOpALL op lst" that takes a binary operator and a list of numbers and returns the result of appling the 'op' to the values in list.   

Problem 4 Answer:

> binOpALL :: Num a => (a -> a -> a) -> [a] -> a
> binOpALL op (x:[]) = x
> binOpALL op (x:xs) = op x (binOpALL op xs)

Problem 5:
Write a recursive function "insertAt v p lst" that inserts a value v at position p in list lst. 
If p is greater than the length of lst, simply insert it at the end.

Remember, Haskell is "pure", so you may not modify ls. Instead, you should recurse and build a new list from ls with v inserted. 

Problem 5 Answer:

> insertAt :: (Eq a, Num a) => b -> a -> [b] -> [b]
> insertAt v 0 lst = v:lst
> insertAt v x [] = [v]
> insertAt v p (x:xs) = [x]++(insertAt v (p-1) xs)

Problem 6.
Define a function composeList which composes a list of functions into a single function. Assume the list of functions is not empty.  Define composeList using primitive recursion.
  
 
    ...> composeList [ (*) 2, (*) 2] 2
    8
    ...> composeList [ (-) 3 , (*) 2, (+)5 ] 7 
    -21


Problem 6 Answer:

> composeList :: Num a => [a -> a] -> a -> a
> composeList [] x = x
> composeList lst x = composeList (init lst) ((last lst) x)

Problem 7: (from http://en.wikipedia.org/wiki/Thue%E2%80%93Morse_sequence )
"In mathematics, the Thue-Morse sequence, or Prouhet-Thue-Morse sequence, is a 
binary sequence that begins:

  0 01 0110 01101001 0110100110010110 01101001100101101001011001101001 ...

(if your sequence starts with one..)
    1 10 1001 10010110 1001011001101001...."

...
"Characterization using bitwise negation

The Thue–Morse sequence in the form given above, as a sequence of bits, 
can be defined recursively using the operation of bitwise negation. So, the 
first element is 0. Then once the first 2n elements have been specified, 
forming a string s, then the next 2n elements must form the bitwise negation of 
s. Now we have defined the first 2n+1 elements, and we recurse.

Spelling out the first few steps in detail:

    * We start with 0.
    * The bitwise negation of 0 is 1.
    * Combining these, the first 2 elements are 01.
    * The bitwise negation of 01 is 10.
    * Combining these, the first 4 elements are 0110.
    * The bitwise negation of 0110 is 1001.
    * Combining these, the first 8 elements are 01101001.
    * And so on.
So
    * T0 = 0.
    * T1 = 01."
    
Define a primitive recursive function 'thue' given the nth thue element returns
the next thue element.  The elements will be represented as a list of 0s and 1s.
e.g.
   HW10> thue [0,1,1,0]
   [0,1,1,0,1,0,0,1]


Problem 7 Answer:

> thue list = list ++ flip list
> 	where
> 		flip[] = []
> 		flip (0:list) = 1 : flip list
> 		flip (1:list) = 0 : flip list

Problem 8:
Define a function replicate' which given a list of numbers returns a 
list with each number duplicated its value.   Use primitive recursion in your
definition. You may use a nested helper definition. eg.
     
     HW10> replicate' [2, 4, 1]
     [2,2,4,4,4,4,1]

Problem 8 Answer:

> replicate' :: (Eq a, Num a) => [a] -> [a]
> replicate' [] = []
> replicate' (x:xs) = helper(x,x)++replicate'(xs)
> 	where
> 		helper(x,0) = []
> 		helper(x,y) = [x]++helper(x,y-1)

Problem 9: 
Implement Newton's method for calculating the square root of N. Your definition should use primitive recursive style.  See (http://bingweb.binghamton.edu/~head/CS471/HW/Haskell1S17.html) webpage for definition of Newton method for the approximation of roots. 
 Your definition should include a user defined (input) "guess" value and a user defined "nearEnough" value.  
"nearEnough" is use to determine when the guess is close enough to the square root.  (guess*guess = number) 
You should use locally defined helper functions to make your code more readable. You may use guards or "if expression"

e.g. 
   Haskell1> newtonAppr 144 1 0.1             
   12.000545730742438 
   Haskell1> newtonAppr 144 1 0.0001
   12.0000000124087
   Haskell1> newtonAppr 144 1 0.000000000000001
   12.0
   Haskell1> newtonAppr 5e+30 1 1000000000000000000000000000000  
   2.317148867384728e15
   Haskell1> newtonAppr 5e+30 1 100000000000000000000000000    
   2.2360684271923805e15

Problem 9 Answer:
Note you may have a slightly different type depending on your solution.

> newtonAppr :: (Fractional a, Ord a) => a -> a -> a -> a
> newtonAppr target guess nearEnough
> 	| abs (target - guess*guess) < nearEnough = guess
> 	| otherwise = newtonAppr target ((target/guess+guess)/2) nearEnough
