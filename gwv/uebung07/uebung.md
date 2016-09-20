% Grundlagen der Wissensverarbeitung – Tutorial 5, Gruppe 4 
% Arne Beer MN 6489196; Marta Nevermann MN 6419716; Daniel Waller MN 6813853; Julius Hansen MN 6455291


## Exercise 1.2

Zuerst werden aus der den Aussagen der Aufgabe Atome (atoms) entnommen:

- gärtner_mordete
- butler_mordete
- gärtner_arbeitete
- butler_arbeitete
- gärtner_schmutzige_hände
- butler_schmutzige_hände
- gärtner_saubere_hände
- butler_saubere_hände
- gärtner_lügt
- butler_lügt

Anschließend können anhand der Aussagen Regeln (rules) erstellt werden:

- butler_arbeitete $\leftarrow$ butler_schmutzige_hände
- gärtner_arbeitete $\leftarrow$ gärtner_schmutzige_hände
- $\neg$butler_arbeitete $\leftrightarrow$ butler_saubere_hände
- $\neg$gärtner_arbeitete $\leftrightarrow$ gärtner_saubere_hände
- $\neg$butler_mordete $\leftarrow$ butler_arbeitete 
- $\neg$gärtner_mordete $\leftarrow$ gärtner_arbeitete 

Es ist außerdem die Vorraussetzung (integrity constraints) gegeben, dass folgendes gilt:

- false $\leftarrow$ butler_schmutzige_hände $\wedge$  butler_saubere_hände
- false $\leftarrow$ gärtner_schmutzige_hände $\wedge$  gärtner_saubere_hände


Die Aussagen der Verdächtigen stellen hier unsere Assumables dar:

- gärtner_arbeitete
- butler_arbeitete

Mit den Observables: 

- gärtner_saubere_hände
- butler_schmutzige_hände

Mit der Annahme, dass beide den Mord nicht begangen haben, was sich aus den Assumables schließen lässt, kann nun ein mimimaler Konflikt erstellt werden:

{$\neg$gärtner_arbeitete}

Daraus folgt:
KB $\models$ $\neg$gärtner_arbeitete

TODO: Das kann so noch nicht ganz stimmen. Es wird nach einer minimal diagnosis gefragt, die kann hier jedoch nicht gemacht werden, da es hier nur 1 Element gibt. Bzw. sie ist implizit. Irgendwas stimmt an dem Modell noch nicht. Vielleicht zu wenige Atome? @Julius schau da nochmal drüber, vielleicht fällt dir was ein

## Exercise 1.3
Generelle Annahmen aus mangelndem Know-how:

  - Die Fuel pump arbeitet auch wenn der Tank kein Benzin enthält und/oder der Filter kaputt ist
  - Der Starter ist nur zu hören wenn die Batterie Ladung hat
  - Die Fuel pump arbeitet nicht wenn die electronic fuel regulation beschädigt ist
  - Der Motor ist nur zu hören wenn starter und fuel pump auch gehen

- battery : bat
- ignition key : ik
- electronic fuel regulation : efr
- starter : st
- engine : en
- filter :  fi
- fuel pump : fp
- fuel tank : ft

- Assumables = {ok_st, ok_fp, ok_en, turned_ik, live_bat, ok_efr, filled_ft, ok_fi}
- KB = {
    false $\leftarrow$ noise_1 $\wedge$ silent_1.
    false $\leftarrow$ noise_2 $\wedge$ silent_2.
    false $\leftarrow$ noise_3 $\wedge$ silent_3.
    noise1 $\leftarrow$ ok_st $\wedge$ hasPower.
    noise_2 $\leftarrow$ ok_fp $\wedge$ hasPower $\wedge$ ok_efr
    noise_3 $\leftarrow$ ok_en $\wedge$ ok_st $\wedge$ ok_fp $\wedge$ hasPower $\wedge$ getsFuel
    hasPower $\leftarrow$ turned_ik $\wedge$ live_bat.
    getsFuel $\leftarrow$ filled_ft $\wedge$ ok_fi.
}

case: no noise
observed silent_1, silent_2, silent_3 = true
Initial state:
  q = false
  ac = yes $\leftarrow$ false $\wedge$ false $\wedge$ false
Iter step 1: 
  - select 'false'
  - choose clause 'false $\leftarrow$ noise_1 $\wedge$ silent_1.' from KB
  - replace false with body of clause
State 1:
  q = false
  ac = yes $\leftarrow$ noise_1 $\wedge$ silent_1 $\wedge$ false $\wedge$ false
Iter step 2:
  - select 'noise_1'
  - choose clause 'noise1 $\leftarrow$ ok_st $\wedge$ hasPower.' from KB
  - replace 'noise_1' with body of clause
State 2:
  q = false
  ac = yes $\leftarrow$ ok_st $\wedge$ hasPower $\wedge$ silent_1 $\wedge$ false $\wedge$ false
