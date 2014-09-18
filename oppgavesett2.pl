vertical( seg( point(X1,Y1), point(X1,Y2))).
horizontal( seg( point(X1,Y1), point(X2,Y1))).

%seg(point(5,0),point(5,5)).

rectangle(P1,P2,P3,P4) :-
  vertical(seg(P1,P2)),
  horizontal(seg(P2,P3)),
  vertical(seg(P3,P4)),
  horizontal(seg(P4,P1)).

f(1,one).
f(s(1),two).
f(s(s(1)),three).
f(s(s(s(1))),N) :-
  f(X,N).

% relatives(X,Y) :-
%   ancestor(X,Y).
%
% relatives(X,Y) :-
%   ancestor(Y,X).

relatives(X,Y) :-
  ;(ancestor(X,Y), ancestor(Y,X)),
  \=(X,Y).

relatives(X,Y) :-     % X and Y have a common ancestor
  ancestor(Z,Y),
  ancestor(X,Y).

relatives(X,Y) :-     % X and Y have a common successor
  ancestor(X,Z),
  ancestor(Y,Z).

% translate(Number,Word) :-
%   Number = 1, Word = one;
%   Number = 2, Word = two;
%   Number = 3, Word = three.

translate(Number,Word) :-
  Number = 1, Word = one.

translate(Number,Word) :-
  Number = 2, Word = two.

translate(Number,Word) :-
  Number = 3, Word = three.

% What does the clock say?

klokkesekvensen(ingenting).
klokkesekvensen(tikk(X)) :- klokkesekvensen(X).
klokkesekvensen(takk(X)) :- klokkesekvensen(X).

isa(animal,mammal).
isa(mammal,cat).
isa(cat,mons).
isa(cat,pusur).
isa(cat,felix).
isa(cat,tom).
isa(mammal,dog).
isa(dog,pluto).
isa(dog,lassie).
isa(dog,laika).

isa2(X,Y).

isa2(X,Y) :-
  isa(X,Z),isa2(Z,Y).
