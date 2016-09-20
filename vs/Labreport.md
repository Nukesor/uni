\graphicspath{{./report3/}{./report4/}{./report5/}{./report5/7/}{./report6/}{./report8/4/}}

#Part 2 Subnetting

## Excercise 1: Subnetting
a) Diese Aufgabe wurde von uns auf dem Arbeitsblatt gelöst und kontrolliert.  
b) Siehe Aufgabe 1 a)

## Exercise 2: Configure two Subnets using VMware Workstation
a) Please subnet and configure the above network and give each host an IP address using the result of Exercise 1 a).  
b) Please configure all hosts shown on Figure 1

Zum Lösen der Aufgabe benutzen wir die im vorherigen Part in der VMWare erstellten Betriebssysteme.
Die Ip Adressen und Subnetznetmasken werden nun mithilfe des CentOs Netzwerkmanager wie folgt konfiguriert.

svrt10-bln:  
            Ip address:     192.168.100.130  
            Subnet netmask:    255.255.255.224  
            Gateway:        192.168.100.129  

midl10-hh:  
            Ip Adress:     192.168.100.193  
            Subnet netmask:   255.255.255.224  
            Gateway:       192.168.100.194  

## Exercise 3: Configure the Router "pvsrou10-1"

a) This exercise involves working with multiple IP segment networks. There are two workstations and one router. Configure the interfaces on the machines and manually set the routing tables to the correct values.

Um diese Aufgabe zu erfüllen richten wir ein weiteres CentOs nach der zuvor benutzten Vorgehensweise ein. Dieses Linux System wird im nachfolgenden so eingerichtet, dass es als Router fungiert.
Hierfür wird der VM ein weiteres Ethernet Gerät hinzugefügt, welches wir mithilfe der VMWare Einstellungen bewerkstelligen.
Die nun vorhandenen Ethernet Geräte werden wie folgt eingestellt

Eth0:  
            Ip Adress:     192.168.100.194  
            Subnet netmask:   255.255.255.224  
            Gateway:       0.0.0.0  

Eth1:  
            Ip Adress:     192.168.100.129  
            Subnet netmask:   255.255.255.224  
            Gateway:       0.0.0.0  

b) Configure the routing tables for the pvsrou10-1 machine to enable IP forwarding.  
Um Ip-forwarding zu ermöglichen führen wir in der Konsole den Befehl `echo 1 > /proc/sys/net/ipv4/ip_forward` aus. 
Damit das IP-forwarding auch nach dem Neustart aktiv bleibt muss noch in der `/etc/sysctl.conf` `net.ipv4.ip_forward = 1` eingetragen werden.
Die Firewall Einträge müssen gelöscht werden, um einen Ping zu ermöglichen. Hierfür wird `iptables -F` in der Konsole ausgeführt. Dieser Befehl löscht alle Einträge der Firewall. 

c) Ping all machines.  
    Mit `ping rechnerip` konnten wir erfolgreich alle Rechner anpingen.

#Part 3: Network Services #1: Filesystems Linux / Windows

##Exercise 1: Using the man pages
Hierbei sollen wir den selbständigen Umgang mit den man pages der Linux Umgebung lernen. Als Standarteditor wird vi benutzt, weshalb man mit den Standartfunktionen durch das Manual navigieren kann. Ebenfalls ist der typische `/` search command dadurch in den man pages möglich.

1. How do you go to the beginning of the man page with one keystroke?  
Mit der Taste "Pos1/gg" kommt man direkt an den Anfang der man page.
2. How do you go to the end of the man page with one keystroke?  
Mit der Taste "Ende/G" kommt man direkt ans Ende der man page.
3. How do you search for a word within the man page?  
In einer Man-Page kann man mit "/Suchbegriff" nach einem Wort suchen.
4. How do you search again for the same word using a keystroke?  
Erneutes Suchen nach diesem Wort erfolgt durch "n".
5. Find out how to use the df command.  
Der Befehl `df / -h ` gibt den freien Speicher der root Partition in lesbarem Format aus.

##Exercise 2: Practice using vi
Diese Aufgabe wurde uns aufgrund unserer bereits bestehenden Erfahrung mit vi/vim erlassen.

##Exercise 3: Using some basic commands Part 1
In dieser Aufgabe werden einige Grundlegende Befehle wie Pipe, <, >, >> oder Linux Navigations-und Untersuchungstools wie ls und cd vorgestellt.
Da wir bereits in ausreichendem Masse über die Funktionsweise dieser Programme informiert sind, wurde uns hier ein Großteil der Aufgaben von Robert erlassen. Es handelt sich hierbei hauptsächlich um basics.

1. `tty` : Gibt den Namen und Standort der mit dem momentan benutzten Terminal verbundenen Datei aus.
2. `whoami` : Gibt den Namen dtes Users zurück, als der man momentan angemeldet ist.
3. `w & who` :
    - `w` gibt an, wer momentan eingeloggt ist und, welche Prozesse er ausführt.
    - `who` gibt lediglich an, wer momentan eingeloggt ist.
    - `who -a`  gibt sämtliche Prozesse seit dem letzten System Boot mit Zeitangabe aus, inklusive bereits geschlossene Prozesse.
4. `pwd`: Gibt den Pfad des momentanen Ordners vom root aus an.
5. `cd`: Wird benutzt um in einen Ordner zu wechseln.
    - `cd ..` versetzt den User in das übergeordneten Ordner.
    - `cd /` versetzt den user in den root Ordner.
    - `cd .` versetzt den user in den momentane Ordner.
    - `cd ~` versetzt den user in den home Ordner.
    - cd plus tab-completion zeigt alle im momentanen Ordner vorhandenen Ordner.

6. `ls` : Gibt alle momentan im Ordner nicht versteckten Dateien an.
    - `ls -l` gibt alle momentan im Ordner vorhandenen Dateien mit den jeweiligen Zugriffsrechten.
    - `ls -l /` wie der vorherige Befehl, bloß für alle Dateien im root.
    - `ls -al` Wie ls -l, nun werden jedoch auch versteckte Dateien angezeigt.
    - `ls -l .Xautohrity .ssh/ ` führt `ls -l` auf die dotfile und den `.ssh/` Ordner aus

    - `ls -ltr` gibt alle files in umgekehrter Reihenfolge nach dem letzten Zugriff aus.

7. `touch`: Erstellt eine neue Datei.

    - Die aufgezählte Befehls Abfolge erstellt die neue txt file `lion1.txt`, kopiert `/etc/sysctl.conf` nach `lion1.txt`.

8. `echo` : Stellt einen Text auf der Konsole dar.

    - Das Kommando printed "This is a Test" in die Konsole.

9. `cat` Gibt den Inhalt einer Datei aus.

    - `cat test.txt && $` 

    - `cat test1.txt test2.txt > test3.txt` kopiert die Inhalte von `text1.txt` und `text2.txt` nach `text3.txt`.

10.`id` Gibt die jeweiligen Gruppen und deren ID an, in denen der User eingetragen ist.
11. `mkdir temp` erstellt ein neues Directory im momentanen dir namens `temp`
12. `rm -rf temp*` entfernt alle Dateien und Ordner in temp inklusive temp. Fehlerprompts werden ignoriert.

    - `rm -rf temp[34]` tut hier nichts, da das directory nicht existiert, aber der Fehlerprompt durch die -f Flag unterbunden wird.

13. `which` gibt den Pfad eines jeden Shell Commands aus.

    - `which cat && which ls` gibt die Pfade der Programme cat und ls aus.

14. `echo $PATH` gibt alle Pfade aus, unter denen Executables zu finden sind.
15. < nimmt  die rechts stehende Datei als Input.

    - > Schreibt den Output in die links stehende File.

    - >> Hängt den Output an die lenks stehende File an.

18. `cat text1.txt > test2.txt` überschreibt text2.txt mit text1.txt

    - `cat test1.txt >> test2.txt` hängt text1.txt an text2.txt an.

##Exercise 4: Using some basic commands Part 2
In dieser Aufgabe sollen wir einige Grundlegende Programme wie Pipe, <, >, >> oder Linux Navigations-und Untersuchungstools wie ls und cd benutzten.
Da wir bereits in eigenem Arbeiten haüfig Gebrauch von diesen Programmen gemacht haben, wurde uns hier ein Großteil der Aufgaben von Robert erlassen. Es handelt sich hierbei hauptsächlich um basics.

1. Der Befehel `cat /etc/passwd > /etc/passwd.txt` erstellt ein Backup der passwd nach /etc/passwd.txt.
2. `users` zeigt alle zur Zeit am Host  angemeldeten Usernamen.
3. `who` zeigt wer wo und seit wann eingeloggt ist.
4. `w` zeigt was die eingeloggten User gerade ausführen.
5. `date` gibt das aktuelle datum aus.
6. `tail -f /var/log/messages.log` gibt log Nachrichten aus und wartet auf neue.
7. `which nmap` gibt den Programmpfad des Programmes nmap aus.
8. `find / -user root -perm -4000 -print` sucht nach Dateien des Users root mit den gesetzten SUID.
9. `rpm -qf filename` gibt das Paket aus welches die Datei filename beinhaltet.
10. `whereis` gibt den Pfad eines Programmes/ Manuals aus.
11. `ps -ef / ps-aux` gibt die laufenden Prozesse aus.
12. `netstat -ntlp` gibt alle offenen TCP Verbindungen aus/ `netstat -nulp` gibt alle offenen UDP Verbindungen aus.
13. `find / -user root -perm -2000 -print` sucht nach Dateien des Users root mit gesetzten SGID.
14. `touch f1` erstellt die Datei f1 und `ls -l` listet alle Dateien im Ordner auf.
15. a) `ping` schickt ein echo Paket an eine angegebene IP Adresse.
        b) `last` gibt aus wann sich welcher User eingeloggt hat.
        c) `uptime` gibt aus wie lange der Rechner läuft, wie viele User eingeloggt sind, wie viel Uhr es ist und die Last.
        d) `ls` gibt eine Liste der Dateien des aktuellen Ordners aus..
16. `df > diskspace.txt` speichert den aktuellen freien Speicher aller Partitionen in der Datei diskspace.txt.
17. `who | sort -r` gibt die eingeloggten Usern in anderer Reihenfolge aus.
18. `sort /etc/passwd > passwd.txt` speichert die /etc/passwd Datei in sortierter Reihenfolge in der passwd.txt Datei ab.
19. `cat /etc/passwd | sort  > passwd.sorted` speichert die Datei in sortierter Reihenfolge in der Datei passwd.sorted.
20. `cat passwd.sorted | wc` gibt die Anzahl der Zeilen, Wörter und Bytes der Datei passwd.sorted aus.
21. `wc passwd.sorted` siehe oben.
22. `cat /etc/passwd.sorted | wc -w` Gibt nur die Anzahl der Wörter aus.
23. `wc -w passwd.sorted` siehe oben.
24. `traceroute 192.168.X.10` pingt eine IP Adresse mit aufsteigenden TTL werten an, um so die sich auf dem Weg befindenden Router aufzuspüren.
25. `ifconfig -a` gibt die Konfiguration aller Netzwerkschnittstellen aus.
26. `tail -n10 /etc/services` gibt die letzen 10 Zeilen der Datei /etc/services aus, in der sich die Zuordnung von standardisierten Ports zu Diensten befindet.
27. `echo "hello world" >> out; cat out` schreibt hello world in die Datei out und gibt diese Datei aus.
28. Dies startet das System im nicht graphischen Modus.
29. `rpm -qa tcpdump` gibt infos über das Paket tcpdump.
30. `rpm -Uhv` gibt eine Hashliste der zu Updatenden Pakete an.
 
