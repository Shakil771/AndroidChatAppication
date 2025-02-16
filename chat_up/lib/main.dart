import 'package:camera/camera.dart';
import 'package:chat_up/Pages/auth/ProfileInfoPage.dart';
import 'package:chat_up/core/theme/DarkTheme.dart';
import 'package:chat_up/core/theme/LightTheme.dart';
import 'package:flutter/material.dart';


// Declare cameras globally
List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized before async calls
  // cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat Up',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      home: ProfileInfoPage(), // Ensure HomeScreen is defined
    );
  }
}
