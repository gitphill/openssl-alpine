# installs software required for development
node default {
  # install packages
  package { ['openssl', 'make']:
    ensure => 'installed',
  }
  # install docker
  class { 'docker':
    docker_users => ['vagrant'],
  }
}
