node default {

    include users
    include ssh
    include postgres
    include git
    include django

	file { '/usr/local/app':
	    ensure => directory,
	    owner => 'bob',
	    group => 'bob',
	    mode => 755,
	}

	git::cloner { 'samuelclay/NewsBlur':
	    path => '/usr/local/app',
	    dir => 'django',
	}

}
