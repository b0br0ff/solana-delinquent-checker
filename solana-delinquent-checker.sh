#!/usr/bin/bash
# Author: b0br0ff
# Prereqs: jq

DEBUG=1

### Initialize variables below with your data
NODE_NAME="<NODE_NAME>"
VOTE_ACC="<VOTE_ACCOUNT_IDENTITY>"

API_URL="https://api.mainnet-beta.solana.com"
#API_URL="https://api.testnet.solana.com"
#API_URL="http://localhost:8899"


# Icons for telegram bot
OK_ICON=`echo -e '\U0002705'`
NOK_ICON=`echo -e '\U000274C'`

# Get total stake
STAKE_TOTAL_JSON=$(curl --silent -X POST ${API_URL} -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","id":1, "method":"getVoteAccounts", "params": [{ "votePubkey": "'${VOTE_ACC}'" } ]}')

#Get delinquent
DELINQUENT_NODE=$(echo ${STAKE_TOTAL_JSON}  | jq '.result.delinquent[].nodePubkey')

# Debug info
if [ "$DEBUG" -eq 1 ]; then
        echo "Delinquent status = ${DELINQUENT_NODE}"
fi

if [ "${DELINQUENT_NODE}" != "" ]; then
   ./Send_msg_toTelBot.sh "${NOK_ICON} ${NODE_NAME} Info ${NOK_ICON}" "%0ANode is Delinquent: ${DELINQUENT_NODE}"
#else
#   ./Send_msg_toTelBot.sh "${OK_ICON} ${NODE_NAME} Info ${OK_ICON}" "%0ANode is OK (test)"
fi
