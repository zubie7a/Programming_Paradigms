%gt(A,B,R) determines the greater value between two numbers.
%if A > B, then its A and it stops. Otherwise, it keeps checking
%clauses, and finds a clause that no matter what the first number
%is, the second is the greater value.
gt(A,B,A) :- A > B, !.
gt(_,B,B).

%maxn(T,N) where T is a tree, and N is the greatest
%number on that tree. A tree is t(V,L,R) where V is the node
%value, L is the left children and R is the right children.
maxn(t(A,nil,nil),A) :- !.
maxn(t(A,B,nil),X) :- maxn(B,M), gt(A,M,X), !.
maxn(t(A,nil,C),X) :- maxn(C,N), gt(A,N,X), !.
maxn(t(A,B,C),X) :-   maxn(B,M), maxn(C,N), gt(M,N,Z), gt(A,Z,X).

%mirror(A,B) receives a binary tree and returns its mirrored image. 
mirror(nil,nil).
mirror(t(N,A,B), t(N,C,D)) :- mirror(B,C), mirror(A,D).
