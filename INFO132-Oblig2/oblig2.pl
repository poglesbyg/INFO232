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

% beskriv/1 takes in a city name and prints out a short 
% description of it
beskriv([]).
beskriv(Place) :-
  Place = city(Name, Pop, Status, Fact, CoordX, CoordY),
  write(Name), write(' er en '), write(Status),
  write(' med '), write(Pop), write(' innbyggere.'),nl,
  write(Fact),nl,nl.

splitLines([],[]).
splitLines([end_of_file], []).
splitLines([Name, Pop, Status, Fact, CoordX, CoordY | Rest], [city(Name, Pop, Status, Fact, CoordX, CoordY) | Return]) :-
  %write(Name), write(' '),
  assert(city(Name, Pop, Status, Fact, CoordX, CoordY)),
  splitLines(Rest, Return).

listByer([end_of_file],[]).
listByer([Name, Pop, Status, Fact, CoordX, CoordY | Rest], [city(Name, Pop, Status, Fact, CoordX, CoordY) | Return]) :-
  write(Name), nl,
  listByer(Rest, Return).



main :-
  lesFil('stedsinfo.txt', Lines),
  %write(Lines),nl,
  splitLines(Lines, Return),
  maplist(beskriv,Return),
  listByer(Lines,Return).

