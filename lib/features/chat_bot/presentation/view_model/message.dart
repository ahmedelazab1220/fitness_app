import 'package:flutter/material.dart';

abstract class Message {
  final String content;
  Widget buildMessageWidget();
  const Message(this.content);
}
