class nginx{
    include nginx::install, nginx::config, nginx::service
}

class nginx::install{
    package { 'nginx':
        ensure => present
    }
}

class nginx::config{
    file { "/etc/nginx/sites-enabled/":
        recurse => true,
        purge => true,
    }    
}

class nginx::service{
    service { 'nginx':
        ensure => running,
    }
}

# dependency declarations are interpreted right to left
Class["nginx::install"] -> Class["nginx::config"] -> Class["nginx::service"]

define nginx::site( $source ){
    file { "/etc/nginx/sites-enabled/$name":
        ensure => present,
        source => $source,
        owner => root,
        group => root,
        mode => 0644,
        require => Class['nginx'],
        notify => Class['nginx::service'],
    }
}