%% Author: Paul Grant (pgr023)
%% Class: INFO232
%% Date: November 19, 2014
%% Title: Oblig 2

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

writeDataBase :-
    lesFil('stedsinfo.txt',Places),
    createPlaces(Places),
    lesFil('reiseruter-2.txt',Routes),
    createRoutes(Routes).

createPlaces([end_of_file]).
createPlaces([Name, Pop, Status, Fact, CoordX, CoordY | Rest]) :-
    assert(city(Name, Pop, Status, Fact, CoordX, CoordY)),
    createPlaces(Rest).

createRoutes([end_of_file]).
createRoutes([Start, End, 'fly', TimeInMin, Price | Rest]) :-
    assert(route(Start, End, 'fly', Price, TimeInMin)),
    createRoutes(Rest).
createRoutes([Start, End, Transportation, TimeInMin, Price | Rest]) :- 
    assert(route(Start, End, Transportation, TimeInMin, Price)),
    createRoutes(Rest).
% Here we add the data to the program
% If you need to read the file into the program again
% the predicate retractStuff has been created.
:- writeDataBase.

% beskriv takes in a city name and prints out a short 
% description of it
beskriv(Name) :-
    city(Name, Pop, Status, Fact, CoordX, CoordY),
    write(Name), write(' er en '), write(Status),
    write(' med '), write(Pop), write(' innbyggere.'),nl,
    write(Fact).

% listByer gives a list of all the cities

listByer(List) :-
    findall(Name, city(Name, _,_,_,_,_),List).

% rute makes sure a route is found between cities
rute(Start,End) :-
    ;(rute(Start,End,_,_,_), rute(End,Start,_,_,_)).

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

% s for the astar algorithm
s(Node, Next, Cost) :- route(Node,Next,_,Cost,_). 

finnReiseRaskest(Start, End) :-
    assert(goal(End)),
    bestfirst(Start, Sol),
    reverse(Sol, Return),
    writeRoutes(Return, TotalTime, TotalPrice),
    Hours is TotalTime//60, Minutes is TotalTime rem 60,
    write('Total travel time: '), write(Hours), write(' hours and '),
    write(Minutes), write(' minutes.'),nl,
    write('Total price: '), write(TotalPrice), write(' Norwegian kroner.'),
    retract(goal(_)).

% the printing predicate for finnReiseRaskest
writeRoutes([_ | []], Time, Price) :-
    Time is 0, Price is 0, true.
writeRoutes([Head, Next | Rest], TotalTime, TotalPrice) :-
    findall(KT1/Time1/Pr1,route(Head,Next,KT1,Time1,Pr1),RuteSpecs),
    minRoute(RuteSpecs, KT/Time/Pr),
    Write(KT),write(' from '),write(Head),write(' to '),write(Next),write(.),nl,
    writeRoutes([Next|Rest],TotalTime1,TotalPrice1),
    TotalTime is (TotalTime1 + Time), TotalPrice is (TotalPrice1 + Pr).

% minRoute finds the route with the least amount of time
minRoute([H|[]],H).
minRoute([H1,H2|[]], Out) :-
    H1 = _/Time1/_,
    H2 = _/Time2/_,
    ( Time1 =< Time2, Out = H1 ); Out = H2.
minRoute([H1,H2,H3|[]], Out) :-
    H1 = _/Time1/_,
    H2 = _/Time2/_,
    H3 = _/Time3/_,
    ( (Time1 =< Time2), (Time1 =< Time3), Out = H1 );
    ( (Time2 =< Time1), (Time2 =< Time3), Out = H2 );
    ( (Time3 =< Time1), (Time3 =< Time2), Out = H3 ).

% Retracts all routes and cities from the database read into the file
retractStuff :- retractall(route(_,_,_,_,_)),
                retractall(city(_,_,_,_,_,_)).

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

% main is a test function. you can run it to see that the best path
% from Bergen to Stockholm exists.
main :- write('Hello World'),nl,
        finnReiseRaskest('Bergen', 'Stockholm').
