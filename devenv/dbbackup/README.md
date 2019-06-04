sudo mongoexport -d alphacar -c credit_inquiry -o ./credit_inquiry.json --type json --host dds-uf629187df12b8041.mongodb.rds.aliyuncs.com:3717 -u root --authenticationDatabase admin -p QJHvcW10OzhjWP6vnzfVJ0QI 

sudo mongoexport -d alphacar -c reward_record -o ./reward_record.json --type json
