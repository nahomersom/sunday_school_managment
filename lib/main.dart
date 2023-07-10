import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hisnate_kifele/Data/Data%20Providers/light_theme.dart';
import 'package:hisnate_kifele/Presentation/Routes/routes.dart';
import 'package:hisnate_kifele/Presentation/Screens/Workspace/UI/workspace.dart';

import 'Presentation/Screens/Home/UI/Dashboard.dart';
import 'Presentation/Screens/Registration/UI/registeration.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: lightTheme,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}

