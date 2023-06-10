import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart' as zego;

import '../../../utils/utils.dart';


final userId = math.Random().nextInt(10000).toString();
class AudioCallingPage extends StatelessWidget {
  final String callingId ;
  const AudioCallingPage({Key? key, required this.callingId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: zego.ZegoUIKitPrebuiltCall(
          appID: Utils.appId ,
          appSign: Utils.appSignin,
          userID: userId,
          callID: callingId,
          config: zego.ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
          ..onOnlySelfInRoom = (context){
            Navigator.pop(context);
          },
          userName: 'Zeeshan',
        )
    );
  }
}