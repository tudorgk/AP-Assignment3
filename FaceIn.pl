% Authors : Tudor Dragan & Yoann Moise

:- use_module(library(plunit)).

g0([person(susan, [reed, jen, andrzej, jessica]),
      person(reed, [tony, jessica]),
      person(jessica, [jen]),
      person(tony, []),
      person(ken, [andrzej]),
      person(jen, [tony, susan, jessica]),
      person(andrzej, [susan, ken])]).

g1([person(susan, [reed, jen, andrzej, jessica]),
      person(reed, [tony, jessica]),
      person(jessica, [jen,susan]),
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
is_friend([person(Y,Friends)|_],X,Y):- 
	memb(X,Friends).
is_friend([_|T],X,Y):-
	is_friend(T,X,Y).

%seems intuitive enough
goodfriends(G, X, Y) :-
	is_friend(G,X,Y),
	is_friend(G,Y,X).

build_person_list([],[]).
build_person_list([person(Y,_)|T],[Y|List]) :-
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

%% checks if this friend is goodfriend with all these friends
goodFriendWith(G, FriendOne, [FriendTwo]):-
	goodfriends(G, FriendOne, FriendTwo).
goodFriendWith(G, FriendOne, [FriendTwo | FriendList]):-
	goodFriendWith(G, FriendOne, FriendList),
 	goodfriends(G, FriendOne, FriendTwo).

%clique predicate
clique(G, [FriendOne, FriendTwo]):-
 	goodfriends(G, FriendOne, FriendTwo).
clique(G, [FriendOne | FriendList]):-
  	clique(G, FriendList),	
  	goodFriendWith(G, FriendOne, FriendList).


%for the wannabe we should implement a DFS search and check if X
%can reach all the other people
%% wannabe([person(Person,Friends)], X):-
%% wannabe([person(Person,Friends) | _],X) :-


%% TESTING SUITE
:- begin_tests(friendtest).
test(memb1):-
	memb(bob, [bob, john, grace, william]).
test(memb2,all(X=[bob,john,grace,william])):-
	memb(X, [bob, john, grace, william]).
test(selec1,L=[a,b,d,e]):-
	selec(c, [a,b,c,d,e], L).
test(selec2,L=[a,b,d,e,c]):-
	selec(c, [a,b,c,d,e,c], L).
test(subset1,[fail]):-
	subset([a,b,c,d,e],[c,d,e,f,g]).
test(subset2):-
	subset([a,b,c,d,e],[c,d,e]).
test(permutation1):-
	permutation([a,b,c,d], L).
test(is_friend1):-
	g0(G),
	is_friend(G,jen,susan).
test(is_friend2,[fail]):-
	g0(G),
	is_friend(G,tony,susan).
test(goodfriends_true1):-
	g0(G),
	goodfriends(G,susan,jen).
test(goodfriends_false1,[fail]):-
	g0(G),
	goodfriends(G,susan,tony).
test(goodfriends_false2,[fail]):-
	g1(G),
	goodfriends(G,tony,jessica).
test(clique_true1):-
	g0(G),
	clique(G,[susan,jen]).
test(clique_true2):-
	g0(G),
	clique(G,[susan,andrzej]).
test(clique_true3):-
	g1(G),
	clique(G,[jessica,jen,susan]).
test(clique_false1,[fail]):-
	g1(G),
	clique(G,[ken,susan]).
:- end_tests(friendtest).

%% comparing all elemts to head
small([M|T],X):- small1(T, M, X).

small1([H|_], M ,H):- H =< M.
small1([_|T], M, X):- small1(T, M, X).

%for debugging
print_all([]).
print_all([X|Rest]) :- write(X), nl, print_all(Rest).

%implemented map, but I don't use it
maplist(_C_2, [], []).
maplist( C_2, [X|Xs], [Y|Ys]) :-
   call(C_2, X, Y),
   maplist( C_2, Xs, Ys).