Iter step 3: 
  - select 'hasPower' (ok_st is assumable don't select it)
  - choose clause 'hasPower $\leftarrow$ turned_ik $\wedge$ live_bat.' from KB
  - replace 'hasPower' with body of clause
State 3:
  q = false
  ac = yes $\leftarrow$ ok_st $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ silent_1 $\wedge$ false $\wedge$ false
Iter step 4:
  - select 'false' (all others are assumable)
  - choose clause 'false $\leftarrow$ noise_2 $\wedge$ silent_2.' from KB
  - replace 'false' with body of clause
State 4:
  q = false
  ac = yes $\leftarrow$ ok_st $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ silent_1 $\wedge$ noise_2 $\wedge$ silent_2 $\wedge$ false
Iter step 5:
  - select 'noise_2'
  - choose clause 'noise_2 $\leftarrow$ ok_fp $\wedge$ hasPower $\wedge$ ok_efr.' from KB
  - replace 'noise_2' with body of clause
State 5:
  q = false
  ac = yes $\leftarrow$ ok_st $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ silent_1 $\wedge$ ok_fp $\wedge$ hasPower $\wedge$ ok_efr $\wedge$ silent_2 $\wedge$ false
Iter step 6:
  - select 'hasPower'
  - choose clause 'hasPower $\leftarrow$ turned_ik $\wedge$ live_bat.' from KB
  - replace 'hasPower' with body of clause
State 6:
  q = false
  ac = yes $\leftarrow$ ok_st $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ silent_1 $\wedge$ ok_fp $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ ok_efr $\wedge$ silent_2 $\wedge$ false
Iter step 7:
  - select 'false'
  - choose clause 'false $\leftarrow$ noise_3 $\wedge$ silent_3.' from KB
  - replace 'false' with body of clause
State 7:
  q = false
  ac = ok_st $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ silent_1 $\wedge$ ok_fp $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ ok_efr $\wedge$ silent_2 $\wedge$ noise_3 $\wedge$ silent_3
Iter step 8:
  - select 'noise_3'
  - choose clause 'noise_3 $\leftarrow$ ok_en $\wedge$ ok_st $\wedge$ ok_fp $\wedge$ hasPower $\wedge$ getsFuel' from KB
  - replace 'noise_3' with body of clause
State 8:
  q = false
  ac = yes $\leftarrow$ ok_st $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ silent_1 $\wedge$ ok_fp $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ ok_efr $\wedge$ silent_2 $\wedge$ ok_en $\wedge$ ok_st $\wedge$ ok_fp $\wedge$ hasPower $\wedge$ getsFuel $\wedge$ silent_3
Iter step 9:
  - select 'hasPower'
  - choose clause 'hasPower $\leftarrow$ turned_ik $\wedge$ live_bat.' from KB
  - replace 'hasPower' with body of clause
State 9:
  q = false
  ac = yes $\leftarrow$ ok_st $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ silent_1 $\wedge$ ok_fp $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ ok_efr $\wedge$ silent_2 $\wedge$ ok_en $\wedge$ ok_st $\wedge$ ok_fp $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ getsFuel $\wedge$ silent_3
Iter step 10:
  - select 'getsFuel'
  - choose clause 'getsFuel $\leftarrow$ filled_ft $\wedge$ ok_fi.' from KB
  - replace 'getsFuel' with body of clause
State 10:
  q = false
  ac = yes $\leftarrow$ ok_st $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ silent_1 $\wedge$ ok_fp $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ ok_efr $\wedge$ silent_2 $\wedge$ ok_en $\wedge$ ok_st $\wedge$ ok_fp $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ filled_ft $\wedge$ ok_fi $\wedge$ silent_3

Zusammengefasst yes $\leftarrow$ ok_st $\wedge$ turned_ik $\wedge$ live_bat $\wedge$ silent_1 $\wedge$ ok_fp $\wedge$ ok_efr $\wedge$ silent_2 $\wedge$ ok_en $\wedge$ filled_ft $\wedge$ ok_fi $\wedge$ silent_3

Minimal conflicts : sehr viele. Entweder jedes Teil individuell kann kaputt sein oder aber Teile in beliebiger Kombination, solange sie keine Teilmengen von bereits aufgeführten Konflikten sind.

case: Only noise 1
Algorithmus analog zu oben...

Minimal conflicts: {ok_en, ok_fp}, {ok_efr}
Entweder kann die electronic fuel regulation kaputt sein und somit die nachfolgende Kette nicht funktionieren oder engine und fuel pump sind kaputt oder beliebige Kombinationen der 3 Elemente sind kaputt

case: Only noise 2
Algorithmus analog zu oben...

Minimal conflicts: {ok_en, ok_st}, {ok_st, ok_fp, filled_ft}, {ok_st, ok_fp, ok_fi}
Entweder sind der Starter und der Motor defekt oder der Starter in Kombination mit einem oder beiden Teilen aus Filter und Fuel Tank

case: Only noise 3
Algorithmus analog zu oben...

Minimal conflicts: {ok_en}, {ok_fi}, {ok_ft}
Entweder eines oder jede Kombination dieser Teile könnte kaputt sein

