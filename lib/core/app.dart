import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasker/modules/home/pages/home.dart';
import 'package:tasker/modules/index/pages/index.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      title: 'Tasker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snap) {
            print(snap.data);
            switch (snap.connectionState) {
              case ConnectionState.active:
                return snap.hasData
                    ? const HomeIndexPage()
                    : const MyHomePage();
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                return const MyHomePage();
            }
          }),
    );
  }
}
