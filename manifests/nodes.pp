node default {

    include users
    include ssh
    include postgres
    include git
    include django

	file { '/usr/local/test':
	    ensure => directory,
	    owner => 'bob',
	    group => 'bob',
	    mode => 755,
	}

	git::clone { 'dhdanno/puppet':
	    path => '/usr/local/test',
	    dir => 'django',
	}

}
