#!/bin/bash
host_db="$1";
echo "------------install mongodb"
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -;
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list;
sudo apt update;
sudo apt install mongodb-org -y;
sudo systemctl start mongod.service;
#sudo systemctl status mongod
sudo systemctl enable mongod;
echo "-----------Create mongo chek is run-------------------";
mongo --eval "db.stats()"
RESULT=$?
while [ $RESULT -le 1 ] 
do
 sleep 10
 echo "mongo is not run"
 mongo --eval "db.stats()"
 RESULT=$?
    if [ $RESULT -ne 1 ]; then
    break
    fi
done
#--------------------------------------------
echo "-----------Add admin to mongo-------------------";
mongo <<-EOF
use app;
db.admins.insertOne({email:"test@telebot.if.ua", password:"$2b$12$2TpCCou3eWo7zcUr5j8.fOb0WebINBknt.PVj.a9xvrvK5S6ynaci", username:"testadmin"});
db.admins.insertOne({email:"yarko@telebot.if.ua", password:"$2a$12$LI3eJPSTICNWKQCtW9oIKuEI25yO.i4Ov.HVvLDe.RceRnMn5sJre", username:"yarkoadmin"});
db.admins.insertOne({email:"yarko@i.ua", password:"$2a$12$dA7B2IQM1x8WpE91FzlOa.FH62FyfzJLQQWns8kqRZCOYRA8TQNxG", username:"yarkoadm"});
exit
EOF
#----------------------------------------------------
echo "-----------cofig  /etc/mongod.conf-------------------";
sudo sed -i 's|bindIp: 127.0.0.1|bindIp: 127.0.0.1,'$host_db'|g' /etc/mongod.conf
sudo systemctl restart mongod.service;