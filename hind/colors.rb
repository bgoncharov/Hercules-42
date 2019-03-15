# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    colors.rb                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bogoncha <bogoncha@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/03/14 20:38:17 by bogoncha          #+#    #+#              #
#    Updated: 2019/03/14 20:38:20 by bogoncha         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def grey;           "\e[37m#{self}\e[0m" end
end
