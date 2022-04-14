# solana-delinquent-checker
Solana Node delinquent status chceker

Shell script that uses Solana and Telegram REST API to check Solana node's health.

## Why?
Once it happened to my Node that all process and port were up and there were no notification from my monitoring scripts that something is wrong, but Node went to "Delinquent" status. Fortunately my other script (https://github.com/b0br0ff/solana-info-2-telegram.git) has given me a hint and I was able to perform corrective actions on time. 

## Installation
1. Create a Telegram bot using @BotFather or use chat id and token from existing one;
2. Install dependencies if needed: 
```
sudo apt install bc jq -y
```
4. Clone project: 
```
git clone https://github.com/b0br0ff/solana-delinquent-checker.git
cd solana-delinquent-checker/
chmod +x *.sh
```
5. Edit script Send_msg_toTelBot.sh and set constants below according to your Telegram bot: 
```
telegram_bot_token="PUT_HERE_BOT_TOKEN_BY_BOTFATHER"
telegram_chat_id="PUT_HERE_CHAT_ID"
```

6. Edit script check-node.sh and set account IDs according to your node:
```
NODE_NAME=PUT_HERE_NODE_NAME"
VOTE_ACC="PUT_HERE_YOUR_NODE_VOTE_ACCOUNT"

#By default script uses following endpoint to query information for mainnetbeta node, you can change it to use in testnet, or even to work witj local RPC (http://localhost:8899):
API_URL="https://api.mainnet-beta.solana.com"
```

## Update
```
cd $HOME/solana-delinquent-checker/
git pull
```

## Usage
Most simple way is to schedule the execution in the cron, below you can see example from my system, it is executed every 5 minutes:

```
crontab -l
* */5 * * * cd /home/<YOUR_USER>/solana-info-2-telegram; ./solana-delinquent-checkere.sh
```

Have a fun with Solana validation!

## PS
Script called Send_msg_toTelBot.sh is not written by me, I just modified it a little bit existing one, sorry completely forgot who is the author.
