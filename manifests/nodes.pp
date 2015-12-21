node default {

    include users
    include ssh
    include postgres
    include git

    git::clone { '<GitHub repository name>':
	    path => '/usr/local/app',
	    dir => 'django',
	}

}
