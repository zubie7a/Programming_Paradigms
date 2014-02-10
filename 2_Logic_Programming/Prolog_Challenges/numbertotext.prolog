

%relations between numbers and their textual form
%only for numbers with unique names, from then on
%some names can be composed.

%basic digits
rel(0,''). 
rel(1,one).
rel(2,two).
rel(3,three).
rel(4,four).
rel(5,five).
rel(6,six).
rel(7,seven).
rel(8,eight).
rel(9,nine).
%numbers from 10-19 which have unique names
rel(10,ten).
rel(11,eleven).
rel(12,twelve).
rel(13,thirteen).
rel(14,fourteen).
rel(15,fifteen).
rel(16,sixteen).
rel(17,seventeen).
rel(18,eighteen).
rel(19,nineteen).
%numbers from 20 to 90 which have unique names
%but only once every 10 numbers, the numbers in
%between are composed with basic digits and these
rel(20,twenty).
rel(30,thirty).
rel(40,forty).
rel(50,fifty).
rel(60,sixty).
rel(70,seventy).
rel(80,eighty).
rel(90,ninety).
%prefix according to position, every 3 numbers
%there is thousand, million, billion, etc
pos(0,'').
pos(1,'').
pos(2,'').
pos(3,thousand).
pos(4,'').
pos(5,'').
pos(6,million).
pos(7,'').
pos(8,'').
pos(9,billion).
pos(10,'').
pos(11,'').
pos(12,trillion).


%nomenclature for english numbers based on 
%http://www.eslcafe.com/grammar/saying_large_numbers01.html

%this receives a number of 3 digits, and a position (for the thousand/million...)
%and returns a list with that number in textual form

%in english, every 3 numbers are in the range of thousand, million, etc
%the usual dot in some numbers works to separate groups of 3 digits
%264 = two hundred sixty-four
%1.264 = one thousand  two hundred sixty-four
%111.264 = one hundred eleven thousand  two hundred sixty four
%7.111.264 seven million one hundred eleven thousand  two hundred sixty four
separate(N,L,Pos) :- A is N//100, B is mod(N,100), C is mod(N,10), D is (B-C),
               rel(A,X), pos(Pos,P), lasttwo(D,C,G), L = [X,H,G,P], 
               hundred(A,H).

%lasttwo receives D and C, the number in the units and tens. 
%if the number is between 10 and 19, then it has a unique name
%the two numbers are added, and rel is only true for numbers between 10 and 19
%D = 10, C = 5, N is 10+5, rel(15,G), so G is fifteen, and stops
%D = 20, C = 7, N is 20+7, rel(27,G), there is no rel with 27, so it goes on
%There is no rel(A,B) for number names that are composite, only for unique 
lasttwo(D,C,G) :- N is D+C, rel(N,G), !.
%otherwise is a composite number, and its formed by the name of the number in tens
%concatenated to a dash and the name of the units. composite names have a dash
%D = 20, C = 7, rel(20,Y) Y = twenty, rel(7,Z) Z = seven, G = twenty-seven 
lasttwo(D,C,G) :- rel(D,Y), rel(C,Z), atom_concat(Y,'-',I), atom_concat(I,Z,G).

%a number is followed by 'hundred' if it has a number greater than 0 in the hundreds place
hundred(A,hundred) :- A > 0, !.
hundred(_,'').

%num2txt receives a number, calls content with that numbers and returns a list, and the 
%list is given to writer, which writes it to the output screen.
num2txt(N) :- content(N,L,0), writer(L), !.
%content receives a number, the position, and returns a list.
%position jumps by 3 in each iteration, its the thousand, million, billion 
%the last three digits of a number are extracted and the number divided by 1000
%those three digits are sent to separate, which returns them in text, followed by the
%thousand, million or billion posfix. 
content(0,[],_) :- !.
content(N,LLL,Pos) :- X is mod(N,1000), NN is N // 1000, separate(X,L,Pos), NPos is Pos + 3, content(NN,LL,NPos), append(LL,L,LLL).

%writer receives a list, and will write the element at its head, then a space,
%then recurse with the tail
writer([]) :- !.
writer([''|Tl]) :- writer(Tl).
writer([Hd|Tl]) :- write(Hd), write(' '), writer(Tl).

%1011 one thousand eleven
%21011 twenty-one thousand eleven
%721011 seven hundred twenty-one thousand eleven
%1256721 one million two hundred fifty-six thousand seven hundred twenty-one
%31256721 thirty-one million two hundred fifty-six thousand seven hundred twenty-one
%631256721 six hundred thirty-one million two hundred fifty-six thousand seven hundred twenty-one
%1492638526 one billion four hundred ninety-two million six hundred thirty-eight thousand five hundred twenty-six
%41492638526	forty-one billion four hundred ninety-two million six hundred thirty-eight thousand five hundred twenty-six
%941492638526 nine hundred forty-one billion four hundred ninety-two million six hundred thirty-eight thousand five hundred twenty-six
 

