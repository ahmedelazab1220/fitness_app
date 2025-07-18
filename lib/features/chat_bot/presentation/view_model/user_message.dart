import 'package:flutter/material.dart';

import '../view/widgets/build_user_message_widget.dart';
import 'message.dart';

class UserMessage extends Message {
  const UserMessage(super.content);
  @override
  Widget buildMessageWidget() => BuildUserMessageWidget(message: content);
}
