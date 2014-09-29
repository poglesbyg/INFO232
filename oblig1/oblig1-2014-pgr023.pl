% Written by Paul Grant

% Innebygde predikater dere ikke skal endre på.
skrivDatoNorsk(Dato) :-
	Dato = dato(AAr, Maaned, Dag),
	gyldigDato(Dato),
	maanedNavn(Maaned, Navn),
	write(Dag), write('. '), write(Navn), write(', '), write(AAr).
	
% 1.1 maanedNavn
maanedNavn(Maaned, Navn) :-
	Maaned = 1, Navn = januar;
	Maaned = 2, Navn = februar;
	Maaned = 3, Navn = mars;
	Maaned = 4, Navn = april;
	Maaned = 5, Navn = mai;
	Maaned = 6, Navn = juni;
	Maaned = 7, Navn = juli;
	Maaned = 8, Navn = august;
	Maaned = 9, Navn = september;
	Maaned = 10, Navn = oktober;
	Maaned = 11, Navn = november;
	Maaned = 12, Navn = desember.
	
% 1.2 gyldigDato
gyldigDato(dato(AAr, Maaned, Dag)) :-
  integer(AAr),
	(Maaned >= 1, Maaned =< 12),
	(Maaned = 1, Dag =< 31;
	Maaned = 2, Dag =< 28;
	Maaned = 3, Dag =< 31;
	Maaned = 4, Dag =< 30;
	Maaned = 5, Dag =< 31;
	Maaned = 6, Dag =< 30;
	Maaned = 7, Dag =< 31;
	Maaned = 8, Dag =< 31;
	Maaned = 9, Dag =< 30;
	Maaned = 10, Dag =< 31;
	Maaned = 11, Dag =< 30;
	Maaned = 12, Dag =< 31).
	
% 1.3 iPeriode(periode(dato(AAr1, Maaned1, Dag1), dato(AAr2, Maaned2, Dag2)), dato(AAr3, Maaned3, Dag3)).
iPeriode(periode(dato(AAr, Maaned, Dag), dato(AAr, Maaned, Dag)), dato(AAr, Maaned, Dag)).

iPeriode(periode(dato(AAr1, Maaned1, Dag1), dato(AAr2, Maaned2, Dag2)), dato(AAr3, Maaned3, Dag3)) :-
	between(AAr1,AAr2,AAr3),
	Maaned1 < Maaned3, Maaned3 < Maaned2,
	iPeriode(periode(dato(AAr1, Maaned1, Dag1), dato(AAr2, Maaned2, Dag2)), dato(AAr3, Maaned3, Dag3)).
	
iPeriode(periode(dato(AAr1, _, Dag1), dato(AAr2, _, Dag2)), dato(AAr3, _, Dag3)) :-
	between(AAr1,AAr2,AAr3),
	not(between(Dag1,Dag2,Dag3)).

% Ferdige hendelser til Del 2, så dere har ferdige testdata. Disse er brukt i oppgaveteksten.
hendelse('Rothaugen Skole', dato(2014, 9, 24), 'Loppemarked klokken fire til seks').
hendelse('Hjemme, foran TVen', dato(2014, 9, 24), 'Ny episode av $TVPROGRAM fra Netflix').
hendelse('kino', dato(2014,9,24), 'Guardians of the galaxy').
hendelse('Magnus Barfot', dato(2014, 9, 26), 'Kinodate').
hendelse('Hjemme', dato(2014, 9, 27), 'Koselaurdag').

% 2.1 skrivHendelse(hendelse(’Rothaugen Skole’, dato(2014, 9, 24), ’Loppemarked klokken fire til seks’))
skriveHendelse(hendelse(Sted,Dato,Ting)) :-
	write('Den '), skrivDatoNorsk(Dato),write(': '), write(Ting), write('. Sted: '), write(Sted),nl.

% 2.2 skrivHendelserForDato(Dato)
skrivHendelserForDato(Dato) :-
	not(helpPredicate(Dato)).

helpPredicate(Dato) :- 
	skrivDatoNorsk(Dato), write(':'),nl,
	hendelse(Sted,Dato,Ting),
	write('    '), write(Ting), write('. Sted: '), write(Sted), write('.'),nl,
	Sted \= Sted, Ting \= Ting.
	
% 2.3 skrivHendelserMellom(periode(dato(AAr1, Maaned1, Dag1), dato(AAr2, Maaned2, Dag2)))
skrivHendelserMellom(periode(dato(AAr1, Maaned1, Dag1), dato(AAr2, Maaned2, Dag2))) :-
	not(helpPredicate1(periode(dato(AAr1, Maaned1, Dag1), dato(AAr2, Maaned2, Dag2)))).

helpPredicate1(periode(dato(AAr1, Maaned1, Dag1), dato(AAr2, Maaned2, Dag2))) :-
	maanedNavn(Maaned1,Navn1), maanedNavn(Maaned2,Navn2),
	write('Mellom '), write(Dag1),write(' '), write(Navn1),write(' '), write(AAr1), write(', og '), write(Dag2), write(' '),
	write(Navn2), write(' '), write(AAr2), write(':'),nl,
	hendelse(Sted,Dato,Ting),
	iPeriode(periode(dato(AAr1, Maaned1, Dag1), dato(AAr2, Maaned2, Dag2)),Dato),
	write('    '),skrivDatoNorsk(Dato), write(': '), write(Ting), write('Sted: '), write(Sted), write('.'),nl,
	Sted \= Sted, Ting \= Ting.