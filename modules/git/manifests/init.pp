class git {
    include git::install
    include git::keys
}

class git::install {
	package { "git":
		ensure => present,
	}
}

define git::clone ( $path, $dir){
    exec { "clone-$name-$path":
        command => "/usr/bin/git clone git@github.com:$name $path/$dir",
        creates => "$path/$dir",
        require => [Class["git"], File[$path]],
    }
}

class git::keys {

    file { "/home/bob/.ssh":
        ensure => directory,
        owner => 'bob',
        group => 'bob',
        mode => 0600,
    }

    # Key for to be able to connect to GitHub
    file { "/home/bob/.ssh/system_key":
        ensure => present,
        source => "puppet:///modules/git/system_key",
        owner => 'bob',
        group => 'bob',
        mode => 0600,
        require => File['/home/bob/.ssh'],
    }

    # Configure key to be automatically used for GitHub
    file { "/home/bob/.ssh/config":
        ensure => present,
        source => "puppet:///modules/git/config",
        owner => 'bob',
        group => 'bob',
        mode => 0600,
        require => File['/home/bob/.ssh'],

    }

    # Add GitHub to known hosts to avoid prompt
    file { "/home/bob/.ssh/known_hosts":
        ensure => present,
        source => "puppet:///modules/git/known_hosts",
        owner => 'bob',
        group => 'bob',
        mode => 0600,
        require => File['/home/bob/.ssh'],
    }

}