##Exersice 5: Linux File Permissions 
Da wir bereits Erfahrungen in dem Bereich der Linux Datei Berechtigungen besitzen, wurde uns diese Aufgaben von Robert erlassen.

##Exersice 6: Windows NTFS File Permissions
In dieser Aufgabe sollen wir lernen mit den NTFS Dateiberechtigungen umzugehen.  
Dafür erstellen wir 3 Benutzer, pvsgr10(admin), benjamin und otto über die Systemeinstellungen. Außerdem erstellten wir die Ordner `C:\Alles` und `C:\Alles\privat`.  

1. Please determine the default NTFS permission for the newly created "Alles" folder. How to do this?  
Über Eigenschaften/Sicherheit sieht man die Dateiberechtigungen der Ordner oder Dateien. Die beiden neu erstellen Ordner besitzen für den Administrator und das System Vollzugriff. Normale Benutzer besitzen nur Leserechte.  
\includegraphics{User-rights-windows.png}  
2. Set the permission for the directory "Alles" as follows:  
i) Change the owner of the directory and the subdirectory to "benjamin"
Unter "Eigenschaften/Sicherheit/Erweitert/Besitzer Ändern/Erweitert/Jetzt Suchen" kann man einen anderen User als Besitzer einstellen. Dort haben wir benjamin ausgewählt.
ii) Set the permissions on the directory that will not allow "otto" to write into the directory (read only permission)  
Um dem Benutzer otto die Schreibrechte auf diesen Ordner zu verweigern wählt man im Fenster Erweiterte Sicherheitseinstellungen "Berechtigung ändern / Hinzufügen/ Prinzipal auswählen/Erweitert/Jetzt Suchen/Benutzernamen" den Benutzer otto. Unter Typ wählt man "Verweigern" und wählt als Berechtigung "Schreiben".  
3. Test the permissions for the "Alles" folder  
Um die Berechtigungen zu testen, loggen wir uns zu erst mit dem Benutzer banjamin ein, dort erstellen wir eine Textdatei mit Inhalt. Dies ist möglich, da der Benutzer der Besitzer des Ordners ist und Vollzugriff besitzt.  
4. Auch das Öffnen, Ändern, Abspeichern und Löschen der Datei funktioniert.  
5. Nachdem wir mit dem Benutzer pvsgr10 eine Textdatei im Ordner `C:\Alles` erstellt haben, loggen wir uns unter dem Benutzer otto ein und öffnen den Ordner Alles. Dort ist es nicht mehr möglich über das Rechtemaustasten-Menü eine Datei zu erstellen. Wollen wir eine Datei in diesen Ordner kopieren müssen wir dies mit Administrations Rechten ausführen.  
Bei dem Versuch die Datei zu ändern scheitern wir beim Abspeicher, da der Benutzer keine Schreibrechte besitzt. Das Löschen hingegen funktioniert noch, da dem Benutzer die Löschrechte nicht entzogen wurden.  



##Exercise 7: Assinging NTFS Permissions Part 1

1. Logon as user pvsgr10 and assign NTFS permissions for the "Alles" folder.  
- All users should be able to read documents and files in the "Alles" folder.  
- All users should be able to create documents in the in the "Alles" folder.  
- All users should be able to modify the contents, properties and permissions of the documents that they create in the "Alles" folder.  

Um die geforderten Rechte zu gewährleisten, fügen wir unter dem Tab Sicherheit/Bearbeiten einen weiteren User `jeder` oder `everyone`  hinzu und geben ihm Vollzugriff auf den Ordner.

2. i) Based on what you learned in Exercise 5, what changes in permission assignments do you need to make to meet each of these four criteria? Why?  
Um diese Kriterien zu erfüllen, müssten wir dem Ordner die Berechtigung 777 geben, oder 770 und anschließend alle User in die file group des Ordners eintragen.
ii) You are currently logged on as otto. Can you change the permissions assigned to user otto while logged on as otto? Why or why not?  
Dies ist möglich, da wir zuvor otto volle Zugriffsrechte auf den Ordner übertragen haben.

##Exercise 8: Assinging NTFS Permissions Part 2

1. This time you set the permissions for the folder "Alles" to read only for everyone. How?  
Wir fügen nun unter Erweiterte Sicherheitseinstellungen für "Alles" "everyone" hinzu und verweigern ihm alle Rechte bis auf die Lese Rechte.
2. What is the meaning of "authenticated users"?  
Die Gruppe der "authenticated users" besteht aus allen Usern, bis auf den Gast-Account. Dieser wird nie als "authenticated user" behandelt.
3. Explain the difference between "authenticated users" and "everyone".  
Die "everyone" Usergroup beinhaltet sowohl alle in "authenticated users" eingetragenen User, wie auch nicht authentifizierte User, wie z.B. Gast-Accounts.
4. Try to create a file in the "Alles" folder.  
Es ist nicht mehr möglich eine Datei oder einen Ordner zu erstellen.
5. Try to delete the file "Mueller.txt"  
Eine Datei zu löschen ist auch nicht mehr möglich.
6. Try to remove the directories "Alles" and "private". Is it possible?  
Auch das Löschen eines Ordners ist nicht mehr möglich.


#Part 4: Network Services/Monitoring Tools

##Exercise 1: Managing Users & Groups using Putty to connect from pvscnt10-bln to pvssvr10-bln:

1: Mit `useradd goethe && ls -l /home/goethe` wird ein neuer User `goethe` erstellt und anschließend der Home Ordner des Users detailliert aufgelistet.  
Mit `cat /etc/password | grep goethe` piped man mithilfe von `cat` den Inhalt von `/etc/password` zu `grep`, welches den Text nach dem String goethe durchsucht und die Zeilen in denen der String vorkommt ausgibt. `/etc/password` ist an dieser Stelle fehlerhaft, da die Userdaten in `/etc/passwd` gespeichert sind. Die Ausgabe von `/etc/passwd/` liefert neben dem Usernamen, seine UserID, seine GruppenID, einen Kommentar, sein Home Ordner und seine Shell.

2:  
i) `groupadd schiller4` fügt eine neue Gruppe namens `schiller4` hinzu
ii) `useradd -d /home/schiller4 -s /bin/bash -g schiller4 schiller4` erstellt einen neuen User schiller4. Mit dem Parameter `-d` wird der Home Ordner für den neuen User festgelegt, in diesem Fall `/home/schiller4`. Mit dem Parameter `-s` wird die Standardshell für den neuen User festgelegt, in diesem Fall Bash. Mit dem Parameter `-g` wird die initiale Logingruppe für den neuen User festgelegt, in unserem Fall die Gruppe schiller4.  
iii) Mit `passwd schiller4` wird das Passwort für schiller4 gesetzt.

3: `chage` wird benutzt um die Ablaufzeiten eines Passwort festzusetzen.  
Mit `chage -M 10 schiller4 && chage -l schiller4` wird die maximale Zeit in der ein Passwort für schiller4 gültig ist auf 10 Tage gesetzt. Anschließend wird die momentane Kontoalterungsinformation für schiller4 ausgegeben.

4: Mit `chage -M 3 -m 1 schiller3 && chage -l schiller3` wird die maximale Zeit in der ein Passwort für schiller3 gültig ist auf 3 Tage gesetzt und die Zeit nachdem ein Passwort erneut geändert werden kann auf 1 Tag gesetzt. Anschließend wird die momentane Kontoalterungsinformation für schiller4 ausgegeben.

5: `groupadd schiller5 && useradd -g schiller5 -d /home/schiller5 -s /bin/bash schiller5 && chage -l schiller5` Diese Zeile fügt equivalent zu Aufgabe 1 i) und ii) eine neue Gruppe `schiller5` hinzu und anschließend einen neuen User, der in diese Gruppen eingetragen wird, der den Home Ordner /home/schiller5 und Bash als Standartshell zugewiesen bekommt. Zudem werden die Kontoalterungsinformationen für diesen User ausgegeben. 

6: `userdel -r schiller5` entfernt schiller5 inklusive des dem User zugeordneten Home directory.

##Exercise 1b:
1)`chkconfig` ist ein Manager für Runlevel Information von System-Services  
2)`chkconfig --list iptables` zeigt den Status der verschiedenen Runlevels von iptables.
3)`chkconfig --level 2 iptables off` setzt das Runlevel 2 für iptables offline  
4)`chkconfig --level 2345 iptables off` setzt das Runlevel 2,3,4 und 5 für iptables offline  
5)`chkconfig iptables on | off` setzt alle Runlevel auf bis auf 0, 1, 6 on oder off  
6)`chkconfig tftp` setzt alle Level von tftp bis auf 0, 1, 6 auf on.  
7)`chkconfig --level 2 vsftpd off` setzt das Runlevel 2 für vsftpd off
8)`chkconfig --level 2345 vsftpd off` setzt das Runlevel 2,3,4 und 5 für vsftpd off
9)`xinitd` ist ein Service, welcher die Netzwerkservices verwaltet, welcher die Programme jedoch erst startet, sobald diese benötigt werden. Das heißt, er horcht auf den Ports gewisser Services und startet erst bei Aktivität die dazugehörigen Netzwerkservices.  
0)`service network stop`  ruft das Servicescript für den network service mit dem Stop-Parameter auf. Es stoppt somit das Netzwerk.   
11)`service network start` ruft das Servicescript für den network service mit dem Start-Parameter auf. Es startet somit das Netzwerk.
12) `ntsysv` Ist ein gui wrapper für chkconfig für Autostart Konfiguration.  
13) `ntsysv` Startet ntsysv.  
14) Mit `system-config-` + zweimal Tab.  
15)`system-config-authencation` Grafische Oberfläche zum managen von Identitäts und System Authentifizierung.  
16)`system-config-date` öffnet eine grafische Oberfläche zum Anpassen des Datums und der Zeit.  
17)`system-config-firewall` Grafische Oberfläche für Firwall rule management.   
18)`system-config-firewall-tui` Terminal User Interface für Firewall rule management.  
19)`system-config-kdump` Grafische Oberfläche für Kernal Crash Dumping.  
20)`system-config-keyboard` Grafische Oberfläche für Tastatureinstellungen, wie Layout oder Sprache.  
21)`system-config-kickstart` Grafische Oberfläche für Erstellen von Kickstartfiles.   
22)`system-config-language` Grafische Oberfläche zum ändern der OS-Sprache.  
23)`system-config-lvm` Grafische Oberfläche zum managen von logischen Datenträgern.  
24)`system-config-network` Grafische Oberfläche für Netzwerkverwaltung.  
25)`system-config-network-cmd` Commandline Interface für Netzwerkverwaltung.  
26)`system-config-network-tui` Terminal User Interface für Netzwerkverwaltung.  
27)`system-config-printer`  GUI Printer Configuration Tool.  
28)`system-config-printer-applet` Grafische Oberfläche für Drucker Job Management.  
29)`system-config-selinux`  Grafische Oberfläche für das Security Enhanced Linux Modul des Linux-Kernels.  
30)`system-config-services`  Grafische Oberfläche zum ein- oder ausschalten von Services.  
31)`system-config-users` Grafische Oberfläche für User und Gruppen Verwaltung.   

