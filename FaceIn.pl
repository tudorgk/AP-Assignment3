:- use_module(library(plunit)).

g([person(susan, [reed, jen, andrzej, jessica]),
      person(reed, [tony, jessica]),
      person(jessica, [jen]),
      person(tony, []),
      person(ken, [andrzej]),
      person(jen, [tony, susan, jessica]),
      person(andrzej, [susan, ken])]).

%member function
memb(X, [Y|T]) :- X = Y; memb(X, T).


is_friend([person(Y,Friends)|Relations],X,Y):- 
	memb(X,Friends).
is_friend([H|T],X,Y):-
	is_friend(T,X,Y).

goodfriends(G, X, Y) :-
	is_friend(G,X,Y),
	is_friend(G,Y,X).

:- begin_tests(friendtest).
test(friend):-
	g(G),
	is_friend(G,reed,susan).
:- end_tests(friendtest).

%% goodfriends(G, X, Y) :- 
%% 	graph(G),