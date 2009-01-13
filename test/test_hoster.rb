require File.dirname(__FILE__) + '/test_helper'
require 'rubygems'
require 'test/unit'
require 'shoulda'

TestContent = <<CONTENT
127.0.0.1 localhost
127.0.1.1 localhost
192.168.1.1 router.com router
192.168.1.2 localhost
127.0.0.1 test.com
CONTENT

class TestHoster < Test::Unit::TestCase
  context "Reading and parsing hosts file" do
    setup do
      File.open("hosts","w") do |file|
        file.puts TestContent
      end
      @hoster = Hosts.new("hosts")
    end
    
    should "create an object that stores a Hash" do
      assert_kind_of Hash, @hoster.entries
    end
    
    should "assign ip addresses as hash keys" do
      assert @hoster.entries.has_key?("127.0.0.1")
    end
    
    should "store a hosts array as hash values" do
      assert_kind_of Array, @hoster.entries.values.first
    end
    
    should "map multiple hosts to ip addresses on the same line" do
      assert_equal "router.com", @hoster.entries["192.168.1.1"].first
      assert_equal "router", @hoster.entries["192.168.1.1"].last
    end
    
    should "map multiple hosts to same ip address on different lines" do
      assert_equal "localhost", @hoster.entries["127.0.0.1"].first
      assert_equal "test.com", @hoster.entries["127.0.0.1"].last
    end
    
  end
  
  context "Manipulating hosts file" do
    setup do
      File.open("hosts","w") do |file|
        file.puts TestContent
      end
      @hoster = Hosts.new("hosts")
    end
    
    should "add a host to the correct line for specified ip address" do
      assert_equal 2, @hoster.entries["192.168.1.1"].size
      @hoster.add("router.org","192.168.1.1")
      assert_equal 3, @hoster.entries["192.168.1.1"].size
    end
    
    should "remove correct host from line for specified ip address" do
      assert_equal 2, @hoster.entries["192.168.1.1"].size
      @hoster.remove("router.com", "192.168.1.1")
      assert_equal 1, @hoster.entries["192.168.1.1"].size
      assert_equal "router", @hoster.entries["192.168.1.1"].first
    end
    
 #    should "write correct changes to file" do
 #       @hoster.add("test.dev")
 #       @hoster.add("router.org","192.168.1.1")
 #       @hoster.remove("router.com", "192.168.1.1")
 #       #@hoster.finalize_changes!
 #       puts @hoster.raw_data
 #       new_content = <<CONTENT
 # 127.0.0.1 localhost test.dev
 # 127.0.1.1 localhost
 # 192.168.1.1 router router.org
 # 192.168.1.2 localhost
 # 127.0.0.1 test.com
 # CONTENT
 #       assert_equal new_content, @hoster.raw_data
 #     end
  end
end