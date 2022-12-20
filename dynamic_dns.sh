#!/bin/bash

#Variable Declaration - Change These
HOSTED_ZONE_ID=("zone_id_1" "zone_id_2")
NAME="jarvisirl.click."
HZS_TO_CHANGE=("jarvisirl.click" "odeonx.ca")
TYPE="A"
TTL=300

#get current IP address
IP=$(curl http://checkip.amazonaws.com/)

#validate IP address (makes sure Route 53 doesn't get updated with a malformed payload)
if [[ ! $IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        exit 1
fi

#get current
#aws route53 list-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID | \
#jq -r '.ResourceRecordSets[] | select (.Name == "'"$NAME"'") | select (.Type == "'"$TYPE"'") | .ResourceRecords[0].Value' > ./current_route53_value

cat ./current_route53_value

#check if IP is different from Route 53
if grep -Fxq "$IP" ./current_route53_value; then
        echo "IP Has Not Changed, Exiting"
        exit 1
fi


echo "IP Changed, Updating Records"

#prepare route 53 payload
for i in ${!HZS_TO_CHANGE[@]}; do
cat > ./route53_changes.json << EOF
    {
      "Comment":"Updated From DDNS Shell Script",
      "Changes":[
        {
          "Action":"UPSERT",
          "ResourceRecordSet":{
            "ResourceRecords":[
              {
                "Value":"$IP"
              }
            ],
            "Name":"${HZS_TO_CHANGE[$i]}",
            "Type":"$TYPE",
            "TTL":$TTL
          }
        }
      ]
    }
EOF

#update records
aws route53 change-resource-record-sets --hosted-zone-id ${HOSTED_ZONE_ID[$i]} --change-batch file://./route53_changes.json >> /dev/null

#Update current
aws route53 list-resource-record-sets --hosted-zone-id ${HOSTED_ZONE_ID[$i]} | \
jq -r '.ResourceRecordSets[] | select (.Name == "'"$NAME"'") | select (.Type == "'"$TYPE"'") | .ResourceRecords[0].Value' > ./current_route53_value
done
