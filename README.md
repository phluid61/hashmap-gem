hashmap
=======

https://bugs.ruby-lang.org/issues/7793

### `map_values(&block)`
**Yields**: *value*

Returns a new hash which is a copy of the current hash but each value is replaced by the result of running it through *block*.

```ruby
{'a'=>1, 'b'=>2}.map_values { |v| v*2 } #=> {'a'=>2, 'b'=>4}
{'a'=>1, 'b'=>2}.map_values { "cat" }   #=> {'a'=>"cat", 'b'=>"cat"}
```

### `map_keys(&block)`
**Yields**: *key*

Returns a new hash which is a copy of the current hash but each key is replaced by the result of running it through *block*.

If *block* returns duplicate keys, they will be overwritten in the resulting hash.

```ruby
{'a'=>1, 'b'=>2}.map_keys { |k| k*2 } #=> {'aa'=>1, 'bb'=>2}
{'a'=>1, 'b'=>2}.map_keys { "cat" }   #=> {'cat'=>2}
```

### `map_pairs(&block)`
**Yields**: *key*, *value*

Returns a new hash which is a copy of the current hash but each key-value pair is replaced by the result of running it through *block*.

If *block* returns duplicate keys, they will be overwritten in the resulting hash.

```ruby
{'a'=>1, 'b'=>2}.map_pairs { |k,v| [k*2, v+1] } #=> {'aa'=>2, 'bb'=>3}
{'a'=>1, 'b'=>2}.map_pairs { ["cat","dog"] }   #=> {'cat'=>'dog'}
```

----

[![Build Status](https://travis-ci.org/phluid61/hashmap-gem.png)](https://travis-ci.org/phluid61/hashmap-gem)
