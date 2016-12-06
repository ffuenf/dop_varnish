maintainer 'Achim Rosenhagen'
maintainer_email 'a.rosenhagen@ffuenf.de'
license 'Apache 2.0'
description 'installs/configures dop_varnish'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
name 'dop_varnish'
issues_url 'https://github.com/ffuenf/dop_varnish/issues'
source_url 'https://github.com/ffuenf/dop_varnish'
version '3.1.0'

%w(debian ubuntu).each do |os|
  supports os
end

%w(nginx varnish).each do |ressource|
  depends ressource
end
