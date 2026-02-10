:- use_module(library(clpz)).
:- use_module(library(freeze)).

%% unfold(+Goal, +InitialState, -List)
%
% "Unfolds" a list from a generator Goal and an initial State. In
% a functional setting, this might be called an anamorphism. Uses
% freeze/2 to create the list on-demand. Make sure to limit how much
% of the list you use or you will be generating for a very long time.
% 
% Goal must accept three arguments: +CurrentState, -Item, -NextState.

unfold(Goal, InitialState, [I|T]) :-
	call(Goal, InitialState, I, NextState),
	freeze(T, unfold(Goal, NextState, T)).

% As a demonstration, we show how to create a representation of the
% Fibonacci numbers as an infinite list.

%% A Fibonacci sequence generator for unfold/3.
fib(P1-P2, P2, P2-P3) :- P3 #= P1 + P2.

%% Demonstration: use unfold/3 with fib/3 above and a seed of 0-1.
fibs(L) :- unfold(fib, 0-1, L).

%% As a test, we generate a list of the first 9.
?- fibs([F1,F2,F3,F4,F5,F6,F7,F8,F9|_]).
   F1 = 1, F2 = 1, F3 = 2, F4 = 3, F5 = 5, F6 = 8, F7 = 13, F8 = 21, F9 = 34, freeze:freeze(_A,user:unfold(fib,34-55,_A)).