##Exercise 2: Getting started with network monitoring tools:
i) Install (if needed) and get familiar with the following tools: nmap, tcpdump, Wireshark.  
Die von der Aufgabe geforderten Programme sind bereits auf den Systemen installiert, dementsprechend fahren wir direkt mit der nächsten Aufgabe fort.  
ii) Starting two virtual machines pvssvr10-bln and pvsmid110-hh connected to your network. Connect from the virtual workstation, pvsmid110-hh to the pvssvr10-bln see figure 4. Follow several links on the server while watching packet flow using the two tools Wireshark and tcpdump. Also try other network services: ftp, ssh.  
Auf pvssvr10-bln wird als root ein HTTP-Service gestartet mit `service httpd start`. Anschließend wird auf pvsmid110-hh Wireshark auf dem Netzwerk Interface eth3 gestartet und mithilfe von Firefox ein HTTP Request an die Ip-Adresse `192.168.100.34` geschickt. Damit der HTTP-Request durch kommt, muss die Firewall (iptables) deaktiviert sein.
Innerhalb von Wireshark sehen wir den genauen Ablauf des TCP Protokolls, der im Screenshot zu sehen ist.   
\includegraphics{WiresharkHTTP.png}

Ebenfalls loggen wir uns über ssh vom Client auf den Server ein, mithilfe des Befehls `ssh 192.168.100.34`.  Wireshark läuft dabei nebenbei weiter, sodass wir den typischen Verlauf des SSH-Protolls in Kombination mit dem TCP-Protokolls sehen, siehe den folgenden Screenshot. Der typische Verlauf des `SYN`, `SYN-ACK`, `ACK`, `ACK`, `DATA` ist gut zu erkennen. `DATA` ist in diesem Falle in mehreren Schritten, die Einleitung des SSH-Protokolls, und anschließend verschlüsselte Daten, die zwischen den Rechnern geschickt werden. Wenn die SSH Verbindung beendet wird, wird die Abfolge `ACK- FIN`, `ACK`, `ACK, FIN`, `ACK` eingeleitet.  
\includegraphics{WiresharkSSH.png}

Ebenfalls interessant ist zu sehen, dass wir mit Wireshark innerhalb der Virtuellen Maschine den Internet-Traffic des Host-PCs sniffen können. Wir können dementsprechend den kompletten Traffic abfangen. Dies sollte aus der Virtuellen Maschine eigentlich nicht möglich sein.

##Exercise 3: Wireshark:
i) Please write the syntax for a Wireshark command with capture filter so that all IP datagrams with source or destination IP address equal to 192.168.100.35 are recorded.  
Um die geforderte Filtereinstellung einzustellen, schreibt man `ip.addr == 192.168.100.35 && udp` in die Filterzeile. Dadurch werden alle Pakete danach gefiltert, dass sie die Ip-Adresse `192.168.100.35` besitzen und udp Pakete (Datagramme) sind.
ii) Please write the syntax for a Wireshark display that shows IP datagrams with destination IP address equal to 192.168.0100.35 and frame size greater than 400 bytes.  
`ip.dst == 192.168.100.35 && udp && frame.len >= 400` Fügt zu dem vorherigen Filter noch die Bedingung hinzu, dass die Framelänge grösser als 400 Bytes beträgt und dass die Ip-Adresse der Destination Ip entspricht.
iii) Syntax for ICMP messages with source or destination IP address 192.168.100.35 and frame numbers between 15 and 30.  
`ip.addr == 192.168.100.35 && icmp && frame.len >= 15 && frame.len <= 30` Dieses Filter filtert nach ICMP Paketen, welche eine Länge zwischen 15 und 30 Bytes besitzen. 
iv) Syntax for TCP segments with source or destination IP 192.168.100.35 using port 23.  
`ip.addr == 192.168.100.35 && tcp.port==23` Dieses Filter filtert die Pakete zusätzlich nach dem TCP Port 23.
v) Please write a Wireshark capture filter expression for Q3.4.  
`host 192.168.100.35 and tcp port 23`
vi) Syntax for Wireshark command which collects packets with source or destination IP 192.168.100.35 on interface eth0.  
`wireshark -i eth3 -f "host 192.168.100.35" -k`
vii) Syntax of a display filter which selects the TCP packets with destination IP address 192.168.100.35 and TCP port number 23.  
`ip.dest== 192.168.100.35 && tcp.port==23`


##Exercise 4: Scanning with NMAP:
i) `nmap -sS -O 192.168.100.34` scannt auf der Ip-Adresse nach offenen Ports, indem er TCP SYN Pakete sendet, mit OS Detection, um zu ermitteln, welches Betriebssystem auf der Ip-Adresse läuft.
Nmap schickt dazu zuerst ARP-Requests, um zu sehen, welche Hosts im Netz online sind. Anschließend wird auf die gefundenen Hosts ein Port check durchgeführt, indem ein TCP SYN Paket zu den Ports geschickt wird.  

ii) `nmap -sF 192.168.100.34 -oN outfile10` scannt die Ip Adresse nach offenen Ports, indem er TCP FIN Pakete an alle Ports sendet und der Output wird in die Datei `outfile10` geschrieben. In dieser steht im Unterschied zur `-sS` flag ebenfalls, ob die Ports gefiltert werden.

iii) `nmap -sS 192.168.100.34 -D 192.168.100.33` Diese Option scannt die Ip Adresse nach offenen Ports, indem er TCP SYN Pakete sendet, lässt es allerdings so aussehen, als würde der momentane bestimmte Decoy ebenfalls das Netzwerk scannen. Dadurch ist es schwieriger den eigentlichen Angreifer herauszufinden. 

iv) `nmap -sS -O 192.168.100.32/27` Diese Option scannt mithilfe von TCP SYN Paketen und eingeschalteter OS Detection auf allen Ip-Adressen im Subnetz.   
\includegraphics{NmapScan.png}

v) `nmap -sn -PS 192.168.100.35` Die `-sn` flag, welche die neue Version der `-sP` flag ist, scannt lediglich nach dem Host und nicht nach offenen Ports, mit der `-PS` flag scannt default den Port 80.

vi) `nmap -sn -PS25 192.168.100.35` sollte lediglich auf genannter IP-Adresse auf Port 25 ein TCP SYN schicken.

vii) `nmap -sn -PS80 192.168.100.32/27` sollte an alle Hosts im Subnetz auf Port 80 ein TCP SYN schicken.

viii) `nmap -sn -PS53 192.168.100.32/27`schickt an alle Hosts im Subnetz auf Port 80 ein TCP SYN schicken.

ix) `nmap -sS -v 192.168.100.35` mit der `-sS` flag wird ein TCP SYN an alle Ports geschickt, während mit der `-v` flag zusätzlich noch mehr Informationen auf der Konsole ausgegeben werden.  

x) `nmap -sn -v 192.168.100.35` scannt mit zusätzlichen Informationen, ob der Host erreichbar ist.

##Exercise 5a: TCPDUMP:  
i) Syntax that captures packets containing IP datagrams with source or destination IP address equal to 192.168.100.34.  
`tcpdump host 192.168.100.34 and udp -i eth1` die `-i` flag spezifiziert das interface,   
ii) Please write the syntax of tcpdump command that captures ten packets from the et1 interface.
`tcpdump -c 10 -i eth1`  
iii) Syntax that captures packets containing ICMP messages with source or destination IP address equal to 192.168.100.34.  
`tcpdump host 192.168.100.66 and icmp -i eth1`   
iv) Syntax that captures packets containing IP datagrams between two hosts with IP addresses equal to 192.168.100.34 and 192.168.100.66.   
`tcpdump '((src 192.168.100.66 and dest 192.168.100.34) or (src 192.168.100.34 and dest 192.168.100.66)) and udp' -i eth1`   
v) Syntax for filter expression that captures packets containing TCP segments with source or destination IP address equal to 192.168.100.34.  
`tcpdump host 192.168.100.34 and tcp -i eth1`  
vi) Syntax for filter expression that, in addition to the constraints in Q5.5, only captures packets using port number 23.  
`tcpdump host 192.168.100.34 and tcp port 23 -i eth1`  
vii) Syntax for tcpdump command that collects all ICMP packets with destination IP address 192.168.100.66.  
`tcpdump dest 192.168.100.66 and icmp -i eth1`   
viii) Assume we are about to capture all packets destined to IP address 192.168.100.34 on port 23. Examine the following command explain if it is correct or not: `tcpdump host 192.168.100.34 and dst port 23`, else write down the correct syntax.  
`tcpdump dest 192.168.100.34 and tcp port 23` Der ursprüngliche Befehl ist falsch, das neue filtert nun nur nach Paketen, welche zu der Ip geschickt werden.  
ix) Syntax for tcpcommand that collects all IP packets between host 192.168.100.34 and 192.168.100.34 on interface eth1.  
`tcpdump '((src 192.168.100.66 and dest 192.168.100.34) or (src 192.168.100.34 and dest 192.168.100.66)) and ip' -i eth1`   

##Exercise 5b: TCPDUMP in detail:
Zuerst haben wir den Users clinton10 mit dem Passwort fritz10 auf der Maschine pvssvr10-bln erstellt. Anschließend wird der telnet-service auf pvssvr10-bln mithilfe des Befehls `chkconfig telnet on` gestartet. Als nächstes wird mit Hilfe von Putty von pvsmid10-hh eine Verbindung zu pvssvr10-bln unter der Ip `192.168.100.34` erstellt. Man kann sich nun mit den vorherigen Userdaten als clinton10 anmelden. Nun loggen wir uns mit `exit` wieder aus.  
\includegraphics{PuttyConfiguration.png}
\includegraphics{Clinton10login.png}
Da pvsmid10-hh aus den vorherigen Aufgaben jedoch ein Windows-Rechner ist und wir uns als root einloggen sollen um tcpdump zu starten, wechseln wir zum sniffen nun von pvsmid10-hh auf pvsrou10-1, um die Aufgabe zufriedenstellend bearbeiten zu können.  
Zunächst wird die Verbindung geloggt mithilfe des Befehles `tcpdump -vvv -i -eth4 > pvsrou10-1.dump1`. Anschließend loggen wir uns von pvsmid10-hh als clinton10 in pvssvr10-hh ein.  
In dem Dump-File sind alle Pakete zu sehen, die verschickt wurden, jedoch sind keine Paketinhalte zu sehen.  
Nun führen wir das selbe Vorgehen erneut durch, lediglich mit dem tcpdump-Befehl `tcpdump -A -i eth4 > pvsmid10-hh.dump2`.  
In dem zweiten Dump-File erkennen wir den Nutzernamen `clinton10` und das Passwort, da nun die Paketinhalte als ASCII dargestellt werden.  
Bei dem dritten Befehl `tcpdump -x > pvsmid10-hh.dump3` wird uns der Inhalt der Pakete als Hex angezeigt.  

1) What is the difference in the three tcpdump commands and in their outputs?  
Der Unterschied zwischen `tcpdump -x > pvsmid10-hh.dump3` und `tcpdump -A -i eth4 > pvsmid10-hh.dump2` besteht hauptsächlich darin, dass die `-A` Flag dafür sorgt, dass der Inhalt als ASCII dargestellt wird, was das lesen von Buchstaben oder ganzen Befehlen einfacher macht. Die `-x` Flag jedoch sorgt dafür, dass die Pakete als Hexadezimal dargestellt werden, was es sehr unleserlich macht. `tcpdump -vvv -i eth4 > pvsrou10-1.dump1` hingegen gibt lediglich Informationen über die Pakete an, z.B. von welcher Ip-Adresse sie kommen, welches der Quell- und Zielport ist oder welche Flags gesetzt wurde, folglich Header-Informationen und Meta-Daten. Tatsächliche Dateninhalte werden dafür überhaupt nicht aufgezeichnet.

2) Is it possible to discover "clinton's" password with tcpdump? How would you do this?  
Das Passwort lässt sich schon mit dem vorherigem Befehl `tcpdump -A -i eth4 > pvsmid10-hh.dump` herrausfinden, jedoch ist zu beachten, dass für jeden Buchstaben ein einzelnes Paket geschickt wird. Man kann jedoch durch das `Password:`-Keyword schnell den Anfang des Passworts finden.

