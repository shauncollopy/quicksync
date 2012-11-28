require 'helper'
require 'quicksync'

class TestQuickSync < Test::Unit::TestCase
  
  def setup
    test_val = "/users/shaun/quicksync/test_sync/from /users/shaun/quicksync/test_sync/from"
    from = input.split(' ').first
    to = input.split(' ').last
    
    if from.include?("@")
      user_and_host = from.split(":").first
      dir = from.split(":").last
      user = user_and_host.split("@").first
      host = user_and_host.split("@").last
      from = { :dir=>dir, :host=>host, :user=>user}
    else
      from = { :dir=>dir }
    end
  
    if to.include?("@")
      user_and_host = to.split(":").first
      dir = to.split(":").last
      user = user_and_host.split("@").first
      host = user_and_host.split("@").last
      to = { :dir=>dir, :host=>host, :user=>user}
    else
      to = { :dir=>dir }
    end
    
    @sync = QuickSync::RSync.new.sync(from,to)
    
  end
  
  def teardown
    
  end
  
  def test_options
    
    assert_equal(get_command)
    
    from = input.split(' ').first
    to = input.split(' ').last
  
    

  end
    
end


r  = QuickSync::RSync.new.sync(from,to)
   
  

