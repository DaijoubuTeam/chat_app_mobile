import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:webrtc_repository/webrtc_repository.dart';

typedef StreamStateCallback = void Function(MediaStream stream);

class Signaling {
  static final Signaling _signaling = Signaling._internal();

  factory Signaling() {
    return _signaling;
  }

  Signaling._internal();

  Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302'
        ]
      }
    ]
  };

  WebRTCRepostiory? _webRTCRepostiory;
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;

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
    peerConnection = await createPeerConnection(configuration);

    registerPeerConnection();

    if (localMediaStream != null) {
      localStream = localMediaStream;
    }

    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    //candidate ice
    // get candidate from ice and upload it to firebase
    peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      debugPrint('Got candidate: ${candidate.toMap()}');
    };

    //create offer
    RTCSessionDescription offer = await peerConnection!.createOffer();
    await peerConnection!.setLocalDescription(offer);
    print('Created offer: $offer');

    // Created a Room
    peerConnection?.onTrack = (RTCTrackEvent event) {
      print('Got remote track: ${event.streams[0]}');

      event.streams[0].getTracks().forEach((track) {
        print('Add a track to the remoteStream $track');
        remoteMediaStream?.addTrack(track);
      });
    };

    _webRTCRepostiory?.postWebRTC(bearerToken, friendId, offer.toMap());
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

    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    peerConnection?.onTrack = (RTCTrackEvent event) {
      event.streams[0].getTracks().forEach((track) {
        remoteMediaStream?.addTrack(track);
      });
    };

    // Code for creating SDP answer below
    await peerConnection?.setRemoteDescription(
      RTCSessionDescription(data['sdp'], data['type']),
    );

    var answer = await peerConnection!.createAnswer();
    print('Created Answer $answer');

    await peerConnection!.setLocalDescription(answer);

    // Finished creating SDP answer
    _webRTCRepostiory?.postWebRTC(bearerToken, friendId, answer.toMap());
  }

  void registerPeerConnection() {
    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      log('ICE gathering state changed: $state');
    };

    peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      log('Connection state change: $state');
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