3) Can a normal, unprivileged user, run tcpdump?  
Man kann eine Gruppe erstellen, der der unprivilegierte User zugewiesen wird. Anschließend muss man das Ownership der tcpdump Binary auf die Gruppe übertragen, sodass alle innerhalb der Gruppe diese Binary ausführen dürfen.
Nativ ist dies nicht möglich.

##Exercise 6: Using unsecure Telnet and FTP TCP/IP protocol:
Wie zuvor sollen wir mit zwei CentOs arbeiten. Daher nehmen wir pvssvr10-bln und pvscnt110-bln als Systeme.  
Zuerst wird auf pvssvr10-bln mit dem Befehl `chkconfig vsftpd on` und `service vsftpd start` der ftp-Service gestartet. Anschließend führen wir auf dem anderen System `ftp` aus und öffnen mit `open 192.168.100.34` eine Verbindung. Damit dies funktioniert, muss vorher das Security-Enhanced Kernel Module von CentOs mit `setenforce 0` deaktiviert werden, damit auf den Home Ordner von `clinton10` zugegriffen werden kann.  
Nun kann man mit `get pvssvr10-bln.txt` die Datei herunterladen. 
\includegraphics{ftpDateiuebertragung.png}

Die dritte Teilaufgabe sehen wir hier als unnötig an, da wir diese Schritte bereits in der vorherigen Aufgabe ausgeführt haben.


#Part 5: Network Services: Multiple Routing, DNS and Apache

##Exercise 1: Configure the following: Network (figure1) using ifconfig and route add commands:

In Dieser Aufgabe soll ein Firmennetz bestehend aus 3 Subnetzen und 2 Routern Konfiguriert werden.

Zuerst werden alle Vm's erstellt, und mit den vorgegebenen Ip's konfiguriert. 
Firma tamtam:  

        pvssvr10-bln    192.168.100.34/27  
        pvscntl10-bln   192.168.100.35/27  
        pvs-rou10-1     192.168.100.33/27  
        pvs-rou10-1     192.168.100.65/27  
        pvsmid110-hh    192.168.100.66/27  
        pvs-rou10-2     192.168.100.67/27  
        pvs-rou10-2     192.168.100.97/27  
        pvscnt10-hh     192.168.100.98/27  
        pvssvr10-hn     192.168.100.99/27  

Um ein Senden von Paketen von pvsmid10-hh zu allen anderen Rechnern zu ermöglichen, muss eine Routingtabelle angelegt werden, welche die Gateways zu den jeweiligen Subnetzen beinhaltet.  
Dies wird bewerkstelligt mit folgenden Befehlen:   
    `route add -net 192.168.100.32 netmask 255.255.255.224 gw 192.168.100.65`   
    `route add -net 192.168.100.96 netmask 255.255.255.224 gw 192.168.100.67`   

###Routing pvsmid10-hh before:
\includegraphics{pvsmid10-hh-routing-before.png}

###Routing pvsmid10-hh after:
\includegraphics{pvsmid10-hh-routing-after.png}


Um ein Senden von Paketen zwischen den Rechnern des `192.168.100.96/27` Subnetzes und des `192.168.100.32/27` Subnetzes zu ermöglichen, legen wir jeweils einen neuen Eintrag in den Routingtabellen der Router an, welcher jeweils Pakete über den anderen Router leitet.  
Für pvs-rou10-1 bewerkstelligen wir dies mit dem Befehl:  
    `route add -net 192.168.100.96 netmask 255.255.255.224 gw 192.168.100.67 dev eth6`.   
Für pvs-rou10-2 mit dem Befehl:   
    `route add -net 192.168.100.32 netmask 255.255.255.224 gw 192.168.100.65 dev eth5`.  

Im Adressbereich `192.168.100.32` wird als Standard-Gateway der Router `192.168.100.33` und im Adressbereich `192.168.100.96` wird als Standard-Gateway der Router `192.168.100.97` festgelegt.
Dadurch werden alle Pakete, welche sich nicht im eigenem Subnetz sind, automatisch über die Routingtabelle der Router ins andere Subnetz weitergeleitet.

###Routing pvsrou10-1 before:
\includegraphics{pvsrou10-1-routing-before.png}

###Routing pvsrou10-1 after:
\includegraphics{pvsrou10-1-routing-after.png}

Auf den beiden Routern wird als Standard-Gateway `Localhost` eingestellt. Dadurch werden alle Pakete, die nicht für eines der beiden Netzwerke bestimmt sind verworfen.

Das Senden eines Ping Paketes funktioniert in allen Szenarien (Aufgabe a bis f) mit dieser Konfiguration einwandfrei. (Iptables Filterregeln müssen beachtet werden, eventuell modifiziert oder geflusht)

##Exercise 2: Configure the following Network (Figure1) using GUI:

In dieser Aufgabe erstellen wir lediglich mit der grafischen Oberfläche Einträge in der Routingtabelle, welche äquivalent zu den vorherigen Einstellungen sind. Dadurch werden die Einträge persistent im System abgespeichert, während Konfigurationen mittels `ifconfig` und `route` nach dem Neustart des Netzwerk Service verworfen werden. 

##Exercise 3: Install and configure a secure DNS Server using Caching only methods:

1) Die Binaries sind bereits vorinstalliert, dies kann man herausfinden, indem man mit `find -name ` nach den Binaries sucht.
    a) `find -name bind`
    b) `find -name bind-utils`
2) Da Bind bereits installiert  ist erübrigt sich diese Aufgabe.
3) a) `service named enable` aktiviert den Service. `chkconfig named on` startet den Service automatisch.  
    b) Erläuterung zu folgenden Befehlen:    
        i) `cd / && mkdir test && cd /test` erstellt einen neuen Ordner `test` im root-Verzeichnis und betritt diesen danach.   
        ii) `(cd /etc && tar cf - *) | tar xvpf -` Dieser Befehl geht temporär in den `/etc` Ordner und erstellt aus allen Dateien und Unterordnern in `/etc` eine tar-Datei und schreibt diese direkt in die Ausgabe. Diese wird anschließend nach tar geleitet, welches diese Datei im aktuellen Ordner wieder auspackt, während es versucht die ursprünglichen Benutzerrechte wiederherzustellen. Dies ist eine Möglichkeit um Dateien mit den selben Dateiberechtigungen zu kopieren.

4) Die DNS-Sample Datei, die sich nach dem Start des named Servers schon an dem richtigen Ort befindet stellt bereits eine fertige Konfiguration für einen Cache-DNS-Server bereit. Es wird nun der Eintrag `listen on port 53` auf `listen on port 53 {127.0.0.1; 192.168.100.34;};` geändert. Dadurch horcht er auf den genannten Ips unter Port 53 auf DNS Anfragen.  
Der Eintrag `allow-query` wird auf `allow-query {127.0.0.1;192.168.100.32/27;` `192.168.100.64/27;192.168.100.96/27;};` geändert, wodurch nur in unseren Subnetzen einen Query erlaubt wird.  

\lstinputlisting{report5/3/cache-named.conf}

5) Mit `service named restart` wird der Server neu gestartet, die modifizierte Config geladen und mithilfe von `dig @127.0.0.1` kann man nun prüfen, ob der DNS-Server auf dem Localhost läuft.  
Da wir auf unseren virtuellen Maschinen kein Internetzugriff haben, können wir bei keinen uns bekannte Domains oder DNS-Root-Servern anfragen stellen.  

##Exercise 4: Configure a secure Primary DNS Server:
1) pvssvr10-bln soll als Primärer DNS Server Konfiguriert werden  
    a) Die Internal Zone Datei wird wie folgt konfiguriert.  
Wir definieren hier die State of Authority Records und anschließend die einzelnen Subdomains, welche die jeweiligen Ips der Rechner auf ihre Namen zuweist.    

\lstinputlisting{report5/4/pvsTam10.internal}

b) Die named.conf wird durch die folgenden Zeilen erweitert, um eine interne Zone zu definieren und die neu erstellte Zone Datei hinzufügen.

            zone "pvsTam10.internal" {
                type master;
                file "pvsTam10.internal";
            };
\lstinputlisting{report5/4/master-named.conf}
c) Nun kann mit dem Befehl `nslookup pvsmid10-hh.pvsTam10.internal` nachgeschaut werden, ob die Ip für die jeweilige Domain im DNS-Server gespeichert ist.

\includegraphics{report5/4-digtest.png}

d) Um pingen zu können, müssen wir zuerst den momentanen Bind Server `192.168.100.34` auf den Rechnern als DNS Server eintragen. Dies machen wir mithilfe des Netzwerkmanagers. Außerdem wird als Suchdomain die lokale Domain `pvsTam10.internal` hinzugefügt. Dadurch sind wir nun in der Lage die verschiedenen Namen direkt anzupingen ohne den vollen Domainnamen eingeben zu müssen. Dies wird auch auf `pvssvr10-bln.pvsTam10.internal` gemacht.   

2) Die Pings sind alle zufriedenstellend durchgelaufen.
3) Diese Aufgabe ergab für uns keinen Sinn.

##Exercise 5: Configure a secure Secondary DNS Server:

1) pvsmid110-hh soll als Secondary DNS Konfiguriert werden:  
ab) Durch die Einstellungen `type slave;` und `masters {192.168.100.34;};` definieren wir, dass der DNS Server als Slave fungieren und vom Master `192.168.178.34` die Zone Dateien laden soll. Es ist ausserdem wichtig, den Pfad der Zone-Datei auf `slaves/pvsTam10.internal.db` zu setzen, da das Programm in `var/named` scheinbar keine ausreichenden Zugriffsrechte besitzt. 
\lstinputlisting{report5/5/slave-named.conf}
c) In unseren Beispiel haben wir die pvsTam10.internal.db nicht selbst erstellt, sondern sie direkt durch den Secondary vom Primary DNS Server holen lassen.
d)   

\includegraphics{report5/5-digtest.png}

e) Mithilfe des Netzwerkmanagers ändern wir nun den DNS-Server von pvscnt10-hh auf `192.168.100.66`. Jedwege Anfrage von diesem Rechner wird nun von dem Secondary DNS Server beantwortet.  


## Exercise 6: APACHE Configuration and Installation: 

In dieser Aufgabe geht es darum einen Apache Webserver aufzusetzen und zu konfigurieren.  

1) Es sollen folgenden Konfigurationsparameter erläutert werden:
    a) `ServerRoot`: Der ServerRoot ist das oberste Verzeichnis des Servers, in dem Konfiguration-,Log- und Errordateien liegen.
    b) `DocumentRoot`: Der DocumentRoot ist das Verzeichnis in dem alle Webinhalte liegen.
    c) `ServerAdmin`: Dies gibt die Emailadresse des Server Admins/Ansprechpartners an.
    d) `BindAdress`: Mit BindAdress wird definiert, auf welchen Ip-Adressen der Server hören soll.
    e) `Port`: Mit dem Port wird definiert auf welchen Ports er Pakete empfangen soll.
    f) `Listen`: Unter Listen versteht man eine Kombination aus Bind-Adress mit Port vom Format `X.X.X.X:PPPPP`. 
    g) `User`: Mit User ist der User gemeint von dem das Programm gestartet wird.
    h) `Group`: Dies ist die Gruppe in der der Apache Server eingetragen ist.  

2) Es soll herausgefunden werden ob folgende Binaries vorhanden sind:
    1. httpd
    2. openssd
    3. crypto-utilsd
    4. mod_ssd

    Da der Paketmanager yum aufgrund fehlenden Internets nicht funktioniert, haben wir uns mit `find -name Paketname` versichert, dass die Binaries vorhanden sind.  

