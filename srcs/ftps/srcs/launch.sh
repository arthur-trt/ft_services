# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    launch.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/07 22:31:05 by atrouill          #+#    #+#              #
#    Updated: 2020/12/08 15:31:45 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

adduser -D "user42" && echo "user42:${FTPS_PASSWORD}" | chpasswd
chown -R user42:user42 /home/user42

echo "MasqueradeAddress ${LB_IP}" >> /etc/proftpd/proftpd.conf

proftpd

tail -f /var/log/xferlog
