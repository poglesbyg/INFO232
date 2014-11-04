% Author:
% Date: 16.10.2014

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
     
