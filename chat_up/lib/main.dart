import 'package:camera/camera.dart';
import 'package:chat_up/Pages/WelcomePage.dart';
import 'package:chat_up/Pages/auth/page/ProfileInfoPage.dart';
import 'package:chat_up/core/theme/DarkTheme.dart';
import 'package:chat_up/core/theme/LightTheme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'routes/Routes.dart';


// Declare cameras globally
List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized before async calls
  // cameras = await availableCameras();
  runApp(const ProviderScope(child: MyApp()));
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
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}


