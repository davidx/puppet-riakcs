node default {
  class { 'riak::cs':
    service_autorestart => false,
    cfg => {
	riak_cs => {
		admin_key => "putmeinhierapuppetdb",
	        admin_secret => "98ou23jqliudqodh"
	}
    }
  }->
  class { 'riak':
    version => "1.4.7-1",
    ulimit_etc_default => true,
    cfg => { riak_core => 
	 	{ 
			default_bucket_props => { 
				allow_mult => true
			}
	    	},
              riak_kv => 
		{
			add_paths => ["/usr/lib/riak-cs/lib/riak_cs-1.4.3/ebin"],
			storage_backend => '__atom_riak_cs_kv_multi_backend',
			multi_backend_prefix_list =>  ['__binary_0b:', '__atom_be_blocks'],
			multi_backend_default => '__atom_be_default',
			multi_backend => [
    				[ '__tuple', '__atom_be_default', '__atom_riak_kv_eleveldb_backend', [ 
        				[ '__tuple', '__atom_max_open_files' => 50 ],
        				[ '__tuple', '__atom_data_root' => "/var/lib/riak/leveldb"]
				  ] 
				],
    				['__tuple', '__atom_be_blocks', '__atom_riak_kv_bitcask_backend',    [
        				[ '__tuple', '__atom_data_root' => "/var/lib/riak/bitcask"]
				  ] 
				]
			]
		}
	}
  }->
  class { 'riak::stanchion':
  }->
  class { 'riak::join':
  # host => Cluster which do i belong, sort and join to first in list
  # host => exported resource

   host => "10.170.76.246"

 }
}
