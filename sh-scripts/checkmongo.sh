#!/bin/bash
#------------check is mongo runing
#!/bin/bash
#mongo --eval "db.stats()"  # do a simple harmless command of some sort

#RESULT=$?   # returns 0 if mongo eval succeeds

#if [ $RESULT -ne 0 ]; then
#    echo "mongodb not running"
#    exit 1
#else
#    echo "mongodb running!"
#fi
#----------------------------------------------------------------------
# mongo --eval "db.stats()"
# RESULT=$?
# while [ $RESULT -le 0 ]
# do
# echo "mongodb not runnin"
# sleep 1
# done
# mongo <<-EOF
# use apip;
# db.admins.insertOne({email:"test@telebot.if.ua", password:"$2b$12$2TpCCou3eWo7zcUr5j8.fOb0WebINBknt.PVj.a9xvrvK5S6ynaci", username:"testadmin"});
# exit
# EOF
# echo "mongodb running!"