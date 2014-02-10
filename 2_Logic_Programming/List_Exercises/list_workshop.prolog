%very slow list reversal
reverse([],[]).
reverse([H|T],L) :- reverse(T,NT), append(NT,[H],L). 

%faster list reversal
reverse2(L,R) :- accRev(L,[],R).
accRev([],A,A).
accRev([H|T],A,R):-  accRev(T,[H|A],R). 

%max element inside a list
max([H],H) :- !.
max([H|T],H):- max(T,Y), H >= Y, !.
max([H|T],N):- max(T,N), N > H.
