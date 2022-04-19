#!/usr/bin/bash
# Author: b0br0ff
# Prereqs: jq

DEBUG=0

IDS_FILE="node.ids"

# Icons for telegram bot
OK_ICON=`echo -e '\U0002705'`
NOK_ICON=`echo -e '\U000274C'`


function get_node_status(){
        local NODE_ID="$1"
        local API_URL="$2"
        local STAKE_TOTAL_JSON=$(curl --connect-timeout 3 --silent -X POST ${API_URL} -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","id":1, "method":"getVoteAccounts", "params": [{ "votePubkey": "'${NODE_ID}'" } ]}')
        local DELINQUENT_NODE=$(echo ${STAKE_TOTAL_JSON}  | jq '.result.delinquent[].nodePubkey')
        echo "${DELINQUENT_NODE}"
}


cat ${IDS_FILE} | while read NODE_LINE
do
   echo "Processing Node: ${NODE_LINE}"
   NODE_ID="$(echo ${NODE_LINE} | cut -d ',' -f1)"
   NODE_NAME="$(echo ${NODE_LINE} | cut -d ',' -f2)"
   CLUSTER="$(echo ${NODE_LINE} | cut -d ',' -f3)"
   API_URL="https://api.testnet.solana.com"

   if [ "${CLUSTER}" == "mainnet" ]; then
      API_URL="https://api.mainnet-beta.solana.com"
   fi

   NODE_STATUS=$(get_node_status ${NODE_ID} ${API_URL})

   if [ "$DEBUG" -eq 1 ]; then
      echo "Node ID: ${NODE_ID}"
      echo "Node Name: ${NODE_NAME}"
      echo "Cluster: ${CLUSTER}"
      echo "API url: ${API_URL}"
      echo "Delinquent = ${NODE_STATUS}"
   fi

   if [ "${NODE_STATUS}" != "" ]; then
        ./Send_msg_toTelBot.sh "${NOK_ICON} ${NODE_NAME} (${CLUSTER})" "Node is Delinquent!"
        echo "Node ${NODE_STATUS} is Delinquent!"
   else
       if [ "$DEBUG" -eq 1 ]; then
          ./Send_msg_toTelBot.sh "${OK_ICON} ${NODE_NAME} (${CLUSTER})" "Node is NOT Delinquent"
       fi
       echo "Node ${NODE_STATUS} is ok!"
   fi
done
