import 'package:chat_up/Screens/ContactScreen.dart';
import 'package:flutter/material.dart';


class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Status", style: TextStyle(color: Colors.white)),
        actions: [
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
      body: Container(),

      // **🔽 Floating Action Button (FAB)**
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green, // WhatsApp-style color
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactPage()), // Replace with actual contact page
          );
        },
        child: const Icon(Icons.add_a_photo, color: Colors.white), // WhatsApp-style "+" icon
      ),

    );

  }
}
