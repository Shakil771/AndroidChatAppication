
import 'package:chat_up/Models/ChatModel.dart';
import 'package:chat_up/Screens/ContactScreen.dart';
import 'package:flutter/material.dart';

class ChatHomePage extends StatefulWidget{
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  List<ChatModel> chats = [
    ChatModel(id: 1, name: "Md Shakil Hossain", icon: "assets/Icons/person.svg", currentMessage: "Hello Friend. How are yow pp pppppppppppppppppppppppppppppp hhhvff gfghvgf", isGroup: false, time: "10:02"),
    ChatModel(id: 2, name: "Mst. Rekha Khatun", icon: "assets/Icons/person.svg", currentMessage: "Hello Shakil...", isGroup: false, time: "11:52"),
    ChatModel(id:3, name: "ChatUp", icon: "assets/Icons/groups.svg", currentMessage: "Hi Everyone...", isGroup: true, time: "10:02"),
    ChatModel(id:4, name: "Md. Raju Ahmed", icon: "assets/Icons/person.svg", currentMessage: "Hello Shakil...", isGroup: false, time: "11:52")
  ];

  navigateToContactScreen(context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactPage()), // Replace with actual contact page
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Chat")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // WhatsApp-style color
        onPressed: () => navigateToContactScreen(context),
        child: const Icon(Icons.message, color: Colors.white), // WhatsApp-style "+" icon
      ),
    );
  }
}