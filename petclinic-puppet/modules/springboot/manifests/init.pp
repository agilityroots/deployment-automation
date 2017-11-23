class springboot {

  group { 'spring':
    ensure => 'present',
    gid    => '1024',
  }
  user { 'spring':
    ensure => present,
    gid => '1024',
    comment => 'spring boot user',
    home => '/opt/petclinic',
    managehome => true,
    require => Group['spring']
  }
  file { '/opt/petclinic':
    ensure => 'directory',
    owner => 'spring',
    group => 'spring',
    mode => '0744',
    require => User['spring']
  }
  file { '/etc/systemd/system/petclinic.service':
     ensure => file,
     content => epp('springboot/petclinic.epp'),
     require => File['/opt/petclinic']
  }

  if defined('$::artifactpath') {
    notify { "downloading artifact from $::artifactpath":}
    common::remote_file{'/opt/petclinic/petclinic.jar':
      remote_location => "$::artifactpath",
      mode            => '0777',
    }
  } else {
    fail("A fact 'artifactpath' should be set!")
  }
}
