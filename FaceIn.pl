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

%select/3 function
selec(X,[X|L],L).
selec(X,[Y|M],[Y|N]):- selec(X,M,N).

%is X a friend of Y?
is_friend([person(Y,Friends)|T],X,Y):- 
	memb(X,Friends).
is_friend([H|T],X,Y):-
	is_friend(T,X,Y).

%seems intuitive enough
goodfriends(G, X, Y) :-
	is_friend(G,X,Y),
	is_friend(G,Y,X).

build_person_list([],[]).
build_person_list([person(Y,Friends)|T],[Y|List]) :-
	build_person_list(T,List).

permutation([], []).
permutation(List, [Element | Permutation]) :-
	selec(Element, List, Rest),
	permutation(Rest, Permutation).	

%subset
subset([], []).
subset([E|Tail], [E|NTail]):-
  subset(Tail, NTail).
subset([_|Tail], NTail):-
  subset(Tail, NTail).

%bang bang cliquety clack clack
clique(G,[X|L]) :-
	memb(person(X,W),G),
	subset(L,W).

%% clique2([person(X,XFriends),person(X,XFriends)],[]):-
%% 	.
%% clique2([person(X,Friends)|T], [Y|Rest]) :-
%% 	goodfriends(G,Y,X),
%% 	clique2(T, Rest).
%% 	%goodfriends(G,Elem,Rest).
%% 	%clique(G, [Elem | Rest]).

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

%% comparing all elemts to head
small([M|T],X):- small1(T, M, X).

small1([H|_], M ,H):- H =< M.
small1([_|T], M, X):- small1(T, M, X).

print_all([]).
print_all([X|Rest]) :- write(X), nl, print_all(Rest).

maplist(_C_2, [], []).
maplist( C_2, [X|Xs], [Y|Ys]) :-
   call(C_2, X, Y),
   maplist( C_2, Xs, Ys).