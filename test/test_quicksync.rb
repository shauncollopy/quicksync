require 'helper'
require 'quicksync'

class TestQuickSync < Test::Unit::TestCase
  def setup
    $logger = QuickSync.Logger
    $logger.level = QuickSync::Logger::TRACE

  end

  def teardown

  end

  def test_rsync

    assert_nothing_raised do
      $logger.important "QuickSync.test_rsync: running test, default_options=#{$default_options}"
      options = $default_options
      qs = QuickSync::RSync.new

      from = options[:from]
      to = options[:to]
      $logger.important "\n\nQuickSync.test_rsync: from=#{from}, to=#{to}"
      cmd = qs.pull_from(from,to,options)
      $logger.important "QuickSync.test_rsync: pull_from cmd=#{cmd}"

    end
    
    var = ""
    
    puts "var=#{var.blank?}"
    
  end

end

