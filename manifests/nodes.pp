node default {

    include users
    include ssh
    include postgres
    include git

	file { '/usr/local/app':
	    ensure => directory,
	    owner => 'bob',
	    group => 'bob',
	    mode => 755,
	}

	git::clone { 'https://github.com/dhdanno/puppet':
	    path => '/usr/local/app',
	    dir => 'django',
	}

}
