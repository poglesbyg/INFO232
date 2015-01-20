%% naive sort
naive_sort(List, Sorted) :-
    permutation(List,Sorted), is_sorted(Sorted).

is_sorted([]).
is_sorted([_]).
is_sorted([X,Y|T]) :-
    X =< Y,
    is_sorted([Y|T]).

%% insert sort
insert_sort(List, Sorted) :- i_sort(List, [], Sorted).

i_sort([], Acc, Acc).
i_sort([H|T], Acc, Sorted) :-
    insert(H,Acc,NAcc),
    i_sort(T, NAcc, Sorted).

insert(X, [Y|T], [Y|NT]) :-
    X > Y,
    insert(X,T,NT).
insert(X, [Y|T], [X,Y|T]) :-
    X =< Y.
insert(X, [], [X]).

%% bubble sort
bubble_sort(List, Sorted) :-
    b_sort(List, [], Sorted).

b_sort([], Acc, Acc).
b_sort([H,T], Acc, Sorted) :-
    bubble(H, T, NT, Max), b_sort(NT, [Max|Acc], Sorted).

bubble(X,[],[],X).
bubble(X,[Y|T],[Y|NT],Max) :-
    X>Y,
    bubble(X,T,NT,Max).
bubble(X,[Y|T],[X|NT],Max) :-
    X=<Y,
    bubble(Y,T,NT,Max).
