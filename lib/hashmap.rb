class Hash
	#
	# Returns a new hash which is a copy of the current hash but each
	# value is replaced by the result of running it through +block+.
	#
	#   {'a'=>1, 'b'=>2}.map_values { |v| v*2 } #=> {'a'=>2, 'b'=>4}
	#   {'a'=>1, 'b'=>2}.map_values { "cat" }   #=> {'a'=>"cat", 'b'=>"cat"}
	#
	def map_values &block # :yields: value
		hsh = {}
		each do |k, v|
			hsh[k] = yield v
		end
		hsh
	end

	#
	# Replaces the values in +hsh+ by running them each through +block+.
	#
	# See: #map_values
	#
	def map_values! &block # :yields: value
		replace map_values(&block)
	end

	#
	# Returns a new hash which is a copy of the current hash but each
	# key is replaced by the result of running it through +block+.
	#
	# If +block+ returns duplicate keys, they will be overwritten in
	# the resulting hash.
	#
	#   {'a'=>1, 'b'=>2}.map_keys { |k| k*2 } #=> {'aa'=>1, 'bb'=>2}
	#   {'a'=>1, 'b'=>2}.map_keys { "cat" }   #=> {'cat'=>2}
	#
	def map_keys &block # :yields: key
		hsh = {}
		each do |k, v|
			hsh[ yield k ] = v
		end
		hsh
	end

	#
	# Replaces the keys in +hsh+ by running them each through +block+.
	#
	# If +block+ returns duplicate keys, they will be overwritten in turn.
	#
	# See: #map_keys
	#
	def map_keys! &block # :yields: key
		replace map_keys(&block)
	end

	#
	# Returns a new hash which is a copy of the current hash but each
	# key-value pair is replaced by the result of running it through +block+.
	#
	# If +block+ returns duplicate keys, they will be overwritten in
	# the resulting hash.
	#
	#   {'a'=>1, 'b'=>2}.map_pairs { |k,v| [k*2, v+1] } #=> {'aa'=>2, 'bb'=>3}
	#   {'a'=>1, 'b'=>2}.map_pairs { ["cat","dog"] }   #=> {'cat'=>'dog'}
	#
	def map_pairs &block # :yields: key, value
		hsh = {}
		each do |k, v|
			a, b = yield k, v
			hsh[a] = b
		end
		hsh
	end

	#
	# Replaces the values in +hsh+ by running them each through +block+.
	#
	# See: #map_values
	#
	def map_pairs! &block # :yields: key, value
		replace map_pairs(&block)
	end
end

