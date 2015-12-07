
:- dynamic kategorie/3.        % ermoeglicht dynamische Veraenderung
%:- multifile kategorie/3.      % ermoeglicht verteilte Definition in mehreren Files

% kategorie(Id_Unterkategorie,Name_Unterkategorie,Id_Oberkategorie)
kategorie(1,buch,0).
kategorie(2,ebuch,0).
kategorie(3,hoerbuch,0).
kategorie(4,kinder,1).
kategorie(5,kinder,2).
kategorie(6,kinder,3).
kategorie(7,krimi,1).
kategorie(8,krimi,2).
kategorie(9,krimi,3).
kategorie(10,roman,1).
kategorie(11,roman,2).
kategorie(12,roman,3).
kategorie(13,sachbuch,1).
kategorie(14,sachbuch,2).
kategorie(15,bilderbuch,4).
kategorie(16,reisefuehrer,13).
kategorie(17,lexikon,13).
kategorie(18,lyrik,1).
kategorie(19,lyrik,3).
kategorie(20,bastelbuch,4).
kategorie(21,woerterbuch,13).

%Für Aufgabe 4.4
kategorie(22,kaputt,24).
kategorie(23,kaputt2,24).

% produkt(PId,KId,Titel,Autor,Verlag,Jahr,Lagerbestand).
produkt(12345,10,sonnenuntergang,hoffmann_susanne,meister,2005,23).
produkt(12346,18,hoffnung,sand_molly,kasper,2004,319).
produkt(12347,7,winterzeit,wolf_michael,meister,2002,0).
produkt(12348,7,blutrache,wolf_michael,meister,2010,200).
produkt(12349,7,winterzeit,wolf_michael,meister,2009,100).

produkt(23456,11,sonnenuntergang,hoffmann_susanne,meister,2009,1).
produkt(23457,11,spuren_im_schnee,wolf_michael,meister,2009,1).
produkt(23458,8,blutrache,wolf_michael,meister,2010,1).

produkt(34567,19,hoffnung,sand_molly,audio,2008,51).
produkt(34568,9,winterzeit,wolf_michael,audio,2006,16).


% verkauft(PId,Jahr,Preis,Anzahl).
verkauft(12345,2006,39,71).
verkauft(12345,2007,39,23).
verkauft(12345,2008,39,11).
verkauft(12345,2009,29,15).
verkauft(12345,2010,29,17).
verkauft(12345,2011,29,9).
verkauft(12345,2012,23,8).
verkauft(12346,2005,24,391).
verkauft(12346,2006,24,129).
verkauft(12346,2007,24,270).
verkauft(12346,2008,24,350).
verkauft(12346,2009,24,168).
verkauft(12346,2010,24,89).
verkauft(12346,2011,24,30).
verkauft(12346,2012,24,2).
verkauft(12347,2002,29,430).
verkauft(12347,2003,34,380).
verkauft(12347,2004,39,137).
verkauft(12347,2005,39,24).
verkauft(12347,2006,39,0).
verkauft(12347,2007,39,0).
verkauft(12347,2008,29,0).
verkauft(12347,2009,29,0).
verkauft(12347,2010,29,0).
verkauft(12347,2011,19,0).
verkauft(12347,2012,9,0).
verkauft(12348,2010,29,412).
verkauft(12348,2011,29,257).
verkauft(12348,2012,29,12).
verkauft(12349,2009,17,213).
verkauft(12349,2010,19,45).
verkauft(12349,2011,19,137).
verkauft(12349,2012,14,83).

verkauft(23456,2009,13,0).
verkauft(23456,2010,13,1).
verkauft(23457,2009,13,1).
verkauft(23457,2010,13,2).
verkauft(23457,2010,13,1).
verkauft(23457,2010,2,70).
verkauft(23458,2010,13,12).
verkauft(23458,2011,13,21).
verkauft(23458,2012,13,13).

verkauft(34567,2008,21,99).
verkauft(34567,2009,21,124).
verkauft(34567,2010,21,89).
verkauft(34567,2011,21,52).
verkauft(34567,2012,21,39).
verkauft(34568,2006,16,4).
verkauft(34568,2007,16,28).
verkauft(34568,2008,16,3).
verkauft(34568,2009,3,112).
verkauft(34568,2010,3,89).
verkauft(34568,2011,3,75).
verkauft(34568,2012,3,23).

