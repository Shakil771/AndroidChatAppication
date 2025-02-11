import 'package:camera/camera.dart';
import 'package:chat_up/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';


// Declare cameras globally
List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized before async calls
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat Up',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: const Color(0xFF075E54),
          secondary: const Color(0xFF128C7E),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(), // Ensure HomeScreen is defined
    );
  }
}
