/*
Aufgabe 3
Das Datenmodel besteht aus player/3 , competition/4,  team/6 und statistic/4.
Jede competition besteht selbst aus 2 Teams und einer ID. Durch die Teams kann auf die 
beteiligten Spieler rueckgeschlossen werden und ausserdem erfaehrt man, welches Team gesiegt hat. 
Fuer jeden Spieler wird eine lastCompetition angegeben, falls man sich das letzte Spiel des jeweiligen
Spielers genauer ansehen moechte. Ausserdem gibt es eine Statistik fuer jeden Spieler, in dem die bisherigen
Ergebnisse des Spielers stehen.
*/

% player(Name, lastCompetitionId, stats).
player(nukesor, 1, 1).
player(lonje, 1, 2).
player(arnatar, 1, 3).
player(xkcd, 1, 4).
player(svenstaro, 1, 5).
player(raffomania, 1, 6).
player(opatut, 1, 7).
player(megaman, 1, 8).


% statistic(statisticID, kills, deaths, games)
statistic(1, 1000, 0, 2).
statistic(2, 100, 10, 5).
statistic(3, 100, 10, 5).
statistic(4, 50, 20, 10).
statistic(5, 999, 1, 2).
statistic(6, 100, 10, 5).
statistic(7, 50, 20, 10).
statistic(8, 9001, 0, 1).


% team(teamID, player1, player2, player3, player4, winner)
team(1, nukesor, lonje, arnatar, xkcd, true).
team(2, svenstaro, raffomania, opatut, megaman, false).

% competition(competitionID, team1, team2)
competition(1, 1, 2).



