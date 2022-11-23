import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final message;

  const MessageDisplay({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Text(message),
    );
  }
}
