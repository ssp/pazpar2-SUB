# pazpar2 Konfiguration für vifanord

2014: Sven-S. Porst <ssp-web@earthlingsoft.net>


## Einrichtung
pazpar2 Installation aus den Paketen von Index Data. Es wird und mindestens pazpar2 1.8.6 mit yaz 5.10.2 empfohlen (minimum ist pazpar2 1.6.39 mit yaz 5.0.18 benötigt, ). pazpar2 installiert ein fertiges init Skript, mit dem der Dienst gestartet und beendet werden kann.

Die Konfigurationsdateien liegen in `/etc/pazpar2`. Zu diesem Ordner ist dieses Repository mit Subrepositories als Ordner `vifanord-config` hinzugefügt. Weiterhin sind die Symlinks `server.xml`, `services`, `settings`, `xsl` hinzugefügt, ersetzt.

	> ls -l /etc/pazpar2/

	-rw-r--r--  1 itvifa itvifa   182 Okt 28 16:55 ap2pazpar2.cfg
	-rw-r--r--  1 itvifa itvifa   229 Jan 18  2013 ap2pazpar2-js.cfg
	-rw-r--r--  1 itvifa itvifa  3272 Aug 13  2013 cf.xsl
	drwxr-xr-x 11 itvifa itvifa  4096 Jan 29  2013 conf
	-rw-r--r--  1 itvifa itvifa  6682 Jan 18  2013 dads-pz2.xsl
	-rw-r--r--  1 itvifa itvifa  8516 Jan 18  2013 danmarc2.xsl
	-rw-r--r--  1 itvifa itvifa  2084 Jan 18  2013 dc.xsl
	-rw-r--r--  1 root   root    2588 Jan  7 14:04 dkabm.xsl
	-rw-r--r--  1 itvifa itvifa   646 Jan 18  2013 marc21-ourl.xsl
	-rw-r--r--  1 itvifa itvifa 16259 Jan 18  2013 marc21.xsl
	-rw-r--r--  1 itvifa itvifa  9991 Jan 18  2013 marc22.xsl
	-rw-r--r--  1 itvifa itvifa  2776 Jan 18  2013 MarcXML2TurboMarc.xsl
	-rw-r--r--  1 itvifa itvifa  1995 Jan 18  2013 oai_dc.xsl
	-rw-r--r--  1 itvifa itvifa  1695 Apr 26  2013 opac_turbomarc.xsl
	-rw-r--r--  1 itvifa itvifa  1693 Apr 26  2013 opac.xsl
	-rw-r--r--  1 itvifa itvifa   885 Jan 18  2013 pp2out-to-carrot2.xsl
	-rw-r--r--  1 itvifa itvifa  5185 Jan 18  2013 primo-pz2.xsl
	-rw-r--r--  1 itvifa itvifa  4875 Jan 18  2013 pz2-ourl-base.xsl
	-rw-r--r--  1 itvifa itvifa  2895 Jan 18  2013 pz2-ourl-marc21.xsl
	-rw-r--r--  1 itvifa itvifa   648 Jan 18  2013 pz2-solr.xsl
	-rw-r--r--  1 itvifa itvifa  1788 Jan 18  2013 server-status-nagios.xsl
	lrwxrwxrwx  1 itvifa itvifa    23 Mär  3 11:31 server.xml -> vifanord-config/CAU.xml
	lrwxrwxrwx  1 itvifa itvifa    24 Mär  3 11:31 services -> vifanord-config/services
	drwxr-xr-x  2 itvifa itvifa  4096 Feb 20 10:35 services-available
	drwxr-xr-x  2 itvifa itvifa    25 Jan 29  2013 services-enabled
	lrwxrwxrwx  1 itvifa itvifa    25 Mär  3 11:31 settings -> vifanord-config/settings/
	-rw-r--r--  1 itvifa itvifa  1790 Aug 30  2013 solr-pz2.xsl
	-rw-r--r--  1 itvifa itvifa 26719 Aug 13  2013 tmarc.xsl
	-rw-r--r--  1 itvifa itvifa  3002 Jan 18  2013 unimarc.xsl
	-rw-r--r--  1 itvifa itvifa   358 Jan 18  2013 usmarc.xsl
	drwxr-xr-x 11 itvifa itvifa  4096 Feb 28 11:45 vifanord-config
	lrwxrwxrwx  1 itvifa itvifa    20 Mär  3 11:31 xsl -> vifanord-config/xsl/


Die Struktur des Repositories `vifanord-config` ist in dessen Readme beschrieben. Das Folgende bezieht sich auf seinen Inhalt.


## Server

Der pazpar2 Server lädt standardmäßig die Datei `/etc/pazpar2/server.xml`, also die Datei `vifanord-config/CAU.xml`. Sie bindet die Konfigurationsdateien für die verschiedenen pazpar2 Services für vifanord ein.

[Dokumentation der pazpar2 Konfigurationsdateien](http://www.indexdata.com/pazpar2/doc/pazpar2_conf.html)

## Dienste

Pazpar2 bietet verschiedene Dienste (Services) an. Ein solcher Dienst ist eine vorkonfigurierte Metasuche, bestehend aus der Konfiguration der abzufragenden Server und des internen Metadatenmodells.

Die Dienstkonfigurationen für vifanord liegen im Ordner `services/CAU`. Es gibt für jeden der drei vifanord Sucheinstiege einen Dienst mit Namen `vifanord[-themen|geo|ir]`.

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
