% Leser en fil bestaaende av termer, og returnerer en liste
% av disse termene.
% Listen avsluttes med atomet end_of_file.
lesFil(FilNavn, Lines) :-
    open(FilNavn, read, Str),
    lesFil_hp(Str,Lines),
    close(Str),
    !.

lesFil_hp(Stream,[]) :-
    at_end_of_stream(Stream).

lesFil_hp(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    lesFil_hp(Stream,L).

% Lar meg skrive inn ruter og stedsinfo uten aa maatte punche inn
% filnavn manuelt.
skrivDataBase:-
	lesFil('stedsinfo.txt',StedStreng),
	skrivStedsinfo(StedStreng),
	lesFil('reiseruter-2.txt',RuteStreng),
	skrivReiseruter(RuteStreng).

skrivStedsinfo([end_of_file]).
skrivStedsinfo([Navn,Popu,Status,Fact,Xko,Yko|Tail]):-
	assert(sted(Navn,Popu,Status,Fact,Xko,Yko)),
	skrivStedsinfo(Tail).

skrivReiseruter([end_of_file]).
% Tektsfilen med reiseruter har feil format for ruter med fly. Tall for
% tid/penger ser ut til aa ha byttet plass.
skrivReiseruter([Fra,Til,'fly',Penger,Tid|Tail]):-
	assert(route(Fra,Til,'fly',Tid,Penger)),
	skrivReiseruter(Tail).
skrivReiseruter([Fra,Til,Doning,Tid,Penger|Tail]):-
	assert(rute(Fra,Til,Doning,Tid,Penger)),
	skrivReiseruter(Tail).

:- skrivDataBase.
%opg1.1
beskriv(Navn):-
	sted(Navn,Popu,Status,Fact,_,_),
	write(Navn), write(' er en '), write(Status), write(' med '),
	write(Popu), write(' innbyggere.'), nl, write(Fact), write('.').

%opg1.2
% skriver ogsaa ut lengden til listen. Hvis mer enn 11 har databasen
% blitt skrevet inn flere ganger.
listByer(List):-
	findall(Navn,sted(Navn,_,_,_,_,_),List),
	length(List,X),
	write(X).

%opg1.3
% Sann hvis det finnes rute mellom to oppgitte steder, uavhengig av
% rekkefoelge
rute(Fra,Til):-
	route(Fra,Til,_,_,_);
	route(Til,Fra,_,_,_).

%opg2
finnReiseRaskest(Fra,Til):-
	assert(goal(Til)),
        bestfirst(Fra,Sol),
	reverse(Sol,RuteListe),
	utskrift(RuteListe,TotalTid,TotalPris),
	Timer is TotalTid//60, Minutt is TotalTid rem 60,
	write('Total reisetid: '),write(Timer),write(' timer og '),
	write(Minutt),write(' minutter.'),nl,
	write('Total kostnad: '),write(TotalPris),write(' NoK.'),
	retractall(goal(_)).

% Rekursivt predikat som tar seg av utskrift av detaljer for reisen ved
% aa finne raskeste rute mellom stedene i listen returnert av A*
utskrift([_|[]],Tid,Pris):- Tid is 0, Pris is 0,true.
utskrift([Fra,Til|Tail],TotalTid,TotalPris):-
	findall(KT1/Tid1/Pr1,route(Fra,Til,KT1,Tid1,Pr1),RuteSpecs),
	minRute(RuteSpecs,KT/Tid/Pr),
	write(KT),write(' fra '),write(Fra),write(' til '),write(Til),write(.),nl,
	utskrift([Til|Tail],TotalTid1,TotalPris1),
	TotalTid is +(TotalTid1,Tid), TotalPris is +(TotalPris1,Pr).

% Tar inn en liste med tripler og returner den med kortest tid.
% Mellom to byer kan det finnes maks tre ruter.
minRute([H|[]],H).
minRute([H1,H2|[]],Out):-
	H1 = _/Tid1/_,
	H2 = _/Tid2/_,
	(   Tid1 =< Tid2, Out = H1); Out = H2.
minRute([H1,H2,H3|[]],Out):-
	H1 = _/Tid1/_,
	H2 = _/Tid2/_,
	H3 = _/Tid3/_,
	(   (Tid1 =< Tid2), (Tid1 =< Tid3), Out = H1);
	(   (Tid2 =< Tid1), (Tid2 =< Tid3), Out = H2);
	(   (Tid3 =< Tid1), (Tid3 =< Tid2), Out = H3).

% Sann hvis det finnes rute fra N til M, C er kostnad(tid)
s(N,M,C):-
	route(N,M,_,C,_).

% H er luftlinje mellom N og goal. X-koordinatet er kilometer oest for
% Reykjavik, Y-koordinatet er antall kilometer soer.
% Heuristikk maa aldri gi H en verdi som er hoeyere enn den faktiske
% optimale kostnaden mellom N og Goal, derfor er luftlinje et fint maal.
% Den er alltid lik eller mindre.
h(N,H):-
	goal(Goal),
	sted(N,_,_,_,Xko1,Yko1),
	sted(Goal,_,_,_,Xko2,Yko2),
	XKatet is -(Xko1,Xko2),
	YKatet is -(Yko1,Yko2),
	H is sqrt(+(XKatet^2,YKatet^2)).


bestfirst(Start,Sol) :-
     expand([path([Start],0,0)],Sol).

expand([path([N|Tail],_,_)|_],[N|Tail]) :- goal(N),!.
expand([path([N|Tail],G,_)|Rest],Sol) :-
     findall(M/C,(s(N,M,C),\+member(M,Tail)),Succ),
     succlist(G,Succ,[N|Tail],Paths),
     addsucclist(Paths,Rest,Newpaths),
     expand(Newpaths,Sol).

succlist(_,[],_,[]).
succlist(G0,[N/C|Rest],Tail,[path([N|Tail],G,F)|Restpaths]) :-
     G is G0+C,
     h(N,H),
     F is G+H,
     succlist(G0,Rest,Tail,Restpaths).

addsucclist([],Newpaths,Newpaths).
addsucclist([Head|Tail],Rest,Newpaths) :-
     insertordered(Head,Rest,Paths),
     addsucclist(Tail,Paths,Newpaths).

insertordered(P0,[P1|Rest],[P0,P1|Rest]) :-
     f(P0,F0),
     f(P1,F1),
     F0 < F1,!.
insertordered(P0,[P1|Rest], [P1|Newrest]) :-
     insertordered(P0,Rest,Newrest).
insertordered(P,[],[P]).

f(path(_,_,F),F).
g(path(_,G,_),G).

