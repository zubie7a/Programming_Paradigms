%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%reads a prolog program from the current input stream to a file
in(File) :- tell(File), loop, told, !.

%outputs a prolog program from a file to the current output stream
out(File) :- see(File), loop, seen, !.

%loops reading lines from the current input stream and writing them to the current output stream
loop :- repeat, read(X), numbervars(X,0,_), write(X), write('.'), nl, X == end_of_file, !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%reads a prolog program from a file, and processes it into a list, to another file
%the new file name is the name of the original file with a 'processed' prefix
inProcess(File) :- atom_concat('process', File, To), tell(To), outProcess(File), told.

%reads a prolog program from a file, and processes it into a list, to the current output stream
outProcess(File) :- see(File), reader(L), numbervars(L,0,_), write(L), write('.'), nl, seen, !.

%starts reading lines and forming a list.
reader(L) :- read(X), process(X,L).

%if the line read is the 'end_of_file', it stops and returns an empty list
process(end_of_file,[]) :- !.

%otherwise, the line read is turned into a list, put at the head of another list, and reader
%is called again, so another line is read and then checked to be turned into a list or stop.
process(X,[H|T]) :- getList(X,H), reader(T).

%a naive predicateoutou to check if something is a list.
%isList([]) :- !.
%isList([_|T]) :- isList(T).

%when some predicate is read from the file, it must be turned into a list where the head is
%the head of the predicate, and the tail is its body, in case it has one. 
%getList(X,X) :- isList(X), !.
getList(X,[X]) :- var(X),!.
getList(X:-Y,[X|Z]):- getBody(Y,Z),!.
getList(X,[X]) :- !.
getBody(X,[X]) :- var(X), !.
getBody((X,Y),[X|Z]) :- getBody(Y,Z), !.
getBody(X,[X]) :- !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%the property to be checked is if a prolog program contains any rule where its head is a
%variable. The file name is given as File, then the predicate processes the contents of
%that file into a list, then the property is checked.
checkProperty(File) :- atom_concat('process', File, To), inProcess(File), noVarHead(To).

noVarHead(To) :- see(To), read(List), checklist(List, Result), answer(Result), seen, !. 

checklist([],[]) :- !.
checklist([H|T],[H|R]) :- H = [Hd|_], var(Hd), checklist(T,R), !. 
checklist([_|T],R) :- checklist(T,R).

answer([]) :- write('There are no rules in the program with variables at their head.'), nl, !.
answer(R) :- write('There are rules in the program with variables at their head. They are:'), nl, numbervars(R,0,_), answerer(R).

answerer([]) :- !.
answerer([X|T]) :- getList(Y,X), write(Y), write('.'), nl, answerer(T).
