main :- write('Hello World').

member(X, [X|_]).
member(X, [_|T]) :-
    member(X, T).

three(List) :-
    length(List, X),
    X == 3.

differentFromRest(List) :-
\+ (select(X, List, R), memberchk(X,R)).

revl2([X,Y],L2) :- L2 = [Y,X].
revl2([X|L1],[X|L2]) :- revl2(L1, L2).

sum_list([], 0).
sum_list([H|T], Sum) :-
    sum_list(T, Rest),
    Sum is H + Rest.

%% [[5,3,1], [4,4,6], [6,2,1], [1,4,3]]

sum_rows([],[]).
sum_rows([Head|Tail], [Ret|Return]) :-
    sum_list(Head, Ret),
    sum_rows(Tail, Return).

sum_columns([],[]).
sum_columns([Head|Tail], [Ret|Return]) :-
    sum_list(Head,Ret),
    sum_columns(Tail, Return).
