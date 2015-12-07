:- dynamic mutter_von/2, vater_von/2.        % ermoeglicht dynamische Veraenderung
% :- multifile mutter_von/2, vater_von/2.      % ermoeglicht verteilte Definition in mehreren Files

% mutter_von( Mutter , Kind ).
% 'Mutter' und 'Kind' sind Argumentpositionen,
% so da"s 'Mutter' die Mutter von 'Kind' ist.

mutter_von( marie , hans ).
mutter_von( marie , helga ).
mutter_von( julia , otto ).
mutter_von( barbara , klaus ).
mutter_von( barbara , andrea ).
mutter_von( charlotte , barbara ).
mutter_von( charlotte , magdalena ).


% vater_von( Vater , Kind ).
% 'Vater' und 'Kind' sind Argumentpositionen,
% so da"s 'Vater' die Vater von 'Kind' ist.

vater_von( otto , hans ).
vater_von( otto , helga ).
vater_von( gerd , otto ).
vater_von( johannes , klaus ).
vater_von( johannes , andrea).
vater_von( walter , barbara ).
vater_von( walter , magdalena ).
