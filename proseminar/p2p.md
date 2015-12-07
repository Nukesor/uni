% Mobile- und Internetbasierte Systeme
% Seminararbeit, Peer-to-Peer
% Arne Beer, MN 6489196

\pagebreak


# Einleitung
Milliarden von Computern verbinden sich täglich über das Internet und benutzen dabei eine Vielzahl von Protokollen.
*Peer-to-Peer* war ursprünglich der Grundgedanke des Internets, dem ARPANET, in dem jeder Nutzer gleichberechtigt war.
Die sogenannte *Peer-to-Peer* Kommunikation nimmt auch heute einen globalen Prozentsatz im Internetverkehrs von bis zu 64 Prozent[^1] für sich ein, mit steigender Tendenz. Bis 2018 soll der Prozentsatz bei ca. 80 Prozent liegen.
Diese Seminararbeit beschäftigt sich damit, wie beliebige Nutzer des Internet ein Netzwerk bilden, in dem alle Nutzer direkt miteinander kommunizieren können.

Dieses Paper ist grob in drei Abschnitte unterteilbar:

Zunächst gehen wir auf unstrukturierte *Peer-to-Peer* Netzwerke ein. In diesem Abschnitt wird auf die Eigenschaften von reinen, hybriden und zentralen *Peer-to-Peer* Netzwerken eingegangen.
Anschließend werden strukturierte Netzwerke erläutert und das DHT-Protokoll angeschnitten.
Zuletzt wird das Bittorrent Protokoll vorgestellt, das momentan am weit verbreitetesten File-sharing Protokoll.


[^1]: Cisco Visual Networking Index: Forecast and Methodology, 2014–2019 -- http://www.cisco.com/c/en/us/solutions/collateral/service-provider/ip-ngn-ip-next-generation-network/white_paper_c11-481360.html


\pagebreak

# Unstrukturierte Peer-to-Peer Netzwerke

## Zentralisierte Peer-to-Peer Netzwerke

Zentralisiertes *Peer-to-Peer* ist die Technologie, welche am ehesten dem klassischen Server-Client Model ähnelt. Bei diesem Aufbau gibt es einen zentralen Server, welcher als *Entry-Node* für alle Peers gilt, also als Einstiegspunkt in das Netzwerk.
Ein Peer ist ein Mitglied des Netzwerkes, des sogenannten Schwarms.
Während sich der Peer in das Netzwerk einklinkt, wird er von dem zentralen Server registriert und ebenso alle anzubietenden Ressourcen des Peers.

Dieser Server ist also ebenfalls für das Finden der Peers untereinander zuständig. Die Peers können sich dementsprechend nicht selbständig finden und haben auch kein Wissen voneinander.
Falls ein Peer also eine bestimmte Ressource oder einen bestimmten Dienst anfragt, sendet er seine Anfrage er hierfür zum zentralen Server. Dieser prüft in der Datenbank ob ein anderer Peer mit einer derartigen Ressource vorhanden ist. Falls dies gewährleistet ist, leitet er dessen Addresse an den suchenden Peer weiter. Mit dieser Addresse kann der suchende Peer sich nun direkt mit dem gewünschten Peer verbinden und die Ressource direkt anfragen.

