# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    mail.py                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bogoncha <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/04/26 19:13:49 by bogoncha          #+#    #+#              #
#    Updated: 2019/04/26 19:13:51 by bogoncha         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

import smtplib
import getpass

user = input('email: ')
pswd = getpass.getpass('password: ')
recv = input('receiver: ')

message = """Subject: To my army
I need help!!1.
"""

try:
    smtp = smtplib.SMTP('smtp.gmail.com', 587)
    smtp.starttls()
    smtp.login(user, pswd);
    smtp.sendmail(user, recv, message)
    smtp.quit()
    print ("Successfully sent email")
except smtplib.SMTPException as e:
    print (e)
