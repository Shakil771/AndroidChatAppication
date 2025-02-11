import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Models/ChatModel.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact});
  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white70,
                child: SvgPicture.asset(
                  contact.icon,
                  color: Colors.black,
                  height: 30,
                  width: 30,
                ),
              ),
               contact.select? const Positioned(
                right: 0,
                  bottom: -2,
                  child: Icon(Icons.check_circle, size: 18, color: Colors.green,)
              ):const SizedBox()

            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  contact.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis, // Handles overflow
                  maxLines: 1,
                ),
              ),
            ],
          ),
          subtitle: Text(
            contact.currentMessage,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}
