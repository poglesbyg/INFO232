% member(X,[X|Tail]).
% member(X,[Head|Tail]):-
%   member(X,Tail).

% Lecture 29.08.2014
person(ola,knutsen,1990).
student(pers(ola,knutsen,1990)).
student(pers(anna,olsen)).

same(X,X).

% point
point(1,1).
% line segment
segment(point(1,1), point(2,3)).
% triangle
triangle(point(4,2),point(6,4),point(7,1)).
% circle
circle(point(7,9), 5).

% '+' is a functor
% '>' is a relation

% concatenation => or combining two lists to get a third

conc([],L,L).
conc([X|L1],L2,[X|L3]) :-
  conc(L1,L2,L3).

member(X,L) :-
  conc(L1,[X|L2], L).

member1(X,L) :-
  conc(_,[X|_],L).

add(X,L,[X|L]).

del(X,L,L1).
del(X,[X|Tail],Tail).
del(X,[Y|Tail],[Y|Tail1]) :-
  del(X,Tail,Tail1).

insert(X, List, BiggerList) :-
  del(X, BiggerList, List).

sublist(S,L) :-
  conc(L1,L2,L),
  conc(S,L3,L2).

permutation([],[]).
permutation([X|L],P) :-
  permutation(L,L1),
  insert(X,L1,P).

permutation2([],[]).
permutation2(L,[X|P]) :-
  del(X,L,L1),
  permutation2(L1,P).
