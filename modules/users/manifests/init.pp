class users {

ssh_authorized_key { 'bob':
    ensure => 'present',
    user => 'bob',
    type => 'rsa',
    key => '90321874oi123h4lkj123h4lk123jhlk234jh',
}

user { 'bob':
    ensure => 'present',
    groups => ['sudo'],
    home => '/home/bob',
    managehome => true,
    password => '$6$lY2Gp3Cr$zNrUB7T3yibUF/gasdadsTQ0fNv7MUmx/DZuw3E7I..Vh9tITG28BtgvXJPU4Gm4Z/9oNvlbX24KzQ9Ib1QH1B9.',
    shell => '/bin/bash',
    require => User['ubuntu'],
}

user { 'ubuntu':
    ensure => 'present',
}

file { '/home/bob':
    ensure => directory,
    owner => 'bob',
    group => 'root',
    mode => 755,
    source => 'puppet:///modules/users/bob',
    recurse => remote,
    require => User['bob'],
}



}
