[AP-Assignment3](https://github.com/tudorgk/AP-Assignment0)
================

Assignment 3 : Analysing FaceIn
28/09/2014

Subject : This assignment is about analysing social relations on the social network FaceIn using Prolog.


FaceIn API
----------

#### `goodfriends` predicate
```prolog
%seems intuitive enough
goodfriends(G, X, Y) :-
	is_friend(G,X,Y),
	is_friend(G,Y,X).
```
The predicate uses the `is_friend` predicate wich checks if `X` is a friend of `Y` and vice-versa. The `is_friend` predicate checks if a person `Y` is in `X`'s friend list using the `memb` predicate.

#### `clique` predicate
```prolog
%clique predicate
clique(G, [FriendOne, FriendTwo]):-
 	goodfriends(G, FriendOne, FriendTwo).
clique(G, [FriendOne | FriendList]):-
  	clique(G, FriendList),	
  	goodFriendWith(G, FriendOne, FriendList).
```
This predicate uses `goodFriendsWith` predicate to iterate through the graph. The `goodFriendsWith` predicate checks if `Person1` is a good friend with the peolple in the `FriendList`.

#### `wannabe` predicate
```prolog
wannabe(G, X):-
	build_person_list(G,List),
	check_all(G,X,List).
```

We build a list with all the people in the graph. We then check that `X` can reach all the people in the graph. In the `check_all` predicate we use a helper predicate for checking if `Person1` is reachable to each person in the list. The `reachable` predicate checks if the person is a member in the other people's friend list, and then recursively calls itself without the new graph.


#### `wannabe` predicate
```prolog
%TODO
idol(G, X).
```
TODO

Testing
-------
	At the end of the file FaceIn.pl, we used fifteen tests functions to test all the functions we created.
	Depending of the tests, it could return either a boolean result (true/false), a list or an atom.
	Testing have been done one function with known and unknown parameters in all cases except clique which would lead to infinite recursion.

Usage
-----
	
```prolog
	run_tests.
```