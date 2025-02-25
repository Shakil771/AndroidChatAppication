import 'package:camera/camera.dart';
import 'package:chat_up/Pages/WelcomePage.dart';
import 'package:chat_up/Pages/auth/AuthController.dart';
import 'package:chat_up/Screens/home/home_screen.dart';
import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:chat_up/core/theme/DarkTheme.dart';
import 'package:chat_up/core/theme/LightTheme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'firebase_options.dart';
import 'routes/Routes.dart';

// Declare cameras globally
List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter is initialized before async calls
  // cameras = await availableCameras();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat Up',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      home: ref.watch(userInfoAuthProvider).when(
        data: (user) {
          FlutterNativeSplash.remove();
          if (user == null) {
            return WelcomePage();
          }
          return HomePage();
        },
        error: (error, trace) {
          return Scaffold(
            body: Center(
              child: Text("Something wrong happened!"),
            ),
          );
        },
        loading: () {
          return Scaffold(
            body: Center(
              child: Icon(
                FontAwesomeIcons.whatsapp,
                size: 48,
                color: context.theme?.authAppBarTextColor,
              ),
            ),
          );
        },
      ), // Ensure HomeScreen is defined
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