3) Mit `service httpd status` kann man überprüfen, ob der Server am laufen ist.
4) Wie man den Ordner ändert in dem die Log-Dateien abgespeichert werden:  In der Config-Datei in `/etc/httpd/conf/httpd.conf` können die Einträge `ErrorLog` und `CustomLog` auf einen anderen Ordner eingestellt werden.
5) Zum ändern des DocumentRoot, muss in der  Config der Eintrag `DocumentRoot` auf `/var/www/neuhtml` geändert werden. Ausserdem sollte der Eintrag `Directory "/var/www/html">` auf `Directory "/var/www/neuhtml">` geändert werden.
6) Um das UserDir zu ändern, muss der Eintrag `UserDir` auf `home.html` geändert werden. 
7) Um den Standard Port von 80 auf 4002 zu ändern, wird der Eintrag `Listen` auf `4002` geändert. 
8) Um eine bestimmte Website nur auf 8080 erreichbar zu machen kann man einen Virtuellen Host unter Port 8080 einrichten.

        <VirtualHost *:80>
            DocumentRoot /var/www/html/mysite
            ServerName namedesServers.de
        </VirtualHost>
 
##Exercise 7: Advanced IP based hosting and Access Control:
1) Um die Aufgabe sinnvoll bearbeiten zu können, müssen wir zuerst den aus den vorherigen Aufgaben bestehenden Master DNS Server umkonfigurieren und einen weiteren hinzufügen. Hierzu erstellen wir auf dem pvssvr10-bln Rechner einen Primary DNS Server, welcher die Domain `pvsDNS-10.external` verwaltet.  
Wir haben die in der Aufgabe gestellte Buchstabenendung `hn` versehentlich als `hh` gelesen und dementsprechend angenommen, dass `pvsmid10-hh` zusammen mit `pvscnt10-hh` und `pvssvr10-hh` an einem Ort liegen und daher das interne Netz darstellen. pvsmid10-hh liegt somit bei uns in der DMZ von Hamburg. Die Rechner in Berlin hingegen sind im externen Netz. 
Der Router `pvsrou10-1` ist demzufolge sowohl in der internen als auch in der externen Domain zu erreichen, während `pvsrou10-2` nur über die interne Domain erreichbar ist.

### Firma tamtam
    pvsDNS-10.external
        pvssvr10-bln    -   192.168.100.34
        pvscnt10-bln    -   192.168.100.35
        pvsrou10-1      -   192.168.100.33
        pvsmid10-hh     -   192.168.100.68
    pvsTAM10.internal
        pvssvr10-hh     -   192.168.100.99
        pvscnt10-hh     -   192.168.100.98
        pvsmid10-hh     -   192.168.100.66
        pvsrou10-1      -   192.168.100.65
        pvsrou10-2      -   192.168.100.67
        pvsrou10-2      -   192.168.100.97


### pvsDNS-10 external named.conf:

\lstinputlisting{report5/7/external-named.conf}


Einen weiteren Bind Server erstellen wir auf `pvssvr10-hh` welcher die Domain `pvsTam10.internal` verwaltet.

### pvsDNS-10 internal named.conf:

\lstinputlisting{report5/7/internal-named.conf}


In die Zone-Dateien werden nun jeweils nur die Rechner im eigenen Netz und `pvsmid10-hh` eingetragen. `pvsmid10-hh` ist nun von beiden Domains zu erreichen. Die Suchdomains der jeweiligen Subnetze muss auch auf den neuen DNS Server eingestellt werden. Außerdem werden nur die vom momentanen Netz aus erreichbaren Ips der Router in die Zone files eingetragen. 

### pvsDNS-10 external zone file:

\lstinputlisting{report5/7/Aufgabe-7-pvsDNS-10.external}

### pvsTam-10 internal zone file:

\lstinputlisting{report5/7/Aufgabe-7-pvsTam10.internal}

Damit man trotz allem auf den anderen DNS zugreifen kann, sind beide Master jeweils die Slaves vom anderen DNS Server.
Wir erstellen nun auf pvsmid10-hh zwei Ordner `internal` und `external` im Verzeichnis `var/www/html`, sodass jede Umgebung ihren eigenen abgeschlossenen Ordner besitzt.  
Als nächstes ändern wir die `/etc/httpd/conf/httpd.conf` so, dass wir zwei verschiedenen Umgebungen für zwei unterschiedliche Ips erstellen. In unserem Falle `192.168.100.66` und `192.168.100.68`.
Außerdem muss in der httpd.conf der Parameter `Servername` auf `pvsmid10-hh` gestellt werden.  

2) Einen IP Alias für pvsmid110-hh hinzufügen:  
    Um auf pvsmid10-hh mit beiden Ip Adressen(der internen und der externen) zugreifen zu können, wird im Netzwerkmanager für das eth4 Device ein neuer Eintrag bei den IP-Adressen gemacht, damit nun auch die Ip Adresse `192.168.100.68` benutzt werden kann.
3) Erstellen von zwei Testseiten für den internen und den externen Zugriff:  
    Wir erstellen nun zwei neue Index HTML Dateien, in den Ordnern `/var/www/html/internal/` und `/var/www/html/external/`, die jeweils aussagen, ob über die internal oder die external Domain zugegriffen wurde. Dazu fügen wir den folgenden Codeausschnitt an die httpd.conf an. 

        <VirtualHost 192.168.100.66:80>
            DocumentRoot /var/www/html/internal
            ServerName pvsmid10-hh.pvsTam10.internal
        </VirtualHost>
        <VirtualHost 192.168.100.68:80>
            DocumentRoot /var/www/html/external
            ServerName pvsmid10-hh.pvsDNS-10.external
        </VirtualHost>

4) Wir können nun von jedem Rechner mit der jeweiligen Domain auf die unterschiedlichen HTML-Files von pvsmid10-hh zugreifen.  

###Pvscnt10-bln external domain access:
\includegraphics{pvscnt10-bln-external-domain.png}

###Pvscnt10-bln external access without domain specification:
\includegraphics{pvscnt10-bln-external.png}

###Pvscnt10-hh internal domain access:
\includegraphics{pvscnt10-bln-internal.png}

###Pvscnt10-hh internal access without domain specification:
\includegraphics{pvscnt10-hh-internal.png}

5) In dieser Aufgabe sollen zwei Ordner auf dem Webserver erstellt werden. Einer dieser Ordner soll nur als `testuser` erreichbar sein und der andere als Mitglied der Gruppe `testusers`. Der Überordner soll von jedem User erreichbar sein.  
    Hierzu erstellen wir die Ordner `user` und `group`:  
    `cd /var/www/html/external/`  
    `mkdir user`  
    `mkdir gorup`  
    Daraufhin erstellen wir den User `testuser` mit folgendem Befehl:  
    `htpasswd -c /usr/local/apache/passwd/passwords testuser`  
    Für die Gruppe `testgroup` erstellen wir die Datei `/usr/local/apache/passwd/groups` mit folgendem Inhalt:  
    `testgroup: testuser`  
    In die httpd.conf muss folgendes eingetragen werden:

        <Directory "/var/www/html/external/user">
            AuthType Basic
            AuthName "User Files"
            AuthBasicProvider file
            AuthUserFile /usr/local/apache/passwd/passwords
            Require user testuser 
        </Directory>

        <Directory "/var/www/html/external/group">
            AuthType Basic
            AuthName "Group Files"
            AuthBasicProvider file
            AuthUserFile /usr/local/apache/passwd/passwords
            AuthGroupFile /usr/local/apache/passwd/groups
            Require group testgroup 
        </Directory>



##Exercise 8: Install and configure a web server with openssl
1) Finde und lösche den öffentlichen Key ssl.crt und den privaten Key ssl.key:  
    Die Keys liegen in `/etc/httpd/conf`.      
    `cd /etc/httpd/conf/`  
    `rm ssl.crt ssl.key`
2) Generieren eines privaten Schlüssels:  
    `openssl genrsa -out ssl.key` erstellt den private Key.  
    Für zusätzliche Sicherheit sollte man noch die Schlüssellänge mit angeben (mind. 2048) und mit dem Parameter `-des3` den privaten Schlüssel selbst nochmal mit einem Passwort verschlüsseln.
3) Generieren des öffentlichen Schlüssels:  
    `openssl rsa -in ssl.key -pubout > ssl.public` erstellt den public Key `ssl.public`.
4) Wie man herausfindet ob eine Anwendung auf Port 443 läuft:  
    `netstat -tlp` zeigt alle offenen Ports und deren Prozess.
5) Da wir in Aufgabe 8.3 kein Zertifikat, sondern nur den Public Key erstellt haben, können wir die https Konfiguration noch nicht testen, die Erstellung des Zertifikates folgt in der nächsten Aufgabe. Beim Aufrufen des Webservers über https schlägt somit die Verbindung fehl.


##Exercise 9: Install  and configure a web server with openssl:
1) Generieren eines Encryption Keys:  
    Der Encryption Key (private Key) wurde in der vorherigen Aufgaben schon mit RSA generiert. Dieser wird verwendet um das Premaster-Secret zu entschlüsseln, welches, mit dem im Zertifikat enthaltenen öffentlichen Schlüssel, vom Client verschlüsselt wurde. Aus dem Premaster-Secret wird der eigentliche Schlüssel für die Datenverschlüsselung generiert. Der private Schlüssel kann aber auch verwendet werden um den Key Exchange (z.B Diffie Hellman) zu authentifizieren. 
2) Ändern der Zugriffsrechte des privaten Schlüssels:  
    `chmod 400 ssl.key` gibt lediglich dem Root Leserechte. Dies macht aber nur Sinn , solange der httpd Server als root ausgeführt wird. Den httpd Server als root auszuführen ist jedoch aus sicherheitstechnischer Sicht nicht zu empfehlen.
3) Erstellen einer Authentication-Certificate-Request Datei:  
    `openssl req -new -key ssl.key -out ssl.crt` 
    Diese kann anschließend von einer CA oder selbst signiert werden.
4) Signieren des erstellen Zertifikates:  
    `openssl x509 -req -days 365 -in ssl.crt -signkey ssl.key -out ssl.crt` Der Parameter `-days` gibt an wie lange das Zertifikat gültig ist.  
5) Erstellen einer index.html Datei mit folgendem Inhalt:  

        <html>
        <body>TKRNTEST with openssl </body>
        </html>

    Die HTTP Datei legen wir in `/etc/httpd` ab. Nur dort wird sie später eingelesen.
6) Damit der Key nun benutzt wird und, fügen wir folgenden Code in die httpd.conf hinzu:     

        <VirtualHost *.443> 
           SSLEngine on 
           SSLCertificateKeyFile "/etc/httpd/conf/ssl.key"
           SSLCertificateFile "/etc/httpd/conf/ssl.crt"
        </Virtualhost>

7) Webserver starten:  
    `service httpd start`

8)    


\includegraphics{pvssvr10-hh-nach-pvsmid-openssl-test.png}


#Part 6: Firewall

##Exercise 1: Setting iptables on pvsfw10-1

Um die Aufgabe bearbeiten zu können, erstellen wir zuerst aus den bereits vorhandenen VMs das neue vorgegebene Netz. Hierzu werden die Hostnamen der jeweiligen Rechner geändert und die bisherigen Routingregeln gelöscht. 

    pvssvr10-bln        192.168.100.194/27  
    pvsfw10-1           192.168.100.193/27  
    pvssvr10-hh         192.168.100.162/27  
    pvsfw10-2           192.168.100.163/27  
    pvssvr10-hn         192.168.100.130/27  

In Dieser Aufgabe geht es dadrum die iptables Befehle und deren Auswirkungen kennen zu lernen.  

