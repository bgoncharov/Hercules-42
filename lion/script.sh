# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    script.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bogoncha <bogoncha@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/03/01 09:05:44 by bogoncha          #+#    #+#              #
#    Updated: 2019/03/01 23:17:12 by bogoncha         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#connect via ssh login@ip

apt-get install openssh-server -y
sed -i 's/^#\?Port .*/Port 4242/' /etc/ssh/sshd_config
/etc/init.d/ssh restart
