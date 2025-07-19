import 'package:flutter/material.dart';

import '../view/widgets/build_smart_coach_message_widget.dart';
import 'message.dart';

class SmartCoachMessage extends Message {
  const SmartCoachMessage(super.content);

  @override
  Widget buildMessageWidget() => BuildSmartCoachMessageWidget(message: content);
}
