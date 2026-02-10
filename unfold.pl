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

fib(P1-P2, P2, P2-P3) :- P3 is P1 + P2.

fibs(L) :- unfold(fib, 0-1, L).

