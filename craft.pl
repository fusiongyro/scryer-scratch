:- use_module(library(clpz)).
:- use_module(library(dcgs)).
:- use_module(library(lambda)).
:- use_module(library(lists)).

%% number_digits(Total, Digits).
number_digits(N, 0, [N]) :- N in 0..9.
number_digits(Num, Place, [D1,D2|Digits]) :-
	[D1,D2] ins 0..9,
	Place #= Place0 + 1,
	Place0 #< Place,
	Num0 #< Num,
	number_digits(Num0, Place0, [D2|Digits]),
	Num #= D1*10^Place + Num0.

%% We are looking for a number [D1, D2, D3, ... D9] such that D1 is
%% divisible by 1, [D1,D2] is divisible by 2, [D1,D2,D3] is divisible by
%% 3, etc.
answer(Digits) :-
	length(Digits, 9),
	Digits ins 1..9,
	all_distinct(Digits),
	append(Prefix, _, Digits).
	
