findfactors(N,L) :- N >= 1, primefactors(N,L,2).

%prime factors of 1 is an empty list, no matter what the factor is
%this is like the base case, after a number has been divided by all
%its prime factors, the result will be 1.
primefactors(N,[N],N) :- !.
%F is a factor of N if mod(N,F) =:= 0, F becomes the head of a list, and the tail
%is a list created with the recursive call of primefactors with the division of N and F.
%F will keep being the same until it can no longer divide the number exactly
primefactors(N,[F|L],F) :- mod(N,F) =:= 0, Q is N // F, primefactors(Q,L,F), !.
%once the factor can't divide the number, the next possible factor will be found, and then
%recursively call the prime_factors with the new factor. 
primefactors(N,L,F) :- newfactor(N,F,NF), primefactors(N,L,NF). 
%F will always be a prime number because even if the new factors are found by iterating over
%odd numbers, odd numbers that are not prime will have been exhausted by its odd divisors.

%if the previous factor is 2, the next factor will always be 3. from then on, iterate over odds.
newfactor(_,2,3) :- !.
%the next factor will be the previous factor + 2 given that the previous
%factor is not 2 and its lower than the square root of the number 
newfactor(N,F,NF) :- F*F < N, NF is F+2, !.
%if it exceeds the square root, then the factor will keep being N.
newfactor(N,_,N).                                 
%it can only reach this if N is a prime number itself. afterwards, the remainder will be 1 and stop.
