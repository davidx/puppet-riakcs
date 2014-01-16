node default {
  class { 'riak':
    version => "1.4.7-1"
  }->
  class { 'riak::cs':

 }->
  class { 'riak::stanchion':


 }
}
