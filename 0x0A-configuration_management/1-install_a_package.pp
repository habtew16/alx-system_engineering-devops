#install a flask
package {'python3.8':
  ensure => '3.8.10'
}

package {'python3-pip':
  ensure => present,
}

package {'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}

package {'werkzeug':
  ensure   => '2.1.1',
  provider => 'pip',
  require  => package['python3-pip'],
}
