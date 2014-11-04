% Leser en fil bestående av termer, og returnerer en liste
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
