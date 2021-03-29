#!/bin/bash
balancer="$1";
#install apache
sudo apt update
sudo apt install apache2 -y
#npm install
sudo apt install npm -y
#git clone front end part
sudo git clone https://github.com/theyurkovskiy/digichlist-Admin-UI.git
cd digichlist-Admin-UI/
sudo npm install
sudo npm run build
sudo rm /var/www/html/index.html
sudo cp -R /home/ubuntu/digichlist-Admin-UI/build/. /var/www/html/
sudo sed -i 's|https://digichlist-api.herokuapp.com|http://'$balancer'|g' /var/www/html/static/js/main.*.js
sudo a2enmod rewrite
sudo systemctl restart apache2
