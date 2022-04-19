# solana-delinquent-checker
Solana Node delinquent status chceker

Shell script that uses Solana and Telegram REST API to check Solana node's health.

## Why?
Once it happened to my Node that all process and port were up and there were no notification from my monitoring scripts that something is wrong, but Node went to "Delinquent" status. Fortunately my other script (https://github.com/b0br0ff/solana-info-2-telegram.git) has given me a hint and I was able to perform corrective actions on time. 

Example of the provided information:
![alt text](https://github.com/b0br0ff/solana-delinquent-checker/blob/main/delinquent.JPG)

## Installation
1. Create a Telegram bot using @BotFather or use chat id and token from existing one;
2. Install dependencies if needed: 
```
sudo apt install jq -y
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

6. Edit file node.ids and set account IDs according to your nodes. You can add as many nodes as you want:
```
<PUT_HERE_TEST_VOTE_ACC>,TEST-SRV,testnet
<PUT_HERE_MAIN_VOTE_ACC>,MAIN-SRV,mainnet
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
*/5 * * * * cd /home/<YOUR_USER>/solana-delinquent-checker; ./solana-delinquent-checker.sh
```

Have a fun with Solana validation!

## PS
Script called Send_msg_toTelBot.sh is not written by me, I just modified it a little bit existing one, sorry completely forgot who is the author.
