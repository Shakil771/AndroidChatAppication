import 'dart:async';

import 'package:chat_up/Pages/auth/AuthController.dart';
import 'package:chat_up/Pages/home/CallHomePage.dart';
import 'package:chat_up/Pages/home/ChatHomePage.dart';
import 'package:chat_up/Pages/home/GroupHomePage.dart';
import 'package:chat_up/Pages/home/StatusHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Timer timer;

  updateUserPresence() {
    ref.read(authControllerProvider).updateUserPresence();
  }

  @override
  void initState() {
    updateUserPresence();
    timer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) => setState(() {}),
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: const Text("ChatUp", style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (){}));
                },
                icon: const Icon(Icons.camera_alt_outlined),
                color: Colors.white),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                color: Colors.white),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (String value) {
                // Handle menu selection
                print("Selected: $value");
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                      value: "Option1", child: Text("Option 1")),
                  const PopupMenuItem(
                      value: "Option2", child: Text("Option 2")),
                  const PopupMenuItem(
                      value: "Option3", child: Text("Option 3")),
                  const PopupMenuItem(
                      value: "Option4", child: Text("Option 4")),
                ];
              },
            ),
          ],
          bottom: TabBar(
            // controller: _tabController,
            labelColor: Colors.white, // Selected tab icon color
            unselectedLabelColor: Colors.white70, // Unselected tab icon color
            indicatorColor:
                Theme.of(context).tabBarTheme.labelColor, // Indicator color
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                  icon: Icon(
                Icons.chat,
                size: 28,
                color: Colors.white,
              )),
              Tab(
                  icon: Icon(
                Icons.group,
                size: 28,
                color: Colors.white,
              )),
              Tab(
                  icon: Icon(
                Icons.call,
                size: 28,
                color: Colors.white,
              )),
              Tab(
                  icon: Icon(
                Icons.web_stories,
                size: 32,
                color: Colors.white,
              )),
            ],
          ),
        ),
        body: TabBarView(
          // controller: _tabController,
          children: [
            Center(
                child: ChatHomePage()), // Replace with ChatPage() if available
            Center(child: GroupHomePage()),
            Center(child: CallHomePage()),
            Center(child: StatusHomePage()),
          ],
        ),
      ),
    );
  }
}
