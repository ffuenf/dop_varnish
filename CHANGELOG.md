# CHANGELOG for dop_varnish

This file is used to list changes made in each version of dop_varnish.

## 2.2.0  (February 18, 2016)

* bump version

## 2.1.1  (January 27, 2015)

* parameterize more startup options

## 2.1.0  (January 1, 2015)

* integrate testsuites: test-kitchen, foodcritic, rubocop, travis-ci

## 2.0.1  (December 26, 2014)

* remove dependency to dop_nginx

## 2.0.0  (May 22, 2014)

* varnish 4.0

## 1.0.4  (April 14, 2014)

* make varnish listen only on the loop-back interface 127.0.0.1 (as we use it generally behind nginx)

## 1.0.3  (March 7, 2014)

* disable Varnishadm logging to syslog
* search for ESI-Tags in whole content not just valid HTML (esi_syntax=0x2)

## 1.0.2  (February 13, 2014)

* pin templates to dop_varnish cookbook

## 1.0.1  (November 22, 2013)

* raise clibuffer to play well with nexcess_turpentine

## 1.0.0  (September 21, 2013)

* Initial release of dop_varnish