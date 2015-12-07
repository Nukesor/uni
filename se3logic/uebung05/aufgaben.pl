%%% Arne Beer, Felix Favre, Anne-Victoria Meyer %%%
%%% Aufgabe 1 %%%


%%% Aufgabe 2 %%%

peano(0).
peano(s(X)) :-
peano(X).

vorgaenger(Peano, Vorgaenger) :-
peano(Peano), Peano = s(Vorgaenger).

nachfolger(Peano, Nachfolger) :-
peano(Peano), Nachfolger = s(Peano).

tiefe(X, T) :-
    \+ X=0,
    tiefe(vorgaenger(X), H),
    T is 1+H.