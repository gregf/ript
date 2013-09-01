name              'ript'
maintainer        'Chris Roberts'
maintainer_email  'chrisroberts.code@gmail.com'
license           ' '
description       'Provides a lwrp for working with the ript gem.'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.1.0'

%w{ubuntu debian centos}.each do |os|
  supports os
end

depends 'chef_package'

recipe "default", "Installs the ript gem"
