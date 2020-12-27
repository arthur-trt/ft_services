# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    launch.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/02 15:24:00 by atrouill          #+#    #+#              #
#    Updated: 2020/12/14 16:06:01 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

openrc
touch /run/openrc/softlevel

if [[ -f "server.crt" && -f "server.key" ]]; then
	mv server.crt /etc/ssl/certs/server.crt
	mv server.key /etc/ssl/private/server.key
fi

sed -i "s|max_execution_time =.*|max_execution_time = 0|" /etc/php7/php.ini
sed -i "s|max_input_time =.*|max_input_time = -1|" /etc/php7/php.ini
sed -i "s|memory_limit =.*|memory_limit = 2G|" /etc/php7/php.ini


awk -v VAR="$(echo ${LB_IP} | tr -d '\n')" '{gsub(/LB_IP/,VAR)}1' /db_wordpress.sql.template > /db_wordpress.sql

until mysql -h mysql-svc.default.svc.cluster.local -u wp_user -p${MYSQL_WP_USERPASS} -e '\q' &> /dev/null; do
	echo "⌛ Wait for mysql to be ready."
	sleep 1
done
mysql -h mysql-svc.default.svc.cluster.local -u wp_user -p${MYSQL_WP_USERPASS} db_wordpress < /db_wordpress.sql
sed -i "s|define( 'DB_PASSWORD'.*|define( 'DB_PASSWORD', '${MYSQL_WP_USERPASS}' );|" /www/wordpress/wp-config.php
mysql -h mysql-svc.default.svc.cluster.local -u wp_user -p${MYSQL_WP_USERPASS} -e "USE db_wordpress; UPDATE wp_users SET user_pass= MD5('${WP_ADMINPASS}') WHERE ID = 1;"


service php-fpm7 start
service nginx start

tail -F /var/log/nginx/access.log
