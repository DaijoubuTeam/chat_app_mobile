import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_repository/socket_repository.dart';
import 'package:webrtc_repository/webrtc_repository.dart';

typedef StreamStateCallback = void Function(MediaStream stream);

class Signaling {
  static Signaling _signaling = Signaling._internal();

  factory Signaling() {
    return _signaling;
  }

  Signaling._internal();

  Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302',
        ]
        // {
        //   'url': 'stun:stun1.l.google.com:19302',
        // },
        // {
        //   'url': 'stun:stun2.l.google.com:19302',
        // },
        // {
        //   'url': "turn:openrelay.metered.ca:80",
        //   'username': "openrelayproject",
        //   'credential': "openrelayproject",
        // },
        // {
        //   'urls': "turn:openrelay.metered.ca:443",
        //   'username'
        //       'credential': "openrelayproject",
        // },
        // {
        //   'urls': "turn:openrelay.metered.ca:443?transport=tcp",
        //   'username': "openrelayproject",
        //   'credential': "openrelayproject",
        // },
      }
    ]
  };

  WebRTCRepostiory? _webRTCRepostiory;
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;

  StreamStateCallback? onAddRemoteStream;
  Function? closeVideoRenderer;

  void setWebRTCRepository(WebRTCRepostiory webRTCRepostiory) {
    _webRTCRepostiory = webRTCRepostiory;
  }

  Future<void> inviteCall(
    String bearerToken,
    String friendId,
  ) async {
    final data = {"type": "invite"};
    _webRTCRepostiory?.postWebRTC(bearerToken, friendId, data);
  }

  Future<void> createRoom(
    MediaStream? localMediaStream,
    MediaStream? remoteMediaStream,
    String bearerToken,
    String friendId,
  ) async {
    debugPrint('Create PeerConnection with configuration: $configuration');
    peerConnection = await createPeerConnection({...configuration});
    setupICEConnection(peerConnection, bearerToken, friendId);

    registerPeerConnection();

    if (localMediaStream != null) {
      localStream = localMediaStream;
    }

    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    peerConnection?.onIceCandidate = (RTCIceCandidate candidate) => {
          _webRTCRepostiory?.postWebRTC(bearerToken, friendId,
              {'type': 'icecandidate', 'data': candidate.toMap()}),
        };

    //create offer
    RTCSessionDescription offer = await peerConnection!.createOffer();
    await peerConnection!.setLocalDescription(offer);

    peerConnection?.onTrack = (RTCTrackEvent event) {
      createLocalMediaStream('remote-renderer').then((newRemoteStream) {
        event.streams[0].getTracks().forEach((track) {
          newRemoteStream.addTrack(track);
        });
        if (onAddRemoteStream != null) {
          onAddRemoteStream!(newRemoteStream);
        }
      });
    };

    _webRTCRepostiory?.postWebRTC(bearerToken, friendId, offer.toMap());

    // receiver answer and save peerConnection
    SocketAPI.socketApi.webRTCStream.stream.listen((data) async {
      if (data["data"]["type"] == "answer") {
        var answer = RTCSessionDescription(
          data['data']['sdp'],
          data['data']['type'],
        );
        if (peerConnection?.signalingState !=
            RTCSignalingState.RTCSignalingStateStable) {
          await peerConnection?.setRemoteDescription(answer);
        }
      }
    });
  }

  Future<void> joinRoom(
    dynamic data,
    MediaStream? localMediaStream,
    MediaStream? remoteMediaStream,
    String bearerToken,
    String friendId,
  ) async {
    peerConnection = await createPeerConnection(configuration);

    registerPeerConnection();

    if (localMediaStream != null) {
      localStream = localMediaStream;
    }

    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    peerConnection?.onTrack = (RTCTrackEvent event) {
      createLocalMediaStream('remote-renderer').then((newRemoteStream) {
        print("newRemoteStream");
        event.streams[0].getTracks().forEach((track) {
          newRemoteStream.addTrack(track);
        });
        if (onAddRemoteStream != null) {
          onAddRemoteStream!(newRemoteStream);
        }
      });
    };

    // Code for creating SDP answer below
    await peerConnection?.setRemoteDescription(
      RTCSessionDescription(data['sdp'], data['type']),
    );

    setupICEConnection(peerConnection, bearerToken, friendId);

    var answer = await peerConnection!.createAnswer();

    await peerConnection!.setLocalDescription(answer);

    // Finished creating SDP answer
    _webRTCRepostiory?.postWebRTC(bearerToken, friendId, answer.toMap());

    peerConnection?.onIceCandidate = (RTCIceCandidate candidate) => {
          _webRTCRepostiory?.postWebRTC(bearerToken, friendId,
              {'type': 'icecandidate', 'data': candidate.toMap()}),
        };
  }

  void hangUp() {
    if (closeVideoRenderer != null) {
      closeVideoRenderer!();
    }
    if (peerConnection != null) {
      peerConnection!.close();
      peerConnection = null;
    }
    _signaling = Signaling._internal();
  }

  void setupICEConnection(
    RTCPeerConnection? rtcPeerConnection,
    String bearerToken,
    String friendId,
  ) {
    SocketAPI.socketApi.webRTCStream.stream.listen((data) {
      if (data["data"]["type"] == 'icecandidate') {
        final candidate = data["data"]["data"];
        peerConnection?.addCandidate(RTCIceCandidate(
          candidate['candidate'],
          candidate['sdpMid'],
          candidate['sdpMLineIndex'],
        ));
      }
    });
  }

  void registerPeerConnection() {
    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      log('ICE gathering state changed: $state');
    };

    peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      // log('Connection state change: $state');
    };

    peerConnection?.onSignalingState = (RTCSignalingState state) {
      log('Signaling state change: $state');
    };

    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      log('ICE connection state change: $state');
    };

    peerConnection?.onAddStream = (MediaStream stream) {
      log("Add remote stream");
      // onAddRemoteStream?.call(stream);
      // remoteStream = stream;
    };
  }
}
