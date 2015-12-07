
:- dynamic produkt/7, verkauft/4,anzahl/2,maxVerkauf/2.        % ermoeglicht dynamische Veraenderung
% :- multifile produkt/7, verkauft/4,anzahl/2,maxVerkauf/2. %
% ermoeglicht verteilte Definition in mehreren Files

% maxVerkauf(Zahl1,Zahl2); es wird das Maximum 2er Zahlen gefunden
maxVerkauf(A,B):-(A>B->retract(anzahl(_,B));retract(anzahl(_,A))).

% produkt(PId,Kategorie,Titel,Autor,Verlag,Jahr,Lagerbestand).
produkt(12345,buch,sonnenuntergang,hoffmann_susanne,meister,2005,23).
produkt(12346,buch,hoffnung,sand_molly,kasper,2004,319).
produkt(12347,buch,winterzeit,wolf_michael,meister,2002,204).
produkt(12348,buch,blutrache,wolf_michael,meister,2010,0).
produkt(12349,buch,winterzeit,wolf_michael,meister,2009,100).

produkt(23456,ebuch,sonnenuntergang,hoffmann_susanne,meister,2009,1).
produkt(23457,ebuch,spuren_im_schnee,wolf_michael,meister,2009,1).
produkt(23458,ebuch,blutrache,wolf_michael,meister,2010,1).

produkt(34567,hoerbuch,hoffnung,sand_molly,audio,2008,51).
produkt(34568,hoerbuch,winterzeit,wolf_michael,audio,2006,16).


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


