a) Befehl um zu sehen ob bereits irgendwelche Regeln existieren:  
    `iptables -L nat`, `iptables -L mangle`, `iptables -L` Es sind momentan noch keine Regeln gesetzt.  
\includegraphics{iptables-L.png}  
a) Löschen aller Regeln, falls welche vorhanden wären:  
    `iptables -F` 
a) Eine Regel erstellen um alle eingehenden ICMP Pakete auf pvsfw10-1 zu blockieren:  
    `iptables -A INPUT -p icmp -j DROP` 
a) Testen der Regel mit einem Echo-Request von pvssvr10-hh:  
    Dieser Echo-Request wird nicht beantwortet, da die Pakete nicht durchkommen.
a) Einen Echo-Request von pvsfw10-1 nach pvssvr10-hh senden:  
    `pvsfw10-1` sendet zwar den Request, allerdings wird der gesendete Reply gefiltert.
a) Die zuvor gesetzte Regel wieder löschen:  
    `iptables -D INPUT 1` löscht hier die erste Regel in der INPUT Tabelle.
    `iptables -D INPUT -p icmp -j DROP` würde in diesem Fall das selbe tun.  
a) Blocken aller ausgehenden ICMP Pakete auf pvsfw10-1:  
    `iptables -A OUTPUT -p icmp -j DROP` 
a) Testen der Regel mit einem Echo-Request von pvssvr10-hh:  
    Hier kommt zwar der Request durch, jedoch wird der Reply von der Firewall geblockt.
a) Die zuvor gesetzte Regel wieder löschen:  
    `iptables -D OUTPUT -p icmp -j DROP` 
a) Erstellen einer Regel um alle ICMP Pakete in der Forward Chain auf pvsfw10-1 zu blockieren:  
    `iptables -I FORWARD -p icmp -j DROP`
a) Einen Echo-Request von pvssvr10-hh nach pvssvr10-hn senden:  
    Die Server können sich nicht gegenseitig erreichen, da die Pakete nicht mehr von der Firwall geforwarded werden.
a) Flushen aller Regeln:  
    `iptables -F`  
    Eine Regel auf pvsfw10-1 erstellen die alle TCP Pakete, die an Port 22 adressiert sind blockiert:  
    `iptables -A INPUT -p tcp -j DROP --dport 22`  
    Der Versuch sich mittels ssh von pvssvr10-hn auf pvsfw10-1 einzuloggen:  
    Es passiert nichts, wir sehen keine Benachrichtigung und werden nicht benachrichtigt. Nach einer gewissen Zeit erhalten wir einen Connection timeout. 
a) Flushen aller Regeln:  
    `iptables -F` 
    Eine Regel auf pvsfw10-1 erstellen die alle TCP Pakete, die an Port 22 adressiert sind zurückweist:  
    `iptables -A INPUT -p tcp -j REJECT --dport 22`  
    Der Versuch sich mittels ssh von pvssvr10-hn auf pvsfw10-1 einzuloggen:  
    Wir bekommen direkt eine Benachrichtigung `connection refused`. 
    Der Unterschied zur vorherigen Aufgabe ist, dass die Firewall mit einer Meldung, dass dieser Port nicht erreichbar ist antwortet, anstatt die Pakete nur zu verwerfen.
a) Sich die aktuellen Regeln anzeigen lassen:  
    `iptables -L` 
a) Ändere die Regel von Aufgabe j), so dass mit einem TCP-Reset geantwortet wird anstelle einer ICMP Message:  
    `iptables -A FORWARD -p icmp -j REJECT --reject-with tcp-reset`  
    Diese Aufgabe macht so keinen Sinn, da man keine icmp Pakete mit einem TCP-Reset beantworten kann. Wahrscheinlich meint die Aufgabenstellung Aufgabe l) statt j):  
    `iptables -A FORWARD -p tcp --dport 22 -j REJECT --reject-with tcp-reset`  
a) Benutze einen Befehl um die Forward-Pakete auf dem pvsfw10-1 zu setzen:  
    Was mit dieser Aufgabe gemeint war konnten wir beim besten Willen nicht herausfinden.
    Die einzige Lösung die etwas Sinn machen würde wäre diese:  
    `iptables -t nat -A PREROUTING  -j REDIRECT -d 127.0.0.1`  
    Hier werden alle Pakete von pvsfw10-1 direkt angenommen anstatt weitergeleitet zu werden, indem die Ziel Adresse auf Localhost gesetzt wird.

##Exercise 2: Setting iptables on pvssvr10-hh

In Dieser Aufgabe werden die Regeln im Gegensatz zur vorherigen Aufgabe auf pvssvr10-hh angewendet.

a) Lehne alle einkommenden ICMP Pakete ab und Logge diesen Vorgang:  
    `iptables -A INPUT -p icmp -j LOG` Mit diesem Befehl werden alle Header der INPUT icmp Pakete gesichert.  
    `iptables -A INPUT -p icmp -j DROP` Durch diesen Befehl werden alle INPUT icmp Pakete gedropped.
a) Testen der Regel mit einem Echo-Request von pvssvr10-hn nach pvssvr10-hh:  
    Das pingen funktioniert nicht, wir bekommen lediglich ein `Connection Timout`. Das Log hingegen können wir uns mit `/var/log/messages` ansehen. Dort sind die Pings gelistet.   
\includegraphics{pvssvr10-hh-logs.png}
a) Lehne einkommende FTP Pakete ab:  
    `iptables -A INPUT -p tcp --dport ftp -j DROP`
a) Lehne einkommende DNS Pakete ab:  
    `iptables -A INPUT -p udp --dport domain -j DROP`
a) Lehne einkommende Telnet Pakete ab:  
    `iptables -A INPUT -p tcp --dport telnet -j DROP`
a) Lehne einkommende SMTP und POP3 Pakete ab:  
    `iptables -A INPUT -p tcp --dport smtp -j DROP`  
    `iptables -A INPUT -p tcp --dport pop3 -j DROP` 
a) Der Befehl um die Filter Regeln zu speicher:  
    `iptables-save > iptables.save` sichert die momentane Konfiguration in `iptables.save` ab.
a) Wiederherstellen der Filter Regeln:  
    `iptables-restore iptables.save`
a) Erstelle eine Policy um den kompletten einkommenden Traffic zu verwerfen:  
    `iptables -P INPUT DROP`   
    Erlaube nur SSH Verbindungen:  
    `iptables -A INPUT -p tcp --dport ssh -j ACCEPT`
a) Logge alle Verbindungsversuche nach pvssvr10-hh:  
    `iptables -A INPUT -j LOG`
a) Erstelle aus der Regel aus Aufgabe d) eine ausführbare Datei:  
Wir erstellen die Datei `pvssvr10-hh.txt` und fügen dort den vorherigen Befehl hinein. Als nächstes machen wir sie mit `chmod 777 pvssvr10-hh.txt` ausführbar und starten sie mit `./pvssvr10-hh.txt`. Die Regel wird nun hinzugefügt. 


##Exercise 3: Advanced iptables commands

a) Die iptables Befehle für pvsfw10-1 um nur FTP Traffic von pvssvr10-hh ins Subnetz 192.168.100.128 zu erlauben:  
    `iptables -P FORWARD DROP`  
    `iptables -A FORWARD -p tcp --dport ftp -s 192.168.100.162 -d 192.168.100.128/27 -j ACCEPT`  
    `iptables -A FORWARD -p tcp --sport ftp -d 192.168.100.162 -s 192.168.100.128/27 -j ACCEPT`  
    Testen einer FTP Verbindung:  
\includegraphics{pvssvr10-hh-ftp.png}  

a) Logge alle SSH-Verbindungen von 192.168.100.128/27 nach 192.168.100.192/27:  
    `iptables -A FORWARD -p tcp --dport ssh -s 192.168.100.128/27 -d 192.168.100.192/27 -j LOG`  
\includegraphics{pvssvr10-hh-logs.png}  
a) iptables Befehle, die auf pvsfw10-1 nur DNS Anfragen von Computern des Subnetzes 192.168.100.192/27 an den Server pvssvr10-hh  erlauben:  
    `iptables -P FORWARD DROP`  
    `iptables -A FORWARD -p udp --dport domain -s 192.168.100.192/27 -d 192.168.100.130 -j ACCEPT`  
    Es werden alle dns Pakete von 192 Subnetz mit der Bestimmungsadresse `192.168.100.130` zugelassen.   
    `iptables -A FORWARD -p udp --sport domain -d 192.168.100.192/27 -s 192.168.100.130 -j ACCEPT`  
    Es muss natürlich umgekehrt auch ein Reply vom DNS Master zu den Clients erlaubt werden.
a) Erlaube Verkehr auf dem Loopback Interface:  
    `iptables -A INPUT -i lo -j ACCEPT` erlaubt eingehenden Traffic auf dem lo Interface.  
    `iptables -A INPUT -i lo -j OUTPUT` erlaubt ausgehenden Traffic auf dem lo Interface.
a) Füge ein Regel hinzu um unlimitierten Verkehr über das Interface eth7 zu erlauben:  
    `iptables -A INPUT -i eth7 -j ACCEPT` Erlaubt unlimitierten eingehenden Traffic.  
    `iptables -A OUTPUT -o eth7 -j ACCEPT` Erlaubt unlimitierten ausgehenden Traffic. 
a) Sichere das externe Interface(eth5) von pvsfw10-2 vor dem Empfangen und versenden von Paketen mit IP Adressen, die gespooft sein könnten:  
    i) Die Reservierten Klassen A,B und C:  
    `iptables -A FORWARD -o eth5 -s 10.0.0.0/8 -j DROP`  
    `iptables -A FORWARD -i eth5 -s 10.0.0.0/8 -j DROP`  
    `iptables -A FORWARD -o eth5 -s 172.16.0.0/12 -j DROP`  
    `iptables -A FORWARD -i eth5 -s 172.16.0.0/12 -j DROP`  
    `iptables -A FORWARD -o eth5 -s 192.168.100.0/24 -j ACCEPT`  
    `iptables -A FORWARD -i eth5 -s 192.168.100.0/24 -j ACCEPT`  
    `iptables -A FORWARD -o eth5 -s 192.168.0.0/16 -j DROP`  
    `iptables -A FORWARD -i eth5 -s 192.168.0.0/16 -j DROP`
    ii) Die Loopback Adressen:  
    `iptables -A FORWARD -o eth5 -s 127.0.0.0/8 -j DROP`
    `iptables -A FORWARD -i eth5 -s 127.0.0.0/8 -j DROP`
    iii) Malformed Broadcast Addressen:  
    `iptables -A INPUT -o eth5 -s 0.0.0.0 -j DROP`  
    `iptables -A INPUT -i eth5 -s 0.0.0.0 -j DROP`  
    `iptables -A INPUT -o eth5 -d 255.255.255.255 -j DROP` 
    `iptables -A INPUT -i eth5 -d 255.255.255.255 -j DROP`
a) Erlaube eingehende und ausgehende ICMP Pakete von pvssvr10-hn nach pvssvr10-hh:  
    `iptables -A FORWARD -p icmp -s 192.168.100.162 -d 192.168.100.130 -j ACCEPT`  
    `iptables -A FORWARD -p icmp -d 192.168.100.162 -s 192.168.100.130 -j ACCEPT`  
    Diese Befehle werden auf pvsfw10-1 ausgeführt.   
a) Erlaube ausgehende TCP und UDP Verbindungen auf dem interface eth2 von pvsfw10-2:  
    `iptables -A OUTPUT -p tcp -o eth2` Erlaubt ausgehende tcp Pakete.  
    `iptables -A OUTPUT -p udp -o eth2` Erlaubt ausgehende udp Pakete.   


