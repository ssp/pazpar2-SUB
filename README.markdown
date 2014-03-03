# pazpar2 configuration files

This repository contains the configuration files for Index Data’s [pazpar2](http://www.indexdata.com/pazpar2/) metasearch daemon.

The files were created for [SUB Göttingen](http://www.sub.uni-goettingen.de) and [Universitätsbibliothek Greifswald](http://www.uni-greifswald.de/bibliothek.html).

The configuration requires at least pazpar2 1.6.39 with yaz 5.0.18 to work.


## Contents
* `HGW.xml`: server configuration for Universitätsbibliothek Greifswald
* `SUB.xml`: server configuration for SUB Göttingen
* `test.xml`: test server configuration
* `services/`: folder with service configuration files:
	* `HGW/`: folder with service configurations used by Universitätsbibliothek Greifswald’s server
	* `SUB/`: folder with service configurations used by SUB Göttingen’s server
	* `test/`: folder with test services
	* `metadata/`: folder with metadata configurations, included by the services to avoid redundancy; `default.xml` pre-configures the typical fields we expect for use with `tmarc.xsl` and with the [JavaScript client](https://github.com/ssp/pazpar2-js-client).
* `settings/`: folder with settings used by the services:
	* file names try to be mildly descriptive, with library union names or country codes
	* `secrets/`: submodule with access credentials not commited in this repository
	* `testing/`: folder with experimental, deprecated or unused settings
* `xsl/`: folder with transformation XSLTs to normalise the loaded data with subfolders:
	* `convert/`: conversion to pz:metadata tags
		* MARC: symlinks to extended version of `tmarc.xsl` with a few additional fields; `MarcXML2TurboMARC.xsl` can provide conversion from MARCXML
		* UNIMARC: `tunimarc.xsl` covers by far more fields and details than pazpar2’s unimarc.xsl; `MarcXML2TurboMARC.xsl` can provide conversion from UNIMARCXML
		* MAB: `tmab.xsl` tries to import MAB data in TurboMARC Syntax, `tmarc-to-tmab.xsl` can help fixing parsing problems
		* Solr: `solr.xsl` symlinks to an improved version of pazpar2’s `solr-pz2.xsl`
		* Plain XML: `fields.xsl` expects a flat XML file and maps tag names to `pz:metadata/@type`s
	* `target/`: target specific transformations; file names begin like those of the settings files using them; file names ending in `-pre` indicate they operate on raw data from the server, file names ending in `-post` work on the pz:metadata model
	* `pz/`: generic transformations on the pz:metadata model
	* `tmarc/`: generic transformations for TurboMARC
	* `template/`: XSL containing templates to be reused from other XSL
	* `unused/`: not currently in use by active services
	* `testdata/`: XML files with records from some targets; helpful for trying out transformations manually
	* `info/`: information on some aspects of the data encountered
	* `doc/`: XSL referenced by the configuration files to display them as HTML
* git submodules:
	* [`pazpar2`](http://git.indexdata.com/?p=pazpar2.git) by Index Data
	* [`yaz`](http://git.indexdata.com/?p=yaz.git): library used by pazpar2
	* [`pazpar2-etc/`](https://github.com/ssp/pazpar2-etc): customised files (e.g. `tmarc.xsl`) from the `pazpar2/etc` folder. These are kept in a separate repository to enable using a cleanly checked out version of the software.
	* [`pazpar2-access`](ttps://github.com/subugoe/pazpar2-access): small script that can (de-)activate databases based on the user’s IP address
	* `settings/secrets`: access credentials, not published
* The folder `conf/` contains configuration files to help installing the pazpar2 service on a server:
	* `pazpar2.init`: init script for SUSE Linux
	* `pazpar2.logrotate`: logrotate configuration file
	* `pazpar2-apache.logrotate`: logrotate configuration for the apache virtual host proxying pazpar2
	* `pazpar2-vhost.conf`: apache virtual host configuration
	* `pazpar2.nagios`: nagios configuration for checking a pazpar2 server


## Contact
In case you have questions or need help creating a pazpar2 service, please [get in touch with Sven-S. Porst](mailto:ssp-web@earthlingsoft.net?subject=pazpar2).

