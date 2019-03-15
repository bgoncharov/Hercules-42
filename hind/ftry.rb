require "oauth2"
require_relative 'colors.rb'

#UID = "90aca466e9a0f2a683c28a277e1d70ce717efc049b19358752af087b1cd0e2f0"
#SECRET = "63509e7ff509415cae5cb43cc8e24ac2daa4892825b626394393a65201e7d902"

$client = OAuth2::Client.new(ENV['42_UID'], ENV['42_SECRET'], site: "https://api.intra.42.fr")
$token = $client.client_credentials.get_token

def  user_location(login)
  begin
    res = $token.get("/v2/users/#{login}/locations")
    while res.status != 200
      puts ("Server doesn't answer").red
      sleep(5)
      if res.status == 200
        break
      end
    end
    if !res.parsed[0]["end_at"]
      puts (login + ": is in " + res.parsed[0]["host"]).green
    else
      puts (login + ": offline ").grey + ("--> last login: " + res.parsed[0]["host"]).blue
    end
  rescue
    puts (login + ": wrong username!").red
  end
end

if ARGV[0]
  if File.file?(ARGV[0]) and File.extname(ARGV[0]) == ".txt"
    file = File.open(ARGV[0], "r").each_line do |line|
      line == "\n" ? next : login = line.strip
      user_location(login)
    end
    file.close
  else
    puts ("Invalid file!").red
  end
else
  puts "usage: " + $PROGRAM_NAME + " [file.txt]"
end