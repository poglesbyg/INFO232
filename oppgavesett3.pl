% Oppgavesett3
% membership in a list
member(X, [X | Tail]).
member(X, [Head| Tail]) :-
  member(X,Tail).

% concatenation of two lists
conc([],L,L).
conc([X|L1],L2,[X|L3]) :-
  conc(L1,L2,L3).

% member defined with conc
member1(X,L) :-
  conc(_,[X|_],L).

% adding an item to a list
add(X,L,[X|L]).

% deleting an item from a list
del(X,[X|Tail],Tail).
del(X,[Y|Tail],[Y|Tail1]) :-
  del(X, Tail, Tail1).

% inserting an element in a list
insert(X,List,BiggerList) :-
  del(X,BiggerList,List).

% member using delete
member2(X,List) :-
  del(X,List,_).

% sublist, or can an order of elements be found in a list
sublist(S,L) :-
  conc(L1,L2,L),
  conc(S,L3,L2).

% permutation, several different ways of writing this
permutation([],[]).
permutation([X|L],P) :-
  permutation(L,L1),
  insert(X,L1,P).

permutation1([],[]).
permutation1(L,[X|P]) :-
  del(X,L,L1),
  permutation1(L1,P).

% Exercises:
%
% 3.3 define 2 predicates evenLength(L) and oddLength(L)
evenLength([]).
evenLength([_|Tail]) :-
  oddLength(Tail).

oddLength([_|Tail]) :-
  evenLength(Tail).

rev([],[]).
rev([H|T],R) :-
  rev(T,RevT), append(RevT,[H],R).

accRev([], Acc, Acc).
accRev([H|T], Acc, Rev) :-
  accRev(T, [H|Acc], Rev).

palindrome(List) :-
  reverse(List,List).

shift([H|T], List) :-
  append(T, [H], List).

equal_length(L1,L2) :-
  length(L1,X), length(L2,X).

% flatten already defined so named spatten
spatten([],[]).
spatten([H|T],[H|FlatTail]) :-
  not(H = [_|_]),
  spatten(T, FlatTail).
spatten([[SH|ST]|Tail], FlatList) :-
  spatten([SH|ST], Flattened),
  spatten(Tail, Flattend2),
  append(Flattened, Flattend2, FlatList).

size([],0).
size([_|T],N) :-
  size(T,N1), N is N1 + 1.

how_many(_, [], 0).
how_many(What, [Something|Tail], Total) :-
  not(What = Something),
  how_many(What, Tail, Total).
how_many(What, [What|Tail], Total) :-
  how_many(What, Tail, SubTotal),
  Total is SubTotal + 1.

max(X, Y, X) :-
  X >= Y.
max(X, Y, Y) :-
  Y > X.

% maxList(List, Max)
maxList([H],H).

maxList([H|T], Max) :-
  maxList(T,Tmax),
  max(H,Tmax, Max).
