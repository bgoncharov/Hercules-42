# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    go.rb                                              :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bogoncha <bogoncha@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/03/15 10:01:28 by bogoncha          #+#    #+#              #
#    Updated: 2019/03/15 18:47:24 by bogoncha         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

require "oauth2"
require "json"

keys = File.read('keys.json')
json = JSON.parse(keys)

$client = OAuth2::Client.new(json["uid"], json["secret"], site: json["api_url"])
$token = $client.client_credentials.get_token

def  user_location(intra)
  begin
    res = $token.get("/v2/users/#{intra}/locations")
    while res.status != 200
      puts "API is not responding"
      sleep(3)
      if res.status == 200
        break
      end
    end
    if !res.parsed[0]["end_at"]
      puts "\e[32;1m" + intra + " (online)\e[0m " "--> " + "\e[32m" + (res.parsed[0]["host"] + "\e[0m")
    else
      puts intra + " \e[31;1m(offline)\e[0m " + "--> previous login: " + res.parsed[0]["host"]
    end
  rescue
    puts "\e[31m" + intra + " is not valid username!\e[0m"
  end
end

if ARGV[0]
  if File.file?(ARGV[0]) and File.extname(ARGV[0]) == ".txt"
    file = File.open(ARGV[0], "r").each_line do |string|
      if string == "\n"
        next
      else
        intra = string.chomp
      end
      user_location(intra)
    end
    file.close
  else
    puts "\e[31;1mNot valid file!\e[0m"
  end
else
  puts "usage: " + $PROGRAM_NAME + " [file.txt]"
end
