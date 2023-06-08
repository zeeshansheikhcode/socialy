import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart' as zego;

import '../../utils/utils.dart';
final String localUserID = math.Random().nextInt(10000).toString();
class CallPage extends StatelessWidget {
  final String callID;

  const CallPage({
    Key? key,
    required this.callID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: zego.ZegoUIKitPrebuiltCall(
        appID: Utils.appId,
        appSign: Utils.appSignin,
        userID: localUserID,
        userName: "Zeeshan",
        callID: callID,
        config: zego.ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..onOnlySelfInRoom = (context) {
            Navigator.of(context).pop();
          },
      ),
    );
  }
}