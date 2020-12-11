# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    launch.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/02 10:53:35 by atrouill          #+#    #+#              #
#    Updated: 2020/12/09 14:15:44 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

openrc
touch /run/openrc/softlevel
/etc/init.d/mariadb setup

service mariadb restart

until mysqladmin ping; do
	sleep 1
done

mysql -u root -e "SET GLOBAL general_log=1;"
mysql -u root -e "SET GLOBAL general_log_file='mariadb.log';"
mysql -u root -e "CREATE DATABASE db_wordpress;"
mysql -u root -e "CREATE USER 'admin'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASS}';"
mysql -u root -e "GRANT ALL ON *.* TO 'admin'@'%';"
mysql -u root -e "CREATE USER 'wp_user'@'%' IDENTIFIED BY '${MYSQL_WP_USERPASS}';"
mysql -u root -e "GRANT ALL ON db_wordpress.* TO 'wp_user'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"

tail -f /var/lib/mysql/mariadb.log
