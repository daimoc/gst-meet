#!/bin/bash
SERVER_NAME="rendez-vous.renater.fr"
ROOM_NAME="bob0"
target/release/gst-meet --room-name=$ROOM_NAME \
   --web-socket-url=wss://$SERVER_NAME/xmpp-websocket?room=$ROOM_NAME \
   --xmpp-domain=$SERVER_NAME  \
   --focus-jid=focus.$SERVER_NAME \
   --verbose=2 \
   --send-pipeline="filesrc location=/vagrant/bbb25.webm ! queue ! matroskademux name=demuxer
                      demuxer.video_0 ! queue name=video
                      demuxer.audio_0 ! queue name=audio"
