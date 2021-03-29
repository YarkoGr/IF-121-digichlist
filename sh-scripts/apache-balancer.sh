#!/bin/bash
backend1="$1";
backend2="$2";
echo "---------- install apache2---------------"
sudo apt update;
sudo apt install apache2 -y;
echo "-----------enable mods-------------------"
sudo a2enmod rewrite;
sudo a2enmod proxy;
sudo a2enmod proxy_http;
sudo a2enmod proxy_balancer;
sudo a2enmod lbmethod_byrequests;
echo "-----------change  /etc/apache2/sites-enabled/000-default.conf-------------------"
sudo cat <<EOF > /etc/apache2/sites-enabled/000-default.conf
<VirtualHost *:80>

	<Proxy balancer://mycluster>
		BalancerMember http://$backend1:5000
		BalancerMember http://$backend2:5000
	</Proxy>

	ProxyPreserveHost On
	ProxyPass /balancer-manager !	
	ProxyPass / balancer://mycluster/
	ProxyPassReverse / balancer://mycluster/

	<Location /balancer-manager>
		SetHandler balancer-manager
	</Location>
	
	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/html

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
EOF
sudo systemctl restart apache2;
