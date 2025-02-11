// import 'package:chat_up/Screens/StatusScreen.dart';
import 'package:flutter/material.dart';
import '../Pages/ChatPage.dart';
import 'StatusScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
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
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(child: Chatpage()),  // Replace with ChatPage() if available
          Center(child: Text("Group")),
          Center(child: StatusScreen()),
        ],
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.primary,
        height: 50,
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.white, // Selected tab icon color
          unselectedLabelColor: Colors.white70, // Unselected tab icon color
          indicatorColor: Colors.white, // Indicator color
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(icon: Icon(Icons.chat)),
            Tab(icon: Icon(Icons.group_add)),
            Tab(icon: Icon(Icons.web_stories)),
          ],
        ),
      ),
    );
  }
}
