import 'package:chat_up/Custom%20UI/CustomCard.dart';
import 'package:chat_up/Models/ChatModel.dart';
import 'package:chat_up/Pages/CameraPage.dart';
import 'package:chat_up/Screens/ContactScreen.dart';
import 'package:chat_up/core/theme/Colors.dart';
import 'package:flutter/material.dart';

class StatusHomePage extends StatefulWidget{
  const StatusHomePage({super.key});

  @override
  State<StatusHomePage> createState() => _StatusHomePageState();
}

class _StatusHomePageState extends State<StatusHomePage> {
  List<ChatModel> chats = [
    ChatModel(id: 1, name: "Md Shakil Hossain", icon: "assets/Icons/person.svg", currentMessage: "Hello Friend. How are yow pp pppppppppppppppppppppppppppppp hhhvff gfghvgf", isGroup: false, time: "10:02"),
    ChatModel(id: 2, name: "Mst. Rekha Khatun", icon: "assets/Icons/person.svg", currentMessage: "Hello Shakil...", isGroup: false, time: "11:52"),
    ChatModel(id:3, name: "ChatUp", icon: "assets/Icons/groups.svg", currentMessage: "Hi Everyone...", isGroup: true, time: "10:02"),
    ChatModel(id:4, name: "Md. Raju Ahmed", icon: "assets/Icons/person.svg", currentMessage: "Hello Shakil...", isGroup: false, time: "11:52")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemBuilder: (BuildContext context, index)=>CustomCard(chatModel: chats[index]),
        itemCount: chats.length,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // WhatsApp-style color
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactPage()), // Replace with actual contact page
          );
        },
        child: const Icon(Icons.edit, color: Colors.white), // WhatsApp-style "+" icon
      ),
    );
  }
}