import 'package:chat_up/Custom%20UI/ButttonCard.dart';
import 'package:chat_up/Screens/IndividualChatScreen.dart';
import 'package:chat_up/Screens/NewGroupScreen.dart';
import 'package:flutter/material.dart';

import '../Custom UI/ContactCard.dart';
import '../Models/ChatModel.dart';

class SelectContactScreen extends StatefulWidget {
  const SelectContactScreen({super.key});

  @override
  State<SelectContactScreen> createState() => _SelectContactScreenState();
}

class _SelectContactScreenState extends State<SelectContactScreen> {
  List<ChatModel> chats = [
    ChatModel(
        id: 1,
        name: "Md Shakil Hossain",
        icon: "assets/Icons/person.svg",
        currentMessage: "Hey there! I am using ChatUp",
        isGroup: false,
        time: "10:02"),
    ChatModel(
        id: 1,
        name: "Mst. Rekha Khatun",
        icon: "assets/Icons/person.svg",
        currentMessage: "Hey there! I am using ChatUp",
        isGroup: false,
        time: "11:52"),
    ChatModel(
        id: 1,
        name: "ChatUp",
        icon: "assets/Icons/person.svg",
        currentMessage: "Hey there! I am using ChatUp",
        isGroup: true,
        time: "10:02"),
    ChatModel(
        id: 1,
        name: "Md. Raju Ahmed",
        icon: "assets/Icons/person.svg",
        currentMessage: "Hey there! I am using ChatUp",
        isGroup: false,
        time: "11:52"),
    ChatModel(
        id: 1,
        name: "Md Shakil Hossain",
        icon: "assets/Icons/person.svg",
        currentMessage: "Hey there! I am using ChatUp",
        isGroup: false,
        time: "10:02"),
    ChatModel(
        id: 1,
        name: "Mst. Rekha Khatun",
        icon: "assets/Icons/person.svg",
        currentMessage: "Hey there! I am using ChatUp",
        isGroup: false,
        time: "11:52"),
    ChatModel(
        id: 1,
        name: "ChatUp",
        icon: "assets/Icons/person.svg",
        currentMessage: "Hey there! I am using ChatUp",
        isGroup: true,
        time: "10:02"),
    ChatModel(
        id: 1,
        name: "Md. Raju Ahmed",
        icon: "assets/Icons/person.svg",
        currentMessage: "Hey there! I am using ChatUp",
        isGroup: false,
        time: "11:52"),
    ChatModel(
        id: 1,
        name: "Md Shakil Hossain",
        icon: "assets/Icons/person.svg",
        currentMessage: "Hey there! I am using ChatUp",
        isGroup: false,
        time: "10:02"),
    ChatModel(
        id: 1,
        name: "Mst. Rekha Khatun",
        icon: "assets/Icons/person.svg",
        currentMessage: "Hey there! I am using ChatUp",
        isGroup: false,
        time: "11:52"),
    ChatModel(
        id: 1,
        name: "ChatUp",
        icon: "assets/Icons/person.svg",
        currentMessage: "Hey there! I am using ChatUp",
        isGroup: true,
        time: "10:02"),
    ChatModel(
        id: 1,
        name: "Md. Raju Ahmed",
        icon: "assets/Icons/person.svg",
        currentMessage: "Hey there! I am using ChatUp",
        isGroup: false,
        time: "11:52")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        titleSpacing: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text("25 conatacts",
                style: TextStyle(fontSize: 14, color: Colors.white))
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chats.isEmpty ? 1 : chats.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0 || chats.isEmpty) {
                  return Column(
                    children: [
                      ButtonCard(
                          name: "New Group",
                          icon: const Icon(Icons.group_add),
                          pageName: NewGroup(contacts: chats)),
                      const ButtonCard(
                          name: "New Contact",
                          icon: Icon(Icons.person_add_alt),
                          pageName: NewGroup(
                            contacts: [],
                          )),
                      const ButtonCard(
                          name: "New Community",
                          icon: Icon(Icons.groups),
                          pageName: NewGroup(
                            contacts: [],
                          )),
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Contacts on ChatUp",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualChatPage(chatModel: chats[index-1])));
                    },
                    child: ContactCard(contact: chats[index - 1])
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
