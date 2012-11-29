require 'helper'
require 'quicksync'

class TestQuickSync < Test::Unit::TestCase
  def setup
    $logger = QuickSync.Logger
    $logger.level = QuickSync::Logger::INFO

  end

  def teardown

  end

  def test_rsync

    assert_nothing_raised do
     
      options = $default_options
      qs = QuickSync::RSync.new

      from = options[:from]
      to = options[:to]
      cmd = qs.pull_from(from,to,options)

    end
    
  
    
  end

end

