#!/bin/bash
SERVER_NAME="preprod-rendez-vous.renater.fr"
ROOM_NAME="bob0"
target/release/gst-meet --room-name=$ROOM_NAME \
   --web-socket-url=wss://$SERVER_NAME/xmpp-websocket?room=$ROOM_NAME \
   --xmpp-domain=$SERVER_NAME  \
   --focus-jid=focus.$SERVER_NAME \
