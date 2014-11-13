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

readStead :-
    lesFil('stedsinfo.txt',Read),
    createPlaces(Read).

createPlaces([end_of_file]).
createPlaces([Name, Pop, Status, Fact, CoordX, CoordY | Rest]) :-
    assert(city(Name, Pop, Status, Fact, CoordX, CoordY)),
    createPlaces(Rest).

% beskriv/1 takes in a city name and prints out a short 
% description of it
beskriv(Name) :-
    city(Name, Pop, Status, Fact, CoordX, CoordY),
    write(Name), write(' er en '), write(Status),
    write(' med '), write(Pop), write(' innbyggere.'),nl,
    write(Fact).

% listByer/1 gives a list of all the cities

listByer(List) :-
    findall(Name, city(Name, _,_,_,_,_),List).

readRoutes :-
    lesFil('reiseruter-2.txt',Read),
    createRoutes(Read).

createRoutes([end_of_file]).

createRoutes([Start, End, 'fly', TimeInMin, Price| Rest]) :-
    assert(rute(Start, End, Transportation, Price, TimeInMin)),
    createRoutes(Rest).

createRoutes([Start, End, Transportation, TimeInMin, Price | Rest]) :-
    assert(route(Start, End, Transportation, TimeInMin, Price)),
    createRoutes(Rest).

% rute makes sure a route is found between cities
rute(Start,End) :-
    route(Start,End,_,_,_).

:- readRoutes, readStead.

% astar algorithm

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


% heuristic is the guess for the time that it will take from a node
h(Node, Estimate) :-
    goal(To),
    distance(Node, To, Dist),
    heuristic(Dist, Estimate).

distance(Start, End, Dist) :-
    city(Start,_,_,_,OX,OY),
    city(End,_,_,_,SX,SY),
    coordDist([OX,OY],[SX,SY],Dist).

coordDist([OX,OY], [SX,SY], Dist) :-
    X is (OX - SX),
    Y is (OY - SY),
    Dist is sqrt((X * X) + (Y * Y)).

heuristic(Dist, Time) :-
    % t = d /v
    Time is Dist / 800.

s(Node, Next, Cost) :- route(Node,Next,_,_,Cost). 

finnReiseRaskest(Start, End) :-
    assert(goal(End)),
    bestfirst(Start, Sol),
    write(Sol),
    retract(goal(End)).
    

retractStuff :- retractall(route(_,_,_,_,_)), retractall(city(_,_,_,_,_,_)).

main :- write('Hello World'), finnReiseRaskest('Oslo','Bergen').
