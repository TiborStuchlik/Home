#require 'active_support/all'
require 'net/http'

SERVER_URL = "http://localhost:3000/main/input.json"

puts "CPU Temperature Checker 0.1.1"

def send_data(data={})
  uri = URI( SERVER_URL)
  uri.query = URI.encode_www_form(data)
  response = nil

  Net::HTTP.start(uri.host, uri.port) do |http|
    request = Net::HTTP::Get.new uri

    response = http.request request # Net::HTTPResponse object
  end
  puts response
end

count = 0

while true
  sleep 1
  temp = %x( cat /sys/class/thermal/thermal_zone0/temp )
  if temp.empty?
    temp = "unknown"
  end
  send_data({ device: "cpu_temp", value: temp, count: count})
  count += 1
end