ROOM=$1
MEET=rendez-vous.renater.fr
docker run --mount type=bind,source="$(pwd)"/media,target=/media  gstmeet --video-codec=vp8 --room-name $ROOM --last-n=0 --web-socket-url wss://$MEET/xmpp-websocket?room=$ROOM --xmpp-domain=$MEET --verbose=0 --send-pipeline="filesrc location=/media/bbb25.webm ! queue max-size-time=200000 ! matroskademux name=demuxer  demuxer.video_0 ! queue max-size-time=10000 name=video demuxer.audio_0 ! queue max-size-time=10000 name=audio" --recv-pipeline-participant-template="queue max-size-time=1000 name=audio ! fakeaudiosink queue max-size-time=1000 name=video ! fakevideosink"
