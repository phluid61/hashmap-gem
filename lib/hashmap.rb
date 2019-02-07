
if RUBY_VERSION >= '2.4'
  class Hash
    alias map_values  transform_values
    alias map_values! transform_values!
  end
else
  class Hash
    #
    # Returns a new hash which is a copy of the current hash but each
    # value is replaced by the result of running it through +block+.
    #
    #   {'a'=>1, 'b'=>2}.map_values { |v| v*2 } #=> {'a'=>2, 'b'=>4}
    #   {'a'=>1, 'b'=>2}.map_values { "cat" }   #=> {'a'=>"cat", 'b'=>"cat"}
    #
    # If no block is given, an Enumerator is returned instead.
    #
    def map_values &block # :yields: value
      return enum_for(:map_values) unless block_given?
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
      return enum_for(:map_values!) unless block_given?
      replace map_values(&block)
    end
  end
end

if RUBY_VERSION >= '2.5'
  class Hash
    alias map_keys  transform_keys
    alias map_keys! transform_keys!
  end
else
  class Hash
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
    # If no block is given, an Enumerator is returned instead.
    #
    def map_keys &block # :yields: key
      return enum_for(:map_keys) unless block_given?
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
      return enum_for(:map_keys!) unless block_given?
      replace map_keys(&block)
    end
  end
end

class Hash
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
  # If no block is given, an Enumerator is returned instead.
  #
  def map_pairs &block # :yields: key, value
    return enum_for(:map_pairs) unless block_given?
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
  # See: #map_pairs
  #
  def map_pairs! &block # :yields: key, value
    return enum_for(:map_pairs!) unless block_given?
    replace map_pairs(&block)
  end
end

=begin
Copyright (c) 2019, Matthew Kerwin <matthew@kerwin.net.au>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
=end

