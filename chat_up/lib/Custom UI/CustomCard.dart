import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Models/ChatModel.dart';
import '../Screens/ChatScreen.dart';
import '../core/model/user_model.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.chatModel});
  final ChatModel chatModel;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {

          },
          onLongPress: () {
            print("Long Pressed");
          },
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              child: SvgPicture.asset(
                chatModel.icon,
                color: Colors.white,
                height: 36,
                width: 36,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    chatModel.name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis, // Handles overflow
                    maxLines: 1,
                  ),
                ),
                Text(
                  chatModel.time,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.done),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    chatModel.currentMessage,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis, // Handles overflow
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 70, right: 20),
          child: Divider(
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
