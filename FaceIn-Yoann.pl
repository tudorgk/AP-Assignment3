/*
person(susan, [reed, jen, andrzej, jessica]).
person(reed, [tony, jessica]).
person(jessica, [jen]).
person(tony, []).
person(ken, [andrzej]).
person(jen, [tony, susan, jessica]).
person(andrzej, [susan, ken]).
person(radu, [tudor]).
person(tudor, [radu]). 
*/

% [WORKS]
% equivalent of member/2
memb(X, [Y|T]) :- X = Y; memb(X, T).

% [TO TEST]
% equivalent of select/3
selec(X,[X|L],L).
selec(X,[Y|M],[Y|N]):- selec(X,M,N).



g([person(susan, [reed, jen, andrzej, jessica]),
    person(reed, [tony, jessica]),
    person(jessica, [jen]),
    person(tony, []),
    person(ken, [andrzej]),
    person(jen, [tony, susan, jessica]),
    person(andrzej, [susan, ken]),
	person(radu, [tudor]),
	person(tudord, [radu])]).
	  
% Only works with a Y list (ex : jessica, [jen]) so with only a list as the second parameter
% ==>> we have to extract the elements of the list.
% We wrap the graph in this predicate not to display G all the time  
is_friend(X, Y) :-
 g(G),
 is_friend_with_graph(X,Y,G). 
 
% This function always displays G
is_friend_with_graph(X, Y, G) :- g(G), person(X, [Y]). 


% May be useful later
concat_lists([], Res, Res).
concat_lists([ H | T], OtherList, [ H | Rest]) :- concat_lists(T, OtherList, Rest).
	
% May be useful later	
subset([ ],_).
subset([H|T],List) :-
    memb(H,List),
    subset(T,List).

% [WORKS]
good_friends(X,Y) :-
	is_friend(X, Y),
	is_friend(Y, X).

/*
not_member(X, [H|T]) :-
	X \= H, 
	not_member(X,T).
not_member(X, [_]).
*/