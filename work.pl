sist([X],X,[]).
sist([Y|Ys], X, [Y | Xs]) :- 
	sist(Ys, X, Xs).

palindrome([A|As]) :-
	sist(As, B, Rest),
	A == B, 
	palindrome(Rest).

main :-
	palindrome([a,b,b,a]).

main.
