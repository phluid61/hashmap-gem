=begin
Copyright (c) 2013, Matthew Kerwin
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met: 

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer. 
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution. 

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
=end

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

