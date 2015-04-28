# pazpar2 Konfiguration für vifanord

2014-2015: Sven-S. Porst <ssp-web@earthlingsoft.net>


## Einrichtung
pazpar2 Installation aus den Paketen von Index Data. Es wird mindestens pazpar2 1.8.6 mit yaz 5.10.2 empfohlen (minimum ist pazpar2 1.6.39 mit yaz 5.0.18 benötigt). pazpar2 installiert ein fertiges init Skript, mit dem der Dienst gestartet und beendet werden kann.

Die Konfigurationsdateien liegen in `/etc/pazpar2`. Zu diesem Ordner ist dieses Repository mit Subrepositories als Ordner `vifanord-config` hinzugefügt. Weiterhin sind die Symlinks `server.xml`, `services`, `settings`, `xsl` hinzugefügt, ersetzt.

	> ls -l /etc/pazpar2/
	
	-rwxrwxr-x+ 1 root     root     1650 Mär 25 11:45 server-status-nagios.xsl
	lrwxrwxrwx  1 xeext211 xeext211   23 Mär 23 23:31 server.xml -> vifanord-config/CAU.xml
	-rwxrwxr-x+ 1 root     root     1447 Feb 10 15:25 server.xml-pazpar2-original
	lrwxrwxrwx  1 xeext211 xeext211   24 Mär 23 23:28 services -> vifanord-config/services
	drwxrwxr-x+ 2 root     root     4096 Mär 19 14:45 services-available
	drwxrwxr-x+ 2 root     root     4096 Mär 19 14:45 services-enabled
	lrwxrwxrwx  1 xeext211 xeext211   24 Mär 23 23:28 settings -> vifanord-config/settings
	drwxrwxr-x+ 3 root     root     4096 Mär 19 14:45 settings-pazpar2-original
	drwxrwxr-x+ 9 xeext211 xeext211 4096 Apr 29 11:09 vifanord-config
	lrwxrwxrwx  1 xeext211 xeext211   19 Mär 23 23:28 xsl -> vifanord-config/xsl

Die Struktur des Repositories `vifanord-config` ist in dessen Readme beschrieben. Das Folgende bezieht sich auf seinen Inhalt.


## Server

Der pazpar2 Server lädt standardmäßig die Datei `/etc/pazpar2/server.xml`, also die Datei `vifanord-config/CAU.xml`. Sie bindet die Konfigurationsdateien für die verschiedenen pazpar2 Services für vifanord ein.

[Dokumentation der pazpar2 Konfigurationsdateien](http://www.indexdata.com/pazpar2/doc/pazpar2_conf.html)

## Dienste

Pazpar2 bietet verschiedene Dienste (Services) an. Ein solcher Dienst ist eine vorkonfigurierte Metasuche, bestehend aus der Konfiguration der abzufragenden Server und des internen Metadatenmodells.

Die Dienstkonfigurationen für vifanord liegen im Ordner `services/CAU`. Es gibt für jeden der drei vifanord Sucheinstiege einen Dienst mit Namen `vifanord[-themen|-geo]`.

Die Dienste binden vorkonfigurierte Einstellungen für die verschiedenen Server ein, die im Ordner `settings` liegen. So können die Konfigurationen wiederverwendet werden.

Das Metadatenmodell beschreibt die von pazpar2 genutzten Felder und konfiguriert die gelieferten Facetten sowie die Deduplizierung. Es ist hauptsächlich durch `metadata/default.xml` beschrieben, mit spezifischen Anpassungen für vifanord in `metadata/vifanord-extras.xml`. Da bei pazpar2s Metadatenkonfiguration der zuerst eingelesene Wert gilt, ist es wichtig, dass diese Datei _vor_ der allgemeinen eingebunden wird.


## Einstellungen

Im Ordner `settings` sind die Server Konfigurationen möglichst generisch abgelegt. Intern identifiziert pazpar2 die Einstellungen über das `target` Attribut. Es kann mit einem `*` enden, um eine Einstellung auf alle Targets, die gleich beginnen anzuwenden. Dieses Attribut wird auch verwendet, um die lokalisierten Namen zur Anzeige zu erzeugen (siehe `facet-xtargets` in  [pazpar2-vifanord.js](https://github.com/ssp/vifanord-pazpar2-typo3/blob/master/pazpar2-vifanord.js)).

Um von pazpar2 genutzt zu werden, muss für ein Target die `pz:name` Einstellung gesetzt sein. Mit der `pz:allow` Einstellung kann das Target durch den Wert 0/1 deaktiviert/aktiviert werden.

Die generelle Konfiguration ist in der [pazpar2 Dokumentation](http://www.indexdata.com/pazpar2/doc/pazpar2_conf.html) beschrieben. Über die Verbindung zur Server hinaus besonders wichtige Felder für uns sind:

* `pz:cclmap:*`: Konfiguration der pazpar2 CCL Abfrageschlüssel durch Angabe der zugehörigen Serverabfrage. Für die vifanord Oberfläche erwarten wir, dass `term`, `title`, `person`, `subject`, `date` konfiguriert sind. Für die thematische Suche nutzen wir (in den zugehörigen Targets) zusätzlich `ddc-ir`, `ddc-t`, `ddc-g` und `lsg`.
* `pz:limitmap:*`: (selten) falls die Möglichkeit besteht bei Auswahl einer Facette, die Suche auf dem Server verfeinert neu zu starten, kann hier für den Facettennamen angegeben werden, welche Abfragebedingung hinzugefügt werden soll.
* `pz:maxrecs`: Maximale Anzahl der vom Server zu ladenden Treffer.
* `pz:allow`: Wird das Target in die Suche eingebunden (1) oder nicht (0)
* `pz:xslt`: Kommaseparierte Liste von Pfaden zu XSLT Dateien. Die Records vom Server werden in dieser Reihenfolge durch XSL in das interne Metadatenmodell transformiert.
* `catalogueURLHintPrefix`: URL, die durch Anhängen des `id` Feldes eine URL zur Webseite für den zugehörigen Record wird.


## XSL

Pazpar2s Datennormalisierung findet mit XSL statt. Im Ordner `xsl` befindt sich eine Sammlung verschiedener Transformationen, die die häufig benötigten Schritte ausführen.
