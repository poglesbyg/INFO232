alertlevel(X,green) :- X<3,!.
alertlevel(X,yellow) :- X<6,!.
alertlevel(X,red).

max(X,Y,X) :- X >= Y.
max(X,Y,Y) :- X < Y.

max1(X,Y,X) :- X>=Y,!.
max1(X,Y,Y).

add(X,L,L) :- member(X,L), !.
add(X,L,[X|L]).

intelligent(per).
intelligent(pal).
intelligent(espen).