parent(pam,bob).
parent(tom,bob).
parent(tom,liz).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).

male(tom).
male(bob).
male(jim).
female(liz).
female(pam).
female(pat).
female(ann).

mother(X,Y) :-
    parent(X,Y),
    female(X).

grandparent(X,Z) :-
    parent(X,Y),
    parent(Y,Z).

sister(X,Y) :-
    parent(Z,Y),
    parent(Z,Y),
    female(X),
    X \= Y.

brother(X,Y) :-
    parent(Z,Y),
    parent(Z,Y),
    male(X),
    X \= Y.

hasachild(X) :-
    parent(X,Y).

happy(X) :-
    hasachild(X).

hastwochildren(X) :-
    parent(X,Y),
    sister(Z,Y).

ancestor(X,Z) :-
    parent(X,Z).

ancestor(X,Z) :-
    parent(X,Y),
    ancestor(Y,Z).

fallible(X) :-
    man(X).

man(socrates).

aunt(X,Y) :-
    sister(X,Z),
    parent(Z,Y).

uncle(X,Y) :-
    brother(X,Z),
    parent(Z,Y).

nephew(X,Y) :- ;(aunt(Y,X), uncle(Y,X)), male(X).

niece(X,Y) :- ;(aunt(Y,X), uncle(Y,X)), female(X).

% A robot's world

% see(Block,X,Y): Block is observed by camera at coordinates X and Y
see(a,2,5).
see(d,5,5).
see(e,5,2).

% on(Block,Object): Block is standing on Object
on(a,b).
on(b,c).
on(c,table).
on(d,table).
on(e,table).

z(B,0) :-
    on(B,table).

z(B,Z) :-
    on(B,B0),
    z(B0,Z0),
    Z is Z0 + 1.

zz(B,Z0 + 1) :-
    on(B,B0),
    zz(B0,Z0).

zz(B, Z0 + height(B0) ) :-
    on(B, B0),
    zzz(B0, Z0).

% xy(B,X,Y): x-y coordinates of block B are X and Y
xy(B,X,Y) :-
    see(B,X,Y).

xy(B,X,Y) :-
    on(B0, B),
    xy(B0,X,Y). 
