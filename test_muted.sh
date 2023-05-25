ROOM=$1
MEET=rendez-vous.renater.fr
docker run --mount type=bind,source="$(pwd)"/media,target=/media  gst-meet --video-codec=vp8 --room-name $ROOM --last-n=0 --web-socket-url wss://$MEET/xmpp-websocket?room=$ROOM --xmpp-domain=$MEET --verbose=0 --recv-pipeline-participant-template="queue max-size-time=1000 name=audio ! fakeaudiosink queue max-size-time=1000 name=video ! fakevideosink"
