docker run --mount type=bind,source="$(pwd)"/media,target=/media  gstmeet --video-codec=vp8 --room-name bob0 --web-socket-url wss://rendez-vous.renater.fr/xmpp-websocket?room=bob0 --xmpp-domain=rendez-vous.renater.fr --verbose=3 --send-pipeline="filesrc location=/media/bbb25.webm ! queue max-size-time=200000 ! matroskademux name=demuxer  demuxer.video_0 ! queue max-size-time=100000 name=video demuxer.audio_0 ! queue max-size-time=100000 name=audio" --recv-pipeline-participant-template="webmmux name=muxer ! queue ! filesink location=/media/{participant_id}.webm opusenc name=audio ! muxer.audio_0 vp9enc name=video ! muxer.video_0"
