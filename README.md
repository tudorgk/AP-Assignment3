AP-Assignment3
==============

% Authors : Tudor Dragan & Yoann Moise

Assignment 3 : Analysing FaceIn
28/09/2014

Subject : This assignment is about analysing social relations on the social network FaceIn using Prolog.

Remarks : No error/warning during the compilation.


To better understand the subject, we started to reflect on how we could know if one element is a friend with another one.
The best thing was to use the function member that we did .

Having is_friend function, the goodfriends function was intuitive enough. It needs that a first person is a friend with a second person and that the second person is friend with the first person.

We thought also that the functions selec (equivalent of select/3), subset and permutation would be interesting to build for further use.

We created the build_person_list function thinking that it can be good to use it for the clique function. Finally we didn't use it, but it may be good to use it for other functions.

The function clique is not correctly implemented, there might be an infinite loop.
We didn't find how to resolve this (yet).

Testing:
	At the end of the file FaceIn.pl, we used fifteen tests functions to test all the functions we created.
	Depending of the tests, it could return either a boolean result (true/false), a list or an atom.
	Testing have been done one function with known and unknown parameters in all cases except clique which would lead to infinite recursion.

Usage
-----
	
```prolog
	run_tests.
```