#Part 7: VPN

##Exercise 1: Set up a host-to-host VPN using preshared keys

In Dieser Aufgabe geht es darum ein host-to-host VPN mit einem preshared key zu konfigurieren. 

Aufgaben a) und b) sind überflüssig, da OPENS/WAN schon installiert ist.

c) Der Befehl um OPENS/WAN zu starten:  
    `service ipsec start` oder `ipsec setup start`
d) Der Befehl um OPENS/WAN zu stoppen:  
    `service ipsec stop` oder `ipsec setup stop` 
e) Der Befehl um zu überprüfen ob OPENS/WAN ordnungsgemäß installiert ist:  
    `ipsec verify`
f) Der Befehl um den öffentlichen Schlüssel anzuzeigen, falls pvssvr10-bln der local Host und pvscnt10-hn der remote Host ist:  
    `ipsec showhostkey --txt 192.168.100.130` gibt den public key des remote Hosts. 
g)     
a) In dieser Aufgabe soll eine Telnet Verbindung von pvssvr10-bln nach pvscnt10-hn mittels tcpdump aufgezeichnet werden.  
Dazu erstellen wir zu erst auf beiden Rechnern den User `Clinton` mit dem Passwort `Obama$$barrack` mit dem Befehl `useradd Clinton`  und `passwd Clinton`.  
Aufzeichnen der Telnet Pakete:  
`tcpdump -i eth4 'tcp port 23' -A > pvssvr10-bln1.txt`
Aufzeichnung pvssvr10-bln1.txt ist in der dumps.tar.gz
b) Aufzeichnen der FTP Pakete:  
`tcpdump -i eth4 'tcp port 21' -A > pvssvr10-bln2.txt` 
Aufzeichnung pvssvr10-bln2.tx ist in der dumps.tar.gz
c) Aufbauen einer getunnelten IPSec Verbindung mit einem 256 Preshared Secret:  
Um zu garantieren, dass `ipsec verify` keine Fehler aufzeigt, muss zuerst das Kernelmodule von ipsec geladen werden mit dem Befehl `chkconfig ipsec on`. Anschliessend muss ip forwarding aktiviert und alle Arten von redirects deaktiviert werden. Dies wird erreicht, indem in der `/etc/sysctl.conf` folgende Zeilen geändert/hinzugefügt werden.

            net.ipv4.ip_forward = 1  
            net.ipv4.conf.all.send_redirects = 0  
            net.ipv4.conf.all.accept_redirects = 0  
            net.ipv4.conf.default.send_redirects = 0  
            net.ipv4.conf.default.accept_redirects = 0  
Der Key wird mit `openssl rand -hex 16` erstellt und anschliessend folgendermaßen in die Config eingefügt:
\lstinputlisting{./report7/7-1/psk.secrets}
Die Konfiguration von Ipsec wird wie folgt festgelegt:
\lstinputlisting{./report7/7-1/psk.conf}
Mit `ipsec auto --add psk` wird die Verbindung hinzugefügt und anschliessend mit `ipsec auto --up psk` gestartet.  
1)  Aufzeichnen des Pings mittels `tcpdump -c 6 host pvssvr10-bln > pvssvr10-bln3.txt` zwischen pvssvr10-bln und pvscnt10-hn:
\lstinputlisting{./report7/pvssvr10-bln3.txt}
2) Aufzeichnen einer Telnet-Verbindung zwischen pvssvr10-bln und pvscnt10-hn mittels `tcpdump -c 6 host pvssvr10-bln > pvssvr10-bln4.txt`:  
\lstinputlisting{report7/pvssvr10-bln4.txt}
3) Aufzeichnen einer FTP- Verbindung zwischen pvssvr10-bln und pvscnt10-hn mittles `tcpdump -c 6 host pvssvr10-bln > pvssvr10-bln5.txt`:  
\lstinputlisting{report7/pvssvr10-bln5.txt}

h) In Dieser Aufgabe sollen Konfigurationsdateien und aktuelle Einstellungen abgespeichert werden:

### ipsec_ifconfig.dump
    `ifconfig > ipsec_ifconfig.dump`
\lstinputlisting{./report7/7-1/ipsec_ifconfig.dump}

### ipsec_look.dump
    `ipsec look > ipsec_look.dump`
\lstinputlisting{./report7/7-1/ipsec_look.dump}

### ipsec_route.dump
    `route -n > ipsec_route.dump`
\lstinputlisting{./report7/7-1/ipsec_route.dump}


### ipsec.secrets
\lstinputlisting{./report7/7-1/ipsec.secrets}

### ipsec.conf
\lstinputlisting{./report7/7-1/ipsec.conf}

##Exercise 2: Set up a host-to-host VPN using RSA keys

In Dieser Aufgabe geht es darum ein host-to-host VPN mit einem RSA key zu konfigurieren. 

a) Mit Wireshark sollen nun http Pakete zwischen pvssvr10-bln und pvscnt10-hn mit geschnitten werden, bevor der VPN Tunnel aufgebaut wurde. Dazu starten wir Apache und rufen den Webserver von dem anderen Rechner im Webbrowser auf.  
Die Wireshark Logs sind in dump.tar.gz zu finden.

b) In dieser Aufgabe wiederholen wir den Vorgang wie in Aufgabe a), nur dass zuvor der VPN Tunnel, wie in der nachfolgenden Aufgabe beschrieben aufgebaut wurde.  
Die Wireshark Logs sind in dump.tar.gz zu finden.


### VPN-Setup
c) Folgenderweise wird der RSA Key erstellt und in die Konfiguration eingebunden:  

`ipsec newhostkey --configdir /etc/ipsec.d --output /etc/ipsec.d/rsa.secrets` erstellt die RSA Keys.  
`ipsec showhostkey --file rsa.secrets --left` gibt den linken RSA Key aus, sodass wir ihn in die rsa.conf schreiben können.  
`ipsec showhostkey --file rsa.secrets --right` gibt den rechten RSA Key aus, sodass wir ihn in die rsa.conf schreiben können.  

Die angeforderte ipsec.conf und ipsec.secrets hat sich zur vorigen Aufgabe nicht verändert, daher gehen wir davon aus, dass eigentlich die rsa.conf und die rsa.secrets gemeint war. Falls nicht, sind die Dateien in der vorherigen Aufgabe einzusehen.


### rsa.conf
\lstinputlisting{./report7/7-2/rsa.conf}

### rsa.secrets
\lstinputlisting{./report7/7-2/rsa.secrets}

### ipsec_ifconfig.dump
\lstinputlisting{./report7/7-2/ipsec_ifconfig.dump}

### ipsec_look.dump
\lstinputlisting{./report7/7-2/ipsec_look.dump}

### ipsec_route.dump
\lstinputlisting{./report7/7-2/ipsec_route.dump}

#Part 8: Network Services gpg ssh-forward

##Excercise 1A: Using Md5Sum

1) Erstellen einer Sequenz von 1 bis 20 in der pvssvr10-bln.txt Datei mit dem seq Befehl:  
`seq 1 20 > pvssvr10-bln.txt`  

2) Verifiziere den Dateitypen der Datei pvssvr10-bln.txt mit dem Befehl file:   
`file pvssvr10-bln.txt`  
Ausgabe: `pvssvr10-bln.txt: ASCII text`  
mit `-i` Paramaeter: `pvssvr10-bln.txt: text/plain; charset=us-ascii`  

3) Erstelle md5 Checksumme der Datei pvscnt10-bln.txt  
`md5sum pvscnt10-bln.txt`  
Ausgabe: `69d61ec73a9426dba64bf17888794b6e  pvssvr10-bln.txt`  

4)  Erstelle die Datei pvscnt10-hn.txt.  
`touch pvscnt10-hn.txt`  
Kopiere die md5 Checksumme der Datei in die Datei pvscnt10-hn-test.txt.  
`md5sum pvscnt10-hn.txt > pvscnt10-hn-test.txt`  
Teste die md5 Checksumme.  
`md5sum -c pvscnt10-hn-test.txt`  
Ausgabe: `pvscnt10-hn.txt: OK`

5) Benutze den Befehl diff um die zwei Dateien zu vergleichen.  
`diff pvscnt10-hn.txt    pvscnt10-hn-test.txt`  
Ausgabe: `0a1  
> d41d8cd98f00b204e9800998ecf8427e  pvscnt10-hn.txt`  

6) Downloade eine beliebige Datei zusammen mit deren md5 Checksumme und Verifiziere die Datei. Fuer diese Aufgabe haben wir die Bootstrap x86_64 Version von Arch Linux vom Mirror `http://mirror.aarnet.edu.au/pub/archlinux/iso/2014.08.01/` heruntergeladen.

            6db373f210d0036b00ad60f57c1759d0  archlinux-2014.08.01-dual.iso
            16fd730f50ce523d5298cc56dc105dc1  archlinux-bootstrap-2014.08.01-i686.tar.gz
            47bf49d5599bb320cea3ce1ef7c8d86c  archlinux-bootstrap-2014.08.01-x86_64.tar.gz

Die beiliegenden md5sums list wird ebenfalls heruntergeladen.  
Mit dem Befehl `md5sum -c md5sum.txt` wird nun fuer alle Dateien, welche in der md5sum Liste definiert sind ueberprueft, ob die selbst erstellte md5sum der Datei mit der des Erstellers uebereinstimmt.  

\lstinputlisting{./report8/output.txt}  

Die beiden Dateien, welche nicht von uns heruntergeladen wurde, werden natuerlich nicht gefunden, die heruntergeladene Datei jedoch besteht den Test und wird als korrekt gekennzeichnet.

##Excercise 1B: Using Sha1Sum

7) Erstellen einer Sequenz von 1 bis 20 in der pvssvr10-bln-2.txt Datei mit dem seq Befehl:  
`seq 1 20 > pvssvr10-bln-2.txt`  

8) Verifiziere den Dateitypen der Datei pvssvr10-bln-2.txt mit dem Befehl file:   
`file pvssvr10-bln-2.txt`  
Ausgabe: `pvssvr10-bln-2.txt: ASCII text`  
mit `-i` Paramaeter: `pvssvr10-bln-2.txt: text/plain; charset=us-ascii`  

9) Erstelle sha1 Checksumme der Datei pvscnt10-bln-2.txt  
`sha1sum pvscnt10-bln-2.txt`  
Ausgabe: `f1d841b541f97300572926c4a47f121542b52a6a  pvssvr10-bln-2.txt`  

10)  Erstelle die Datei pvscnt10-hn-2.txt.  
`touch pvscnt10-hn-2.txt`  
Kopiere die sha1 Checksumme der Datei in die Datei pvscnt10-hn-2-test.txt.  
`sha1sum pvscnt10-hn-2.txt > pvscnt10-hn-2-test.txt`  
Teste die sha1 Checksumme.  
`sha1sum -c pvscnt10-hn-2-test.txt`  
Ausgabe: `pvscnt10-hn-2.txt: OK`


##Excercise 1C: Using Sha256Sum

11) Erstellen einer Sequenz von 1 bis 20 in der pvssvr10-bln-3.txt Datei mit dem seq Befehl:  
`seq 1 20 > pvssvr10-bln-3.txt`  

12) Verifiziere den Dateitypen der Datei pvssvr10-bln-3.txt mit dem Befehl file:   
`file pvssvr10-bln-3.txt`  
Ausgabe: `pvssvr10-bln-3.txt: ASCII text`  
mit `-i` Paramaeter: `pvssvr10-bln-3.txt: text/plain; charset=us-ascii`  

