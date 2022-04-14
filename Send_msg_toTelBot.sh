#!/usr/bin/bash

telegram_bot_token="PUT_HERE_BOT_TOKEN_BY_BOTFATHER"
telegram_chat_id="PUT_HERE_CHAT_ID"

Title="$1"
Message="$2"

curl -s \
 --data parse_mode=HTML \
 --data chat_id=${telegram_chat_id} \
 --data text="<b>${Title}</b>%0A${Message}" \
 --request POST https://api.telegram.org/bot${telegram_bot_token}/sendMessage
