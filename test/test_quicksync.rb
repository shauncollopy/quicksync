require 'helper'
require 'quicksync'

class TestQuickSync < Test::Unit::TestCase
  
  attr_accessor :src, :dest, :user, :host, :exclude, :include, :copy_options, :settings, :run_method, :copy_method, :run_on
    
  def setup
    @logger = QuickSync.Logger
    @logger.level = QuickSync::Logger::INFO
    @config = QuickSync.Config
    @quicksync = QuickSync::RSync.new
    @src = @config[:src]
    @dest = @config[:dest]
    @host = @config[:host]
    @user = @config[:user]
    @options = @config

  end

  def teardown

  end
  
 
  def test_config

    assert_nothing_raised do
      @config = QuickSync.Config
    end
  end

  def test_rsync

    puts "test_rsync: testing pull_from"
    assert_nothing_raised do
      cmd = @quicksync.pull_from(@src,@dest,@options)
    end
    puts "test_rsync: testing push_to"
    assert_nothing_raised do
      cmd = @quicksync.push_to(@src,@dest,@options)
    end
    puts "test_rsync: testing copy_local"
    assert_nothing_raised do
      cmd = @quicksync.copy_local(@src,@dest,@options)
    end
    puts "test_rsync: testing copy_remote"
    assert_nothing_raised do
      cmd = @quicksync.copy_remote(@src,@dest,@options)
    end
    
    

  end

end

