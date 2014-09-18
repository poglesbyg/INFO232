% Scheduling a meeting

% schedule( TimeA, A1, A2, TimeB, B1, B2, TimeD, D1, D2):
%  TimeA and experts A1, A2 assigned to seesion on Artificial Intelligence,
%  TimeB, B1, B2 to session on bioinformatics, and similar for databases.

schedule(Ta, A1, A2, Tb, B1, B2, Td, D1, D2) :-
	session(Ta, artificial_intelligence, A1, A2),
	session(Tb, bioinformatics, B1, B2),
	session(Td, databases, D1, D2),
	no_conflict(Ta, A1, A2, Tb, B1, B2),
	no_conflict(Ta, A1, A2, Td, D1, D2),
	no_conflict(Tb, B1, B2, Td, D1, D2).


% session( Time, Topic, P1, P2):
%  session at Time on Topic attended by responsible experts P1, P2

session( Time, Topic, P1, P2) :-
	time(Time),														% Time is morning or afternoon
	expert(Topic, P1),												% Person P1 is expert on Topic
	expert(Topic, P2),												% Person P2 is expert on Topic too
	P1 \= P2.														% P1, P2 different people

% no_conflict(Time1, P1, P2, Time2, Q1, Q2):
%  There is no time conflict between two sessions at Time1 and Time2
%  and experts P1, P2 and Q1, Q2, respectively

no_conflict( Time1, _, _, Time2, _, _) :-
	Time1 \= Time2.													% Two sessions at different time - not conflict

no_conflict(Time, P1, P2, Time, Q1, Q2) :-							% Two sessions at the same time
	P1 \= Q1, P1 \= Q2,												% No overlap between experts
	P2 \= Q1, P2 \= Q2.

% Possible times of sessions

time(morning).
time(afternoon).

% Experts for topics

expert(bioinformatics, barbara).
expert(bioinformatics, ben).
expert(artificial_intelligence, adam).
expert(artificial_intelligence, barbara).
expert(artificial_intelligence, ann).
expert(databases, adam).
expert(databases, danny).
