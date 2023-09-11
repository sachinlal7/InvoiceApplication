import 'package:flutter/material.dart';
import 'package:invoice_app/provider/google_signin_provider.dart';

import 'Screens/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Invoice App',
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(
        //     seedColor: Color.fromARGB(255, 69, 150, 216),
        //   ),
        //   useMaterial3: true,
        // ),
        home: HomeScreen(),
      ),
    );
  }
}
