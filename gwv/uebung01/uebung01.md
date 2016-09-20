% Grundlagen der Wissensverarbeitung
% Arne Beer, MN 6489196;Marta Nevermann, MN 6419716;Daniel Waller, MN 6813853

\pagebreak

## Exercise 1.1 Application Scenarios for Artificial Intelligence

### Example 1: Ein Chatbot.
Die Aufgabe eines Chatbots ist, einen normalen menschlichen Gesprächspartner zu simulieren. Gegeben ist nichts weiter als ein einfaches Computerprogramm, welches auf dem Chatserver läuft.  
Um diese Aufgabe bewältigen zu können, muss der Chatbot in der Lage sein, den Text eines Users zu interpretieren, einem Kontext zuzuweisen und eine dem Kontext entsprechende logische Antwort zu liefern.  
Falls eine Frage gestellt wurde, muss der Chatbot potentiell in der Lage sein eine eigene Meinung zu dem jeweiligen Thema zu bilden und zu formulieren.  
Hierzu wird eine Menge an Fähigkeiten benötigt, wie die Interpration von Sprache, Assoziation der Sprache mit Themen aus der realen Welt, potentiell Meinungsbildung und anschließend Formulierung einer sinnvollen Antwort.  
Derartige Programme wurden bereits häufig versucht zu modellieren und bauen meist auf großen Datenbanken auf, um ein möglichst breites und tiefes Wissen abzudecken. Einige Bots sind auch an ein learning network gebunden, sodass sie sich im Laufe der Zeit weiterentwickeln.
Ein passendes Beispiel hierzu ist ["Brain"](http://www.thebot.de/about_brain.html), ein deutschsprachiger Chatbot, der mit der Zeit lernt. Jedoch ist auch hier zu sehen, dass auf längere oder spezifische Fragen meist mit einem sinnlosen Satz geantwortet wird.


## Exercise 1.2 AI Terminology

### Examples for Information
Information ist einfach gesagt eine Menge von Daten, in beliebiger Form, die auf einen Empfänger trifft. So sind zum Beispiel Licht, Geschmack oder Gerüche Informationen für unsere Sinne. Ein weiteres Beispiel wäre eine Datenübertragung zwischen zwei in einem Netz befindlichen Rechnern. \newline
Wahrgenommene bzw. empfangene Informationen bilden in der Regel ihren Informationsgehalt auf das explizite oder implizite Wissen eines Agenten ab. Ohne die Verknüpfung der Information zum Wissen des Agenten ist diese für den Agenten wertlos und könnte genauso gut ein beliebiger Umgebungsreiz sein.
Beispiele für die Verarbeitung bzw. Wertlosigkeit von Informationen wären ein Autofahrer, der ein "Stop"-Schild sieht und aus dem mapping auf sein explizites Wissen weiß, welche Aktion er auszuführen hat; während ein Hund der mit im Auto sitzt mit dem Schild keinerlei Wissen verbindet und es somit als unwichtiger Umgebungsreiz wahrscheinlich nicht einmal seine bewusste Wahrnehmung erreicht.

### Examples for Implicit knowledge
Implizites Wissen, findet sich in verschiedenen Eigenschaften oder Fähigkeiten, welche Menschen sich beigebracht haben. Ein Beispiel hierfür ist z.B. das Querlesen von Büchern. Menschen die dies beherrschen, können es anwenden, jedoch nur sehr schwer bis überhaupt nicht erklären, wie sie dieses zustande bringen. Weitere Beispiele sind z.B. Balancieren auf einer Leine oder das Zuordnen eines Geräusches zu einer bestimmten Richtung.

### Examples for Explicit knowledge
Explizites Wissen, im Gegensatz zu implizitem Wissen, findet sich z.B. in Form von Büchern, Internetseiten, sowie Dokumentationen oder Source Code. 
Das heißt, es handelt sich um kodierte Information, die gespeichert, kommuniziert, und weiterverarbeitet werden kann.

### Fully Observable & Partially Observable
Eine Umgebung ist vollständig beobachtbar, wenn diese (bzw. all ihre handlungsrelevanten Aspekte) zu jedem Zeitpunkt durch die Sensoren des Agenten wahrgenommen werden kann. Im Falle einer teilweise beobachtbaren Umgebung bräuchte der Agent also eine zusätzliche Datenbank an Meta-Informationen (z.B. wie bestimmte beobachtbare Gegebenheiten in der Umgebung zueinander in Beziehung stehen und wirken), die es ihm erlauben möglichst treffende Voraussagen über den nicht wahrnembaren Teil der Umgebung zu treffen. 
Ein gutes Beispiel für eine teilweise beobachtbare Umgebung wäre z.B. die Kommunikation eines Roboters mit einem Menschen. Zwar kann der Roboter über seine Sensoren das Gesprochene wahrnehmen und vielleicht sogar Gefühlsregungen in der Mimik des Gegenübers erkennen, er hat aber keinen Einblick in die Gedankenwelt seines Gegenübers und kann daher nur in begrenztem Umfang die Absichten, die sich hinter einem bestimmten Satz verbergen aus den äußerlich erkennbaren Reizen interpretieren bzw. vorhersagen.

### Discrete & Continuous
In einer diskreten Umgebung gibt es nur eine eindeutig begrenzte Anzahl an Handlungsoptionen, genau so wie eine endliche Anzahl an klar definierten Dingen, die wahrgenommen werden können. Ein klassisches Beispiel dafür ist Schach.
In einer kontinuierlichen Umgebung gibt es eine unendliche Anzahl an Dingen mit unendlich vielen Varianten und Abstufungen, die von einem Agenten wahrgenommen werden können. Ein Problem was aus einer solchen Umgebung entsteht ist, dass der Agent Entscheidungen darüber treffen muss ab wann ein wahrgenommener Unterschied zwischen zwei Umgebungsreizen relevant für sein Verhalten wird und welche Unterschiede er ignorieren kann.  \newline
Ein Beispiel dafür wäre ein Roboter, der in einem Raum farbige Objekte erkennen muss, die aber mit unterschiedlicher Ausleuchtung des Raumes für die Wahrnehmung des Roboters variierende Farbabstufungen annehmen.

### Deterministic & Stochastic
In einer deterministischen Umgebung ist der nächste Zustand allein durch den aktuellen Zustand und die Handlung des Agenten bestimmt. Ein Beispiel dafür ist das Spiel "Dame". Jedes Spiel, bei dem gewürfelt werden muss oder eine andere Zufallskomponente gegeben ist, ist ein Beispiel für eine stochastische Umgebung. Ist eine Umgebung für einen Agenten nur teilweise beobachtbar, so erscheint sie dem Agenten ebenfalls stochastisch.



