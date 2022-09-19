


docker run --rm --mount type=bind,source="$(pwd)"/media,target=/app  gstmeet --room-name bob --web-socket-url wss://rendez-vous.renater.fr/xmpp-websocket --xmpp-domain=rendez-vous.renater.fr --verbose=2 --send-pipeline="filesrc location=/app/bbb25.webm ! queue ! matroskademux name=demuxer demuxer.video_0 ! queue name=video  demuxer.audio_0 ! queue ! vorbisdec ! audioconvert ! audioresample ! opusenc name=audio"



docker run --rm --mount type=bind,source="$(pwd)"/media,target=/app  gst-meet:lastest



docker run --rm --mount type=bind,source="$(pwd)"/media,target=/app --env GST_DEBUG=3 gstmeet --room-name bob --web-socket-url wss://meet.jit.si/xmpp-websocket?room=bob --xmpp-domain=meet.jit.si --verbose=3 --video-codec=vp8 --send-pipeline="filesrc location=/app/bbb25.webm ! queue ! matroskademux name=demuxer demuxer.video_0 ! queue name=video  demuxer.audio_0 ! queue name=audio"



docker run --rm --mount type=bind,source="$(pwd)"/media,target=/app --env GST_DEBUG=3 gstmeet --room-name bob --web-socket-url wss://rendez-vous.renater.fr/xmpp-websocket?room=bob --xmpp-domain=rendez-vous.renater.fr --verbose=3 --video-codec=vp8 --send-pipeline="filesrc location=/app/bbb25.webm ! queue ! matroskademux name=demuxer demuxer.video_0 ! queue name=video  demuxer.audio_0 ! queue name=audio"

docker run --rm --mount type=bind,source="$(pwd)"/media,target=/app --env GST_DEBUG=3 gstmeet --room-name bob --web-socket-url wss://meeting.education/xmpp-websocket?room=bob --xmpp-domain=meeting.education --verbose=3 --video-codec=vp8 --send-pipeline="filesrc location=/app/bbb25.webm ! queue ! matroskademux name=demuxer demuxer.video_0 ! queue name=video  demuxer.audio_0 ! queue name=audio"
  