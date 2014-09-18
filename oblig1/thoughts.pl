iPeriode(periode(dato(AAr, Maaned, Dag), dato(AAr, Maaned, Dag)), dato(AAr, Maaned, Dag)).

iPeriode(periode(dato(AAr1, Maaned1, Dag1), dato(AAr2, Maaned2, Dag2)), dato(AAr3, Maaned3, Dag3)) :-
	between(AAr1,AAr2,AAr3),
	Maaned1 < Maaned3, Maaned3 < Maaned2,
	iPeriode(periode(dato(AAr1, Maaned1, Dag1), dato(AAr2, Maaned2, Dag2)), dato(AAr3, Maaned3, Dag3)).
	
iPeriode(periode(dato(AAr1, Maaned1, Dag1), dato(AAr2, Maaned2, Dag2)), dato(AAr3, Maaned3, Dag3)) :-
	between(AAr1,AAr2,AAr3),
	not(between(Dag1,Dag2,Dag3)). 