\FloatBarrier
\begin{figure}[h!]
	\centering
  \includegraphics[width=200pt,height=200pt,keepaspectratio]{gfx/centralizedp2p.png}
	\caption*{http://netzwerke4bw1.wikispaces.com/file/view/p2p\_zentral.gif/79092807/360x294/p2p\_zentral.gif \newline Aufgerufen am 20.07.2015}
\end{figure}
\FloatBarrier


Der Vorteil dieses *Peer-to-Peer* Aufbaus ist der vergleichsweise schnelle *Lookup* der Peers. Es gibt einen zentralen Punkt, in dem alles erfragt werden kann, wodurch sich die *Lookup*-Geschwindigkeit nur durch die Geschwindigkeit des Servers begrenzt.

Hierdurch ergibt sich jedoch auch das Problem, dass es einen *Single Point Of Failure* gibt. Falls der zentrale Server ausfällt, bricht das komplette Netzwerk in sich zusammen, da die Peers einander nicht mehr finden und keine neuen Peers in das Netzwerk einsteigen können.

Man kann in dieser Umsetzung sehr schön den Ansatz erkennen, die Bandbreitenintensiven Vorgänge vom Server zu den Clients/Peers auszulagern.

## Reine Peer-to-Peer Netzwerke

Reine *Peer-to-Peer* Netzwerke sind eine Antwort auf die Frage der Stabilität.
In einem reinen *Peer-to-Peer* Netzwerk existiert kein Peer, welcher einem anderen übergeordnet ist. Jeder Peer ist absolut gleichberechtigt und hat keinerlei spezielle Aufgaben inne.
In einem solchen Netzwerk ist häufig jeder Peer jedem anderen Peer bekannt oder zumindest einem großen Teil. Andernfalls könnten im Falle eines austretenden Peers andere Peers die Verbindung verlieren, falls diese nur über diesen Peer mit dem Netz verbunden wären.

\FloatBarrier
\begin{figure}[h!]
	\centering
  \includegraphics[width=\textwidth,height=\textheight,keepaspectratio]{gfx/reinesp2p.png}
	\caption*{https://www.is.inf.uni-due.de/courses/p2p\_ws03/hybrid.pdf \newline Aufgerufen am 20.07.2015}
\end{figure}
\FloatBarrier

Dadurch wird eine extreme Stabilität des Netzes gewährleistet, da jeder Peer von jedem anderen Peer getrennt werden müsste.
Selbst im Falle einer Spaltung eines solchen Netzes, existieren danach zwei autonome *Peer-to-Peer* Netze.

Ein Nachteil eines solchen Netzes hingegen ist der Entry Node. Es muss also wie bei einem zentralen *Peer-to-Peer* einen Server geben, der als Entry Node dient und mit dem Netz verbunden ist.
Andernfalls benötigt man immer die Addresse eines Peers des Netzes, sonst ist es unmöglich dem Netz beizutreten.
Das größte Problem eine solchen Netzes ist jedoch der *Lookup*. Da es keine zentrale Stelle gibt, muss bei einer Suchanfrage jeder Peer des Netzwerkes angefragt werden.
Dies führt speziell bei großen Netzwerken zu einer extremen Auslastung der Bandbreite, nur durch den *Overhead* des *Lookups*.

## Hybride Peer-to-Peer

Ein hybrides *Peer-to-Peer* Netzwerk ist die Zusammenführung der beiden vorherigen Prinzipien. Es versucht Stabilität mit schnellem *Lookup* zu verbinden.
Die Besonderheit eines Hybriden *Peer-to-Peer* Netzwerks ist, dass einige Peers anhand ihrer Hardware/Bandbreiten-Spezifikationen zu sogenannten Superpeers aufgestuft werden.
Ein solcher Superpeer dient nun für eine Anzahl von Peers als Schnittstelle für *Lookups*. Jeder Superpeer dient folglich als zentraler Server für die Teilmenge der ihm zugeordneten Peers.
Es gibt verschiedene Strategien, mit denen Superpeers die Daten ihrer Peers in einem Schwarm verwalten. Im Folgenden sind einige der Bekanntesten erläutert.


###  Chained Architecture
Die *Chained Architecture* ist eine Aneinanderreihung von Superpeers. Jeder Superpeer kennt lediglich alle Daten der ihm zugeordneten Peers.
Für den Fall dass ein Superpeer eine Anfrage nicht beantworten kann, leitet er diese an andere Superpeers weiter.

Dieses Verfahren ist verhältnismäßig langsam, da erst ein *Lookup* auf einem Superpeer stattfindet und anschließend nacheinander/gleichzeitig auf allen anderen Superpeers.
Dies entspricht dem *Lookup* eines reinen *Peer-to-Peer* Netzwerkes, wobei dieser sich auf das innere Netz der Superpeers bezieht.

###  Full Replication Architecture
Die *Full Replication Architecture* ist ähnlich der *Chained Architecture*, mit Ausnahme, dass jeder Superpeer die Daten aller vorhandenen Peers im Netzwerk besitzt.

\FloatBarrier
\begin{figure}[h]
	\centering
  \includegraphics[width=\textwidth,height=\textheight,keepaspectratio]{gfx/fullReplication.png}
	\caption*{https://www.is.inf.uni-due.de/courses/p2p\_ws03/hybrid.pdf \newline Aufgerufen am 20.07.2015}
\end{figure}
\FloatBarrier


Dadurch ist zwar der *Lookup* von Dateien vergleichsweise schnell, jedoch muss jede Änderung eines Peers und jeder dazukommende oder verlassende Peer bei jedem Superpeer gemeldet und gespeichert werden. Dies sorgt für einen stetigen Overhead zwischen den Superpeers.

###  Hash Architecture
Die *Hash Architecture* stellt eine geordnete Alternative zur *Chained Architecture* zur Verfügung. Hierbei wird jedem Superpeer ein bestimmter Abschnitt einer *Hashtable* zugewiesen. Jede Ressource erhält einen Hash, durch welchen die Superpeers wissen, an welchen exakten Superpeer die Suchanfrage zu stellen ist.

\FloatBarrier
\begin{figure}[h]
	\centering
  \includegraphics[width=\textwidth,height=\textheight,keepaspectratio]{gfx/hashTable.png}
	\caption*{https://www.is.inf.uni-due.de/courses/p2p\_ws03/hybrid.pdf \newline Aufgerufen am 20.07.2015}
\end{figure}
\FloatBarrier


Dieser Aufbau ist das ausgeklügelste Hybride *Peer-to-Peer* Netzwerk. Da jeder Superpeer einen bestimmten Abschnitt der Hashtabelle besitzt, kann jede Anfrage sofort zu dem jeweilig zuständigen Superpeer weitergeleitet werden, der einen schnellen *Lookup* vornehmen kann. Der gesamte *Lookup* wird also durch die Kommunikation zum Superpeer und dessen Zeit zum Herausfinden der Zieladdresse beschränkt.

# Strukturierte Peer-to-Peer Netzwerke

Obwohl der Ansatz der Hybriden *Peer-to-Peer* Netzwerke eine relativ gute Verteilung der Last auf die jeweiligen Superpeers bietet, gibt es dort noch immer einige potentielle Bottlenecks. Um diese Problematik entgültig zu beseitigen wurde die Technologie der *Distributed Hash Table* erfunden.
Mit dieser Technologie wird Stabilität, Ausfallsicherheit, gute Skallierbarkeit und ein relativ schneller *Lookup* mit `O(log(n))` garantiert.

## Distributed Hash Table (DHT)

Der Grundgedanke einer DHT ist dass jede Datei oder jede Ressource, welche im Schwarm gefunden werden kann, durch eine Hashfunktion eindeutig auf einen bestimmten Hash abgebildet werden kann.
Die daraus resultierende Hashtabelle soll bei der DHT auf alle Nodes/Peers möglichst gleichmäßig verteilt wird.
Jeder Node ist dementsprechend zuständig für einen bestimmten Teil der DHT.
Der *Lookup* einer Datei mit einer *Distributed Hash Table* gestaltet sich als sehr unaufwändig.
Jeder Node erhält eine ID, z.B. `1101`, welche dem für ihn zuständigen Hash-Table Abschnitt entspricht. Dadurch, kann jede Anfrage über einen Hash zu dem zuständigen Node geführt werden.
Die Idee ist hierbei, dass jeder Node von jeder Ziffer seiner ID, jeweils eine Addresse aller anderen möglichen Ziffern dieses ID Index besitzt.
Durch dieses Verfahren kann jeder  Node zu einem anderen Node weiterleiten, der mindestens eine Ziffer näher an der Zielnode ist.Man braucht also höchstens log(n) Hops um diesen zu erreichen.
Die gespeicherten Daten eines jeden Nodes beschränken sich ebenfalls lediglich auf log(n).

\FloatBarrier
\begin{figure}[h]
	\centering
  \includegraphics[width=200pt,height=200pt,keepaspectratio]{gfx/dht.png}
	\caption*{http://jan.sacha.pl/pub/dest07/figures/dht7.png \newline Aufgerufen am 28.07.2015}
\end{figure}
\FloatBarrier

Bei DHT treten durch die Verteilung der Hash Table eine Anzahl komplexer Probleme auf.
Die größte Problematik ist hier die gleichmäßige Verteilung der Hashes auf die Nodes. Wenn ein neuer Node dem Schwarm beitritt, muss die DHT neu aufgeteilt werden.
Dies soll jedoch so geschehen, dass nicht alles neu gehasht werden muss, was bei einer klassischen Hashtabelle der Fall wäre, wenn man deren Größe ändert.
Im Falle eines unvorhergesehenen Verlassens des Schwarms, muss der von der Node verwaltete *Namespace* auf die umliegenden Nodes verteilt werden.
Um diese Schwierigkeiten zu behandeln, gibt es verschiedene Implementationen von DHT, z.B. Pastry, CAN und Chord, um einige der Bekanntesten zu nennen. Die Erklärung der jeweiligen Algorithmen würde den Umfang dieser Seminararbeit jedoch sprengen.


# Bittorrent Protokoll
In userer Zeit, in der immer größere Datenmengen, wie z.B. Filme oder andere Medien versendet werden, bietet das Bittorrent Protokoll für genau diese Problematik Abhilfe.
Bittorrent ist ein Filesharing Protokoll, welches sowohl mit einem klassischen zentralisierten *Peer-to-Peer* Netzwerk funktioniert, aber auch in Kombination mit einer DHT arbeiten kann.

Zuerst einige Begriffsklärungen:

- Torrent Datei: Eine Metadatei, in welcher die IP des *Trackers* und Prüfsummen für die herunterzuladenen Dateien gespeichert sind.
- Tracker: Zentraler Server, der alle Torrents/User verwaltet und bei dem neue Torrents hinzugefügt werden. Entry Node.
- Torrent: Die tatsächlich herunterzuladende Datei.
- Seeder: Ein Peer, welcher eine bestimmte Datei herauflädt.
- Leecher: Ein Peer, welcher eine bestimmte Datei herunterlädt.

## Funktionsweise

Das Prinzip von Bittorrent ist, dass jede Datei in Blöcke, sogenannte Chunks, unterteilt wird. Diese sind meist 32KB groß.
Bei dem Senden einer Datei an mehrere Peers wird jedem Leecher ein Abschnitt der Datei gesendet. Hierbei wird versucht die Chunks möglichst gleichmäißig zu verteilen.
Die *Leecher* hingegen beginnen sofort die heruntergeladenen *Chunks* für andere *Leecher* zur Verfügung zu stellen, werden also ebenfalls *Seeder*.

\FloatBarrier
\begin{figure}[h]
	\centering
  \includegraphics[width=\textwidth,height=\textheight,keepaspectratio]{gfx/bittorrent1.png}
	\caption*{http://dud.inf.tu-dresden.de/~kriegel/ss04/hauptseminar/Schoenwiese2004\_HA\_BitTorrent.pdf \newline Aufgerufen am 20.07.2015}
\end{figure}
\FloatBarrier

Durch diesen Mechanismus muss der initiale *Seeder* seine Datei lediglich einmal komplett hochladen, während die maximale Bandbreite für diese Datei innerhalb des Netzwerkes mit jedem weiteren *Leecher* zunimmt.
Um diesen Vorteil zu maximieren gibt es eine Einstellung, welche sich *Superseeding* nennt. Hierbei wird aggressiv versucht so viele Peers wie möglich anzusprechen um die Datei maximal weitläufig zu verteilen.

## Choking

Ein zentrales Problem des Bittorrent Protokolls ist das des *Chokings*. Hierbei verhindert ein *Leecher* das weitere Hochladen der bereits geladenen Datei. Dadurch nimmt er die Rolle eines Parasiten im Schwarm bei.

## Qualitätssicherung

Die Integrität einer Datei wird durch die Torrent Metadatei abgesichert. In dieser Datei stehen die jeweiligen SHA1 Hashes jedes *Chunks* der Datei.
Ein *Leecher* überprüft demzufolge nach jedem *Chunk* dessen Zustand und kann diesen speziellen Teil notfalls erneut herunterladen.

## Weitere Problematiken

Neben der Fülle an Vorteilen des Bittorrent Protokolls, gibt es einige Mankos, wie zum Beispiel die potentielle Nichterreichbarkeit von im Schwarm registrierten Daten.
Dies Tritt auf, falls eine torrent Datei für eine bestimmte Datei im Netz verbreitet wurde, aber kein Peer des Schwarms mehr im Besitz dieser Datei ist.
Es kann jedoch auch nicht gesagt werden, ob zu einem späteren Zeitpunkt ein Peer mit der gewünschten Datei dem Peer beitreten wird.
Ein weiteres Problem ist die Anonymität. Jedes Mitglied des Schwarms kann die IP jedes anderen Seeders problemlos herrausfinden.
Hierzu muss zwar die Datei des Seeders heruntergeladen werden, um eine Verbindung aufzubauen, aber dies stellt nur ein geringes Problem dar, solange man Zugriff auf alle Torrent Metadateien besitzt.
Dazu kommt, dass das Bittorrent Protokoll nativ nicht verschlüsselt ist, also jeglicher Verkehr zwischen zwei Peers mitgelesen werden kann.

# Zusammenfassung

*Peer-to-Peer* ist eine Technologie, welche bereits seit den Anfängen des Internets existiert, aber nun immer mehr an Bedeutung gewinnt. Es gibt natürlich weiterhin Anwendungsfälle, bei denen ein P2P-Netz die falsche Wahl ist, z.B. bei einem klassischen Online Verkaufsshop, jedoch wird in immer mehr Bereichen auf P2P zurückgegriffen, wie zum Beispiel in der Kommunikation (Skype) oder der Datenübertragung (Bittorrent).
Durch *Peer-to-Peer*, existiert ebenfalls die Möglichkeit dezentrale autonome Netzwerke zu bilden, deren Datenverkehr nicht über einen zentralen Server geleitet wird, und dadurch viel schwerer zu überwachen ist, als das herkömmliche Client-Server Modell. Im Bereich der Internetfreiheit, aber auch Internetkriminalität spielt *Peer-to-Peer* eine zunehmend größere Rolle.


\pagebreak

# Literaturverzeichnis

- Lix, Robert (2010), Moderne Applikationen von Peer-to-Peer-Technologien und dezentralen Netzen, diplom.de, ISBN 3836645793, 9783836645799
- Bach, Alexander (2010): Peer-to-Peer Netzwerke in der Praxis, http://www.mi.fu-berlin.de/inf/groups/ag-tech/teaching/2010_SS/S_19510b_Proseminar_Technische_Informatik/alexander-bach-slides.pdf , abgerufen am 01.06.2015
- Stefan Schmid and Roger Wattenhofer: Structuring Unstructured Peer-to-Peer Networks, http://dcg.ethz.ch/publications/hipc07.pdf , abgerufen am 01.06.2015
- Steffen Schoenwiese: Das BitTorrent Protokoll, http://dud.inf.tu-dresden.de/~kriegel/ss04/hauptseminar/Schoenwiese2004_HA_BitTorrent.pdf , abgerufen am 01.06.2015
- Prof. Dr. Thomas Schmidt: https://users.informatik.haw-hamburg.de/~schmidt/it/structured-p2p+p.pdf , abgerufen am 01.06.2015
- Jan Ritzenhoff: https://www.is.inf.uni-due.de/courses/p2p_ws03/hybrid.pdf, abgerufen am 02.06.2015
- Vu, Quang H. et al. (2010). Peer-to-Peer Computing: Principles and Applications. Springer. p. 172. ISBN 978-3-642-03513-5.
