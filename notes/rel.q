/ Relational algebra in Q

Relations can be implemented as 
                      | composition | negation | converse  | inclusion | union | meet | memory | row |  
    1. boolean matrix | E           | E        | E         | E         | E     | E    | On     | row |
    2. pair of array  | Hard        | ?        | E         | E         | E     | E    | On     | ?
   *3. dictionary     | E           | ?        | H         | H         | H     | H    | Best   | ?

Choose 3 because composition is the most common operation.

Goal: replace table algebra with relational algebra.

    select from t where x=a: meet with row vector.

    negation is a little hard in pair. We don't know the full universe, so it has to be lazy.  
So instead of just a pair, we implement is as a tuple of (tag; pair), while tag can be negation.
And we can use tag for row/col vector too.
   
\


/ left to right composition
com:{y(,/@)/:x }; conv:{=:(,/(#:'. x) #'!x)!,/. x};  In: { &/.  min' x in' y }; un:{?:'x,'y};
int:{x@&x in y}; mt:{#[;x](&0<#:'x:x int'y)};
neg:{(`neg;x)}; 

/ how do you compose with a negation?
/ meet with negation is except.

s: `Us`Fr`Ge`Br`Sp! (4 6 7 8 10; 1 4 7 10; 1 2 5 6 8 12; 1 2 7 9 11 12; 4 6 7 8 )
r: `Us`Fr`Ge`Br`Sp! (`2;`7`K; `3`5`7`8`Q; `2`7`Q`K; `2`4`5`8`J)
rs: `A`K`Q`J`0`9`8`7`6`5`4`3`2!(1+!12;1 6;1 2 12; 4 6 7 8; 1+!12;1+!12; 6 8; 1;1+!12;6 8; 6 7 8 ;1 2 5 6 8 12;7) 
