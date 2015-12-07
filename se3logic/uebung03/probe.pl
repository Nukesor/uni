%1.c
findall([VName, Name, Adresse, Signatur], (ausleihe(Signatur, LNummer, datum(J, M, D)), leser(Name, VName, LNummer, Adresse, _), (J<2007; J<2008, M<2, D<7)), Bag)

%1.d
findall(LNummer, (ausleihe(_, LNummer, _), leser(_, _, LNummer, _, Jahr), Jahr<1954), Bag),
length(Bag, Laenge).

aelter(A, A) :- false.

aelter(datum(J1, M1, D1), datum(J2, M2, D2)) :-
    J1 < J2;
    J1 = J2,
    M1 < M2;
    J1 = J2,
    M1 = M2,
    D1 < D2.
