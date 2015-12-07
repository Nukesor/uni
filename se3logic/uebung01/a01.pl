% Aufgabe 1

?-[familie].
% Der Ausdruck gibt "true" zurueck, da das Einbinden der File erfolgreich war. 
% Die Ausdrucke sind vom Effekt her zueinander equivalent. 
% [] deklariert in in Prolog eine Liste. Mit dem . Operator wird nun jedes Element dieser Liste wie ein Befehl ausgefuehrt. 
% Wenn man allerdings einen Pfad angibt [/dir/file] sucht er in dem momentenan Directory nach der File /dir/file, 
% welche natuerlich nicht existiert. Daher muss der der Ausdruck in '' gesetzt werden, damit im Pfad sucht. 

?-listing.
% Dieser Befehl gibt alle Praedikate, welche in der momentanen Datenbank vorhanden sind, mit Klauseln und Fakten aus.

?-listing(mutter_von).
% Gibt alle Praedikate vom Typen mutter_von mit ihren Klauseln und Fakten aus.

?-assert(mutter_von(marie, tom)).
% assert ist deprecated und soll daher nicht benutzt werden. Stattdessen soll assertz benutzt werden. 
?-assertz(mutter_von(marie, rom)).
?-asserta(mutter_von(marie, fom)).

% asserta sorgt dafuer, dass die Klausel am Anfang der Klauseln des entsprechenden Praedikats steht.
% assertz hingegen haengt die Klausel an das Ende der Klauseln des entsprechenden Praedikats.

?- listing(mutter_von).

% Aufgabe 2.1:
% a
Vater_von(johannes, andrea).
% true.
% Johannes ist also der Vater von Andrea.

% b
mutter_von(helga, charlotte).
% false
% Nein die Mutter von Charlotte heisst nicht Helga.

% c
vater_von(Vater, magdalena).
% Vater = walter.
% Der Vater von Magdalena heisst also Walter. Vater ist hier eine Variable.
% Die einzige Belegung fuer die "vater_von(Vater, magdalena)." true ist,
% ist also wenn Vater=walter.

% d
vater_von(Vater, walter).
% false
% Es gibt keine Moeglichkeit fuer den Ausdruck wahr zu werden.
% Laut Datenbank hat Walter also keinen Vater.

% e
vater_von(otto, Kind).
% Kind = hans ;
% Kind = helga.
% Ottos Kinder heissen Hans und Helga.

% f
vater_von(V, K).
% V = otto,
% K = hans ;
% V = otto,
% K = helga ;
% V = gerd,
% K = otto ;
% V = johannes,
% K = klaus ;
% V = johannes,
% K = andrea ;
% V = walter,
% K = barbara ;
% V = walter,
% K = magdalena.

mutter_von(M, K).
% M = marie,
% K = hans ;
% M = marie,
% K = helga ;
% M = julia,
% K = otto ;
% M = barbara,
% K = klaus ;
% M = barbara,
% K = andrea ;
% M = charlotte,
% K = barbara ;
% M = charlotte,
% K = magdalena.

% Alle moeglichen Belegungen (die true liefern wurden) werden angezeigt.
% So ist z.B. Otto der Vater von Hans:
% V = otto,
% K = hans ;
% Semikola separieren die unterschiedlichen Belegungen wobei sie oder Verknupfungen sind.
% Die Kommata die jeweiligen Variablenwerte, sind also und Verknuepfungen.

% g
\+ vater_von(klaus, Kind).
% true.
% Klaus hat also keine Kinder.
% Es gibt keine wahre Belegungen fuer diese Klausel,
% daher wuerde false ausgegeben werden.
% Das wird hier jedoch noch negiert also erhalten wir true.

% h
\+ vater_von(otto, Kind).
% false.
% Otto hat also Kinder.
% Auch wenn die Klausel vater_von(otto, Kind). die wahren Belegungen
% zurueck geben wuerde wird bei der Negation lediglich ein boolscher Wert ausgegeben.

%% i
\+ \+ vater_von(otto, Kind).
% true.
% Durch die Negation erhalten wir einen Wahrheitswert,
% durch doppelte den gewuenschten.

% Aufgabe 2.2

mutter_von(charlotte, Kind), (mutter_von(Kind, EnkelKind1); vater_von(Kind, EnkelKind2)).
% Kind = barbara,
% EnkelKind1 = klaus ;
% Kind = barbara,
% EnkelKind1 = andrea ;
% false.

% Wir suchen eine Belegung fuer das Kind von Charlotte so das dieses Kind ebenfalls eines hat.
% Da es kein kind_von Praediakt gibt muessen vater_von und mutter_von veroder werden.
% Wir haben die Klauseln gelammert um die Operationen in der richtigen Reihenfolge durchzufuehren.
% Die logischen Verknuepfungen sind die folgenden:
% ; = oder
% , = und

% Am ende der Ausgabe steht ein false da zunachst die beiden moeglichen Belegungen fuer eine wahre
% Auswertung aufgelistet werden. Und dann alle anderen, die alle auf false auswerten.

% Aufgabe 2.3

% Anders als im Skript werden nur die erfolgreichen Belegungen auch tatsaechlich aufgelistet,
% es sei denn es gibt keine erfolgreichen.

vater_von(Vater, walter).
% Call: (6) vater_von(_G1814, walter) ? creep
% Fail: (6) vater_von(_G1814, walter) ? creep
% false.

% In dieser trace ist also keine wahre Belegung gefunden worden.

vater_von(otto, Kind).
% Call: (6) vater_von(otto, _G1815) ? creep
% Exit: (6) vater_von(otto, hans) ? creep
% Kind = hans ;
% Redo: (6) vater_von(otto, _G1815) ? creep
% Exit: (6) vater_von(otto, helga) ? creep
% Kind = helga.


% In dieser trace ist eine wahre Belegung gefunden worden,
% danach wird jedoch weiter probiert.
% Dabei wird offensichtlich aehnlich wie in der Vorlesung nach einem Baumschema vorgegangen.
% Die Misserfolge werden nicht angezeigt.

