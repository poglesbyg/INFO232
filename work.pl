lessThan(X, X).
lessThan(X, Y) :-
  Y > X,
  Z = X,
  write(Z),
  lessThan(X, Z).


main :- lessThan(3, 2).