13) Erstelle sha256 Checksumme der Datei pvscnt10-bln-3.txt  
`sha256sum pvscnt10-bln-3.txt`  
Ausgabe: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  pvssvr10-bln-3.txt`  

14)  Erstelle die Datei pvscnt10-hn-3.txt.  
`touch pvscnt10-hn-3.txt`  
Kopiere die sha256 Checksumme der Datei in die Datei pvscnt10-hn-3-test.txt.  
`sha256sum pvscnt10-hn-3.txt > pvscnt10-hn-3-test.txt`  
Teste die sha256Checksumme.  
`sha256sum -c pvscnt10-hn-3-test.txt`  
Ausgabe: `pvscnt10-hn-3.txt: OK`



##Excercise 1D: Using Sha512Sum

15) Erstellen einer Sequenz von 1 bis 20 in der pvssvr10-bln-4.txt Datei mit dem seq Befehl:  
`seq 1 20 > pvssvr10-bln-4.txt`  

16) Verifiziere den Dateitypen der Datei pvssvr10-bln-4.txt mit dem Befehl file:   
`file pvssvr10-bln-4.txt`  
Ausgabe: `pvssvr10-bln-4.txt: ASCII text`  
mit `-i` Paramaeter: `pvssvr10-bln-4.txt: text/plain; charset=us-ascii`  

17) Erstelle sha512 Checksumme der Datei pvscnt10-bln-4.txt  
`sha1sum pvscnt10-bln-4.txt`  
Ausgabe: `cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e  pvssvr10-bln-4.txt`  

18)  Erstelle die Datei pvscnt10-hn-4.txt.  
`touch pvscnt10-hn-4.txt`  
Kopiere die sha512 Checksumme der Datei in die Datei pvscnt10-hn-4-test.txt.  
`sha512sum pvscnt10-hn-4.txt > pvscnt10-hn-4-test.txt`  
Teste die sha512 Checksumme.  
`sha512sum -c pvscnt10-hn-4-test.txt`  
Ausgabe: `pvscnt10-hn-4.txt: OK`

##Excercise 2A: Using GNU Privacy Gurad (GPG)

1) Finde das Programm pgp auf dem Rechner pvssvr10-bln:
    `find /usr/ -name gpg`
    Ausgabe: `/usr/bin/gpg`

2) Beschreibe die Bedeutung der folgenden Befehle:
1. `gpg --help | grep gen`  
Ruft den Hilfe Dialog von gpg auf und sucht nach der Zeichenkette `gen`. Ist hilfreich um nach dem Parameter für das Generieren eines Keys zu suchen.
2. `gpg --list-keys`  
Listet alle öffentlichen Schlüssel auf, die im GPG-Schlüsselbund gespeichert sind
3. `gpg --gen-key`  
Generiert öffentlichen Schlüssel. Man wird durch ein Menü geführt, in dem man Schlüsselalgorithmus, Schlüsselänge, Gültigkeitsdauer, User-ID, Emailadresse und Passphrase angeben muss.
4. `ls -l ~/.gnupg`   
Zeigt die gpg Dateien des Users an, darunter sind:  
gpg.conf Konfigurationsdatei von gpg.  
pubring.gpg Schlüsselbund für öffentliche Schlüssel.  
secring.gpg Schlüsselbund für private Schlüssel.  
trustdb.gpg Datenbank für WebofTrust Signaturen.  
5. `gpg --gen-revoke omega@pvssvr10-bln`  
Erzeugen eines Widerrufszertifikat für den Schlüssel mit der UserID omega@pvssvr10-bln. Dabei kann ein Grund für das Widerrufen angegeben werden.
6. `gpg --output revoke.asc -gen-revoke omega@pvssvr10-bln`  
Speichert das Widerrufszertifikat als revoke.asc.
7. `gpg --fingerprint`  
Listet alle öffentlichen Schlüssel einschließlich deren digitalen Fingerabdrücke auf.
8. `gpg --list-secret-key`  
Listet alle privaten Schlüssel auf.
9. `gpg --list-pullic-key`  
Listet alle öffentlichen Schlüssel auf.
10. `gpg --list-sigs`  
Listet zusätzlich zu den öffentlichen Schlüsseln  auch die Signaturen auf.
11. `$echo "no Security-warning" >> ~/.gnupg/gpg.conf`  
Schreibt die Zeichenkette `no Security-warning` in die gpg Konfigurationsdatei. Da der Konfigurationsparameter unbekannt/falsch ist wird bei der Benutzung von gpg ein Fehler ausgegeben.

3) Erstelle ein Schlüsselpaar auf dem pvssvr10-bln mit dem DSA und ELGamal Algorithmus.  
`gpg --gen-key`  
Auswahl:
1. DSA und Elgamal
2. Name: steinmeyer
3. Emailadresse: steinmeyer@pvssvr10-bln
4. Passphrase: 123456

4) Exportiere den öffentlichen Schlüssel in die Datei binäre Steinmeyer.gpg  
`gpg --output Steinmeyer.gpg --export steinmeyer`  
Schicke die Datei zum Rechner pvscnt10-hn mittels scp:  
`scp Steinmeyer.pgp root@192.168.100.130:`  

5) Exportiere den öffentlichen Schlüssel in die ASCII Datei Steinmeyer.asc:  
` gpg --output Steinmeyer.asc --export --armor steinmeyer`  

##Excercise 2B: Daten Ver- und Entschlüsselung

6) Kopiere die Datei /etc/passwd von dem Rechner pvssvr10-bln in das Home Verzeichnis.  
`cp /etc/passwd ~/passwd.txt`

7) Verschlüssle die Datei passwd im Standard binären gpg Format:  
`gpg -r steinmeyer -e passwd.txt`

8) Bestimme den Dateitypen:  
`file passwd.txt.gpg`  
Ausgabe: `passwd.txt.gpg: data`  
Versuche die Datei zu lesen:  
`cat passwd.txt.gpg`  
Ergebnis: Da die Datei verschlüsselt und binär abgespeichert ist lässt sich die Datei nicht lesen.

9) Entschlüssle die Datei passwd.txt.pgp und schreibe den Inhalt in passwd2-raw.txt:  
`gpg --output passwd2-raw.txt -d passwd.txt.gpg`

10) Verschlüssle die Datei passwd.txt im ASCII Format:  
`gpg -r steinmeyer -e --armor passwd.txt`

11) Bestimme den Dateitypen:  
`file passwd.txt.asc`  
Ausgabe: `passwd.txt.asc: PGP message`  
Versuche die Datei zu lesen:  
`cat passwd.txt.asc`  
\lstinputlisting{./report8/passwd.txt.asc}

12) Entschlüssle die Datei passwd.txt.asc und schreibe den Inhalt in die Datei passwd-armor.txt  
`gpg --output passwd-armor.txt -d passwd.txt.asc`

13) Erstelle ein Schlüsselpaar auf dem pvscnt10-hn mit dem DSA und ELGamal Algorithmus.  
`gpg --gen-key`  
Auswahl:
1. DSA und Elgamal
2. Name: client
3. Emailadresse: client@pvscnt10-hn
4. Passphrase: 123456

14) Tausche die öffentlichen Schlüssel zwischen pvscnt10-hn und pvssvr10-bln aus.  
pvscnt10-hn:  
`gpg --output client.asc --export --armor client`  
`scp client.asc root@192.168.100.195:`   
`gpg --import Steinmeyer.asc`  
pvssvr10-bln:  
`gpg --output Steinmeyer.asc --export --armor steinmeyer`  
`scp Steinmeyer.asc root@192.168.100.130:`   
`gpg --import client.asc`  


## Exercise 3: Secure telnet communication using ssh portforwarding  

1) Use netstat to verify that telnet is using port 23. Which ip address is telnet bound to? Explain how to do this in your lab report.    
Dies wird durch den Befehl `netstat -nltp` ermöglicht. Es werden alle momentanen tcp Verbindungen angezeigt mit ip und port.  
Falls erwünscht kann man die Suche nach telnet durch grep mit folgenden Befehl vereinfachen.  
`netstat -nltp | grep xinetd` vereinfachen.  

Ausgabe:  
`tcp        0      0 0.0.0.0:23              0.0.0.0:*               LISTEN      6020/xinetd`  
Es ist zu sehen, dass er auf Port 23 hört.  

2) Login into pvssvr10-bln. Modify the telnet file so that it can be only accessible via the loopback adapter.  
Dies wird erreicht, indem man in die telnet config die Zeile `bind = 127.0.0.1` einfügt.  
\lstinputlisting{./report8/telnet}

3) Use netstat to verify that telnet is using port 23 and is bind to the loopback adapter. Explain how to do this in your labreport.  
Nach dem Verändern der config muss xinetd neu gestartet werden. Anschliessend testen wir mit `netstat -nltp | grep xinetd`, ob der Service auf die richtige Adresse gebunden ist.  
`tcp        0      0 127.0.0.1:23            0.0.0.0:*               LISTEN      6020/xinetd`  
Der Service ist jetzt nur noch über das Loopback device erreichbar.  

4) Login into pvscnt10-hn and use `ssh xxxx 192.168.100.34` pvssvr10-bln.  
    Der Befehl um den Port 1029 auf vom Client auf den Port 23 des Hosts weiterzuleiten lautet:  
    `sudo ssh -L 127.0.0.1:1029:127.0.0.1:23 192.168.100.34`

5) Use netstat to verify that telnet is using port 23 an is bind to the loopback adapter.  
Diese Aufgabe ist praktisch äquivalent zu Aufgabe 3).
Außerdem kann man mit `netstat -tlpn` nun sehen dass ssh auf Port 1029 horcht.

6) Use nmap to verify open ports.  
`nmap -p0-65535 192.168.100.34` checkt alle Ports des andere System auf offene Ports.  

7) Capture telnet packets between pvssvr10-bln and pvscnt10-hn using Wireshark before establishing a tunnel an save the packet captured. Please include this with your lab report:

8) Now start again pvscnt10-hn and use `sudo ssh -L 127.0.0.1:1029:127.0.0.1:23 192.168.100.34`.

9) Capture telnet packets between pvssvr10-bln and pvscnt10-hn using Wireshark after Q3.8 establishing a tunnel and save the packet catured. Pleas include this with your lab report.
    `telnet 127.0.0.1 1029`

## Exercise 4: Using TrueCrypt on Windows 8

1) Download Truecrypt and install it on pvscnt10-bln
2) Please create an encrypted file pvscnt10-bln-encrypted of 2 MB using Tools -> Truecrypt Volume Creation wizard.

Bei der Erstellung des TrueCrypt Containers müssen verschiedene Parameter spezifiziert werden.  
Wir wählen das Standart TrueCrypt Volume, da wir für unsere Übung keinen unsichtbaren Container benötigen.
Als Verschlüsselungsalgorithmus wählen wir den Standard AES Algorithmus. Die Größe wird wie vorgegeben auf 2 MB gesetzt und das Passwort auf "pass\$\$\$\$".
Anschließend kann man das Volume erstellen. Hierbei ist darauf zu achten, dass man einige Zeit wartet, sodass sich genug Entropie ansammelt. Als Dateisystem ist hier FAT gewählt, dies hat keine tiefere Bedeutung.

\includegraphics{truecrypt-type.png}  
\includegraphics{truecrypt-algo.png}  
\includegraphics{truecrypt-size.png}  
\includegraphics{truecrypt-pass.png}  
\includegraphics{truecrypt-format.png}  

3) Mount the file pvscnt10-bln-encrypted to M:\, create a text file on pvscnt1-bln.txt with the message "Warning this system is only for authorized users" and copy this file to M:\ and umount the file.

\includegraphics{truecrypt-open.png}
\includegraphics{truecrypt-mounted.png}  

