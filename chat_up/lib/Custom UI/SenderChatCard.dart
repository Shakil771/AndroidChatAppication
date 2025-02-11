

import 'package:flutter/material.dart';

class SenderChat extends StatefulWidget{
  @override
  State<SenderChat> createState() => _SenderChatState();
}

class _SenderChatState extends State<SenderChat> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      
      child: Container(
        width: MediaQuery.of(context).size.width-70,

      ),
    );
  }
}