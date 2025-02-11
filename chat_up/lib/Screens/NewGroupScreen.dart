import 'package:chat_up/Custom%20UI/AvatarCard.dart';
import 'package:chat_up/Custom%20UI/ContactCard.dart';
import 'package:chat_up/Models/ChatModel.dart';
import 'package:flutter/material.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({super.key, required this.contacts});
  final List<ChatModel> contacts;

  @override
  State<NewGroup> createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  List<ChatModel> group = [];

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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              "Add member",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Selected users list (horizontal scroll)
          if (group.isNotEmpty)
            Container(
              height: 75,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: group.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        group[index].select = false;
                        group.removeAt(index); // Fixed removing while iterating
                      });
                    },
                    child: AvatarCard(contact: group[index]),
                  );
                },
              ),
            ),
          if (group.isNotEmpty) const Divider(thickness: 1),

          // Contacts List (Tappable)
          Expanded(
            child: ListView.builder(
              itemCount: widget.contacts.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (!widget.contacts[index].select) {
                        widget.contacts[index].select = true;
                        group.add(widget.contacts[index]);
                      } else {
                        widget.contacts[index].select = false;
                        group.remove(widget.contacts[index]);
                      }
                    });
                  },
                  child: ContactCard(contact: widget.contacts[index]), // Fixed parameter name
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}
