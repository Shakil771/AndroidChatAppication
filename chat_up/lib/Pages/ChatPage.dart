import 'package:chat_up/Custom%20UI/CustomCard.dart';
import 'package:chat_up/Models/ChatModel.dart';
import 'package:chat_up/Pages/CameraPage.dart';
import 'package:chat_up/Screens/SelectContactScreen.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget{
  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  List<ChatModel> chats = [
    ChatModel(id: 1, name: "Md Shakil Hossain", icon: "assets/Icons/person.svg", currentMessage: "Hello Friend. How are yow pp pppppppppppppppppppppppppppppp hhhvff gfghvgf", isGroup: false, time: "10:02"),
    ChatModel(id: 2, name: "Mst. Rekha Khatun", icon: "assets/Icons/person.svg", currentMessage: "Hello Shakil...", isGroup: false, time: "11:52"),
    ChatModel(id:3, name: "ChatUp", icon: "assets/Icons/groups.svg", currentMessage: "Hi Everyone...", isGroup: true, time: "10:02"),
    ChatModel(id:4, name: "Md. Raju Ahmed", icon: "assets/Icons/person.svg", currentMessage: "Hello Shakil...", isGroup: false, time: "11:52")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("ChatUp", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage()));

          }, icon: const Icon(Icons.camera_alt_outlined), color: Colors.white),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search), color: Colors.white),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (String value) {
              // Handle menu selection
              print("Selected: $value");
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(value: "Option1", child: Text("Option 1")),
                const PopupMenuItem(value: "Option2", child: Text("Option 2")),
                const PopupMenuItem(value: "Option3", child: Text("Option 3")),
                const PopupMenuItem(value: "Option4", child: Text("Option 4")),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemBuilder: (BuildContext context, index)=>CustomCard(chatModel: chats[index]),
        itemCount: chats.length,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary, // WhatsApp-style color
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectContactScreen()), // Replace with actual contact page
          );
        },
        child: const Icon(Icons.message, color: Colors.white), // WhatsApp-style "+" icon
      ),
    );
  }
}