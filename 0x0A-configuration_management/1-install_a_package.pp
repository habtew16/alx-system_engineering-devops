#install a flask
package {'python3.8':
  ensure => '3.8.10'
}

# install pip
package {'python3-pip':
  ensure => present,
}

#install flask
package {'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}

#install werkzug
package {'werkzeug':
  ensure   => '2.1.1',
  provider => 'pip',
  require  => package['python3-pip'],
}
