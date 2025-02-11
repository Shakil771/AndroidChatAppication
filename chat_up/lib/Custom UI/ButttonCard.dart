import 'package:chat_up/Screens/NewGroupScreen.dart';
import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({super.key, required this.name, required this.icon, required this.pageName});
  final String name;
  final Widget icon;
  final NewGroup pageName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => pageName));
          },
          child: ListTile(
            leading: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.green,
              child: icon, // icon should be a Widget
            ),
            title: Text(name, style: TextStyle(fontSize: 14, color: Colors.white,),),
          ),
        ),
      ],
    );
  }
}
