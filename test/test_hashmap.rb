require 'test/unit'

if RUBY_VERSION.to_f < 1.9
  class Symbol
    def next
      to_s.next.to_sym
    end
  end
end

$VERBOSE = true
require "#{File.dirname File.dirname(__FILE__)}/lib/hashmap"
class Test_hashmap < Test::Unit::TestCase
  def test_hashmap
    h        = {'s'=>1, :x=>2, 3=>'a'}
    h_k_next = {'t'=>1, :y=>2, 4=>'a'}
    h_v_next = {'s'=>2, :x=>3, 3=>'b'}
    h_p_next = {'t'=>2, :y=>3, 4=>'b'}
    assert_equal( h_k_next, h.map_keys  {|k| k.next } )
    assert_equal( h_v_next, h.map_values{|v| v.next } )
    assert_equal( h_p_next, h.map_pairs {|k,v| [k.next,v.next] } )
  end

  def test_hashmap_bang
    h        = {'s'=>1, :x=>2, 3=>'a'}
    h_k_next = {'t'=>1, :y=>2, 4=>'a'}
    h_v_next = {'s'=>2, :x=>3, 3=>'b'}
    h_p_next = {'t'=>2, :y=>3, 4=>'b'}

    a = h.dup
    a.map_keys!  {|k| k.next }
    assert_equal( h_k_next, a )

    b = h.dup
    b.map_values!{|v| v.next }
    assert_equal( h_v_next, b )

    c = h.dup
    c.map_pairs!{|k,v| [k.next, v.next] }
    assert_equal( h_p_next, c )
  end

  def test_hashmap_noblock
    h        = {'s'=>1, :x=>2, 3=>'a'}
    h_k_next = {'t'=>1, :y=>2, 4=>'a'}
    h_v_next = {'s'=>2, :x=>3, 3=>'b'}
    h_p_next = {'t'=>2, :y=>3, 4=>'b'}

    e = h.map_keys
    assert_instance_of( Enumerator, e )
    assert_equal( h_k_next, e.each {|k| k.next } )

    e = h.map_values
    assert_instance_of( Enumerator, e )
    assert_equal( h_v_next, e.each {|v| v.next } )

    e = h.map_pairs
    assert_instance_of( Enumerator, e )
    assert_equal( h_p_next, e.each {|k,v| [k.next,v.next] } )
  end

  def test_hashmap_bang_noblock
    h        = {'s'=>1, :x=>2, 3=>'a'}
    h_k_next = {'t'=>1, :y=>2, 4=>'a'}
    h_v_next = {'s'=>2, :x=>3, 3=>'b'}
    h_p_next = {'t'=>2, :y=>3, 4=>'b'}

    a = h.dup
    e = a.map_keys!
    assert_instance_of( Enumerator, e )
    e.each {|k| k.next }
    assert_equal( h_k_next, a )

    b = h.dup
    e = b.map_values!
    assert_instance_of( Enumerator, e )
    e.each {|v| v.next }
    assert_equal( h_v_next, b )

    c = h.dup
    e = c.map_pairs!
    assert_instance_of( Enumerator, e )
    e.each {|k,v| [k.next, v.next ] }
    assert_equal( h_p_next, c )
  end
end

