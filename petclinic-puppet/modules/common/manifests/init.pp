# Here we are defining a custom resource type.
# this is also called a defined resource type.
# https://docs.puppet.com/puppet/latest/lang_defined_types.html
# it helps to retrieve remote file
# ${title} is the title
define common::remote_file($remote_location=undef,$mode='0644') {
  package {'wget':
    ensure => present
  }
  exec {"retrieve_${title}":
    command => "/usr/bin/wget -q ${remote_location} -O ${title}",
    creates => $title,
    require => Package['wget']
  }
  file{$title:
    mode    => $mode,
    require => Exec["retrieve_${title}"],
  }
}
