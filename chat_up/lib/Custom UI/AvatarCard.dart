import 'package:chat_up/Models/ChatModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AvatarCard extends StatelessWidget {
  final ChatModel contact;

  const AvatarCard({super.key, required this.contact});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.green,
                child: SvgPicture.asset(
                  contact.icon,
                  color: Colors.black,
                  height: 30,
                  width: 30,
                ),
              ),
              contact.select
                  ? const Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 8,
                          backgroundColor: Colors.grey,
                          child: Icon(
                        Icons.clear,
                        size: 15,
                        color: Colors.white,
                      )))
                  : const SizedBox()
            ],
          ),
          Text(
            contact.name.length > 10
                ? '${contact.name.substring(0, 7)}...'
                : contact.name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
