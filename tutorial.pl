john_is_cold.
raining.
john_Forgot_His_Raincoat.
fred_lost_his_car_keys.
peter_footballer.

eats(fred,oranges).
eats(fred,t_bone_steaks).
eats(tony,apples).
eats(john,apples).
eats(john,grapefruit).

age(john, 32).
age(agnes,41).
age(george,72).
age(ian,2).
age(thomas,25).
age(paul,24).

loves(john,mary).
loves(fred,hobbies).

tape(1,van_morrison,astral_weeks,madam_george).
tape(2,beatles,sgt_pepper,a_day_in_the_life).
tape(3,beatles,abbey_road,something).
tape(4,rolling_stones,sticky_fingers,brown_sugar).
tape(5,eagles,hotel_california,new_kid_in_town).

mortal(X) :-
	human(X).

human(socrates).

fun(X) :-
	red(X),
	car(X).

fun(X) :-
	blue(X),
	bike(X).

fun(ice_cream).

red(apple_1).
red(block_1).
red(car_27).

car(desoto_48).
car(edsel_57).

blue(flower_3).
blue(glass_9).
blue(honda_81).

bike(iris_8).
bike(my_bike).
bike(honda_81).

red(cricket_ball).
red(my_hat).
red(car_27).
blue(cheese).
blue(raleigh).
blue(honda).

car(peugot).
car(rover).
bike(yamaha).
bike(raleigh).
bike(honda).

car(vw_beatle).
car(ford_escort).
bike(harley_davidson).
red(vw_beatle).
red(ford_escort).
blue(harley_davidson).

likes(john,mary).
likes(john,trains).
likes(peter,fast_cars).

likes(Person1,Person2) :-
	hobby(Person1,Hobby),
	hobby(Person2,Hobby).

hobby(john,trainspotting).
hobby(time,sailing).
hobby(helen,trainspotting).


hold_party(X) :-
	birthday(X),
	happy(X).

birthday(tom).
birthday(fred).
birthday(helen).
happy(mary).
happy(jane).
happy(helen).

a(X) :-
	b(X), c(X), d(X).

a(X) :-
	c(X), d(X).

a(X) :-
	d(X).

b(1).

b(a).

b(2).

b(3).

d(10).

d(11).

c(3).

c(4).

on_route(rome).

on_route(Place) :-
	move(Place,Method,NewPlace),
	on_route(NewPlace).

move(home,taxi,halifax).
move(halifax,train,gatwick).
move(gatwick,plane,rome).

parent(john,paul).
parent(paul,tom).
parent(tom,mary).

ancestor(X,Y) :-
	parent(X,Y).

ancestor(X,Y) :-
	parent(X,Z),
	ancestor(Z,Y).

p([H|T], H, T).

on(Item,[Item|Rest]).

on(Item,[DisregardHead|Tail]) :-
	on(Item,Tail).