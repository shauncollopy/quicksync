require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test


require 'savon'

userName=   "mgm.wireless"
password=   "mgm10672723"
msisdn=     "61458027027"

task :handsoap do
  
end

task :soap_test do

  require 'net/http'
  require 'net/https'
  require 'xmlsimple'

  # url = "http://carlo.mobilemessenger.com.au:38080/MsisdnResolverImplService/MsisdnResolverWS?WSDL"
  url = "https://ws.mobilemessenger.com/wsgw/checkMobileNumber"
  puts "soap_test: using web service url==#{url.to_s}"
  

  client = Savon::Client.new do 
    wsdl.document = url
    http.auth.basic(userName, password)
 end
  
  client.http.auth.basic(userName, password)  
  puts "\n\nsoap_actions=#{client.wsdl.soap_actions}"
  
  puts "client.http.auth=#{client.http.auth},\nbasic=#{client.http.auth.basic}"
  
  response = client.request(:resolve) do 
   soap.body = { "arg0" => "6148027027"}
  end

  # puts "web service response=#{response}"
  # url2 = "http://carlo.mobilemessenger.com.au:38080/MsisdnResolverImplService/MsisdnResolverWS"
  # cmd = "curl --user #{userName}:#{password} #{url2}"
  # puts "cmd=#{cmd}"
  # system cmd


end

task :http_get do

# Test Http Get

=begin
  # uri = URI("http://carlo.mobilemessenger.com.au:38080/carlo-web/CarrierResolution?userName=#{userName}&password=#{password}&msisdn=#{msisdn}")
  uri = URI("https://ws.mobilemessenger.com/wsgw/checkMobileNumber?mobileNumber=61458027027&lookupDevice=true")
  puts " http_test: doing http get test, uri=#{uri.to_s}"
  
  # curl --user mgm.wireless:mgm10672723 http://carlo.mobilemessenger.com.au:38080/carlo-web/CarrierResolution?userName=mgm.wireless&password=mgm10672723&msisdn=61458027027

  req = Net::HTTP.start(uri.host, uri.port) do | http |
    http.use_ssl = true
    req = Net::HTTP::Get.new()
    response = http.request(req)
    puts "http get response=#{response.body}"
  end

  
  require 'net/http'
  require 'uri'
  
  url = URI.parse('https://ws.mobilemessenger.com/wsgw/checkMobileNumber')
  req = Net::HTTP::Post.new(url.path)
  req.basic_auth userName, password
   #  req.use_ssl = true
  req.form_data({'mobileNumber' => '61458027027', 'lookupDevice' => 'true'})
  
  resp = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
  puts resp
=end
  require 'net/http'
  require 'net/https'
  
  uri = URI("https://ws.mobilemessenger.com/wsgw/checkMobileNumber?mobileNumber=61458027027&lookupDevice=true")
  
 
  http = Net::HTTP.new(uri.host,443)
  req = Net::HTTP::Get.new(uri.path)
  http.use_ssl = true
  req.basic_auth userName, password
  response = http.request(req)
  puts response.body
end

  



