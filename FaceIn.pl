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

%is X a friend of Y?
is_friend([person(Y,Friends)|T],X,Y):- 
	memb(X,Friends).
is_friend([H|T],X,Y):-
	is_friend(T,X,Y).

%seems intuitive enough
goodfriends(G, X, Y) :-
	is_friend(G,X,Y),
	is_friend(G,Y,X).

permutation([], []).
permutation(List, [Element | Permutation]) :-
	select(Element, List, Rest),
	permutation(Rest, Permutation).	


%bang bang cliquety clack clack
clique(G,[Elem|L]) :-
	goodfriends(G,X,Elem),
	clique(G,L).

:- begin_tests(friendtest).
test(friend):-
	g(G),
	is_friend(G,jen,susan).
test(goodfriends):-
	g(G),
	goodfriends(G,susan,jen).
:- end_tests(friendtest).

%% goodfriends(G, X, Y) :- 
%% 	graph(G),