# installs software required for development
node default {
  # install openssl
  package {'openssl':
    ensure => 'installed',
  }
  # install docker
  class { 'docker':
    docker_users => ['vagrant'],
  }
}
