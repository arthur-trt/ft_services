# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    launch.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/02 15:24:00 by atrouill          #+#    #+#              #
#    Updated: 2020/12/09 16:16:42 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

openrc
touch /run/openrc/softlevel

sed -i "s|172.17.0.230|${LB_IP}|" /db_wordpress.sql

until mysqladmin -h mysql-svc.default.svc.cluster.local -u wp_user -p${MYSQL_WP_USERPASS} ping; do
	echo "⌛ Wait for mysql to be ready."
	sleep 1
done
mysql -h mysql-svc.default.svc.cluster.local -u wp_user -p${MYSQL_WP_USERPASS} db_wordpress < /db_wordpress.sql
sed -i "s|define( 'DB_PASSWORD'.*|define( 'DB_PASSWORD', '${MYSQL_WP_USERPASS}' );|" /www/wordpress/wp-config.php
mysql -h mysql-svc.default.svc.cluster.local -u wp_user -p${MYSQL_WP_USERPASS} -e "USE db_wordpress; UPDATE wp_users SET user_pass= MD5('${WP_ADMINPASS}') WHERE ID = 1;"


service php-fpm7 start
service nginx start

tail -F /var/log/nginx/access.log
