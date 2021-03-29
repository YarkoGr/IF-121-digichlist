#!/bin/bash
#git clone from repo backend part
sudo git clone https://github.com/theyurkovskiy/digichlist-api.git;
#install nodejs
sudo apt update;
sudo curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -;
sudo apt -y install nodejs;
cd digichlist-api/;
echo "-----------set enviromets------------------------"
export NODE_ENV=production
export JWT=sometext
export PORT=5000
export MONGO_URI="mongodb://20.0.0.100/app"
echo "----------------set ENV---------------"
sudo cat <<EOF >> /home/ubuntu/scr.sh
#!/bin/bash
export NODE_ENV=production
export JWT=sometext
export PORT=5000
export MONGO_URI="mongodb://20.0.0.100/app" 
EOF
sudo chmod +x /home/ubuntu/scr.sh
. ./home/ubuntu/scr.sh
source /home/ubuntuscr.sh
sudo npm install;
sudo npm install pm2 -g;
pm2 start /home/ubuntu/digichlist-api/server.js
pm2 startup
