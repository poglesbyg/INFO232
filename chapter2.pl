% chapter2.pla

parent(pam,bob).
parent(tom,bob).
parent(tom,liz).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).

male(tom).
male(bob).
male(jim).
female(liz).
female(pam).
female(pat).
female(ann).

has_a_child(X) :- parent(X, _).

% line properties

vertical( seg( point(X1,Y1), point(X1,Y2))).
horizontal( seg( point(X1,Y1), point(X2,Y1))).

% big and dark

f(1,one).
f(s(1), two).
f(s(s(s)), three).
f(s(s(s(X))),N) :-
  f(X,N).

big(bear).
big(elephant).
small(cat).
brown(bear).
black(cat).
gray(elephant).

dark(Z) :-
  black(Z).

dark(Z) :-
  brown(Z).

% food and wine

meat(beef). meat(chicken). meat(fish).
wine(red).  wine(rose).    wine(white).
