import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tasker/modules/home/controllers/controller.dart';
import 'package:tasker/modules/home/pages/home.dart';
import 'package:tasker/modules/index/pages/index.dart';
import 'package:tasker/shared/controllers/tarefasController.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CadastroTarefasController()),
        ChangeNotifierProvider(create: (_) => TarefasController())
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('pt', 'BR'),
        ],
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
              debugPrint(snap.data.toString());
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
      ),
    );
  }
}
