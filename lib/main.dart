import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:preboom/states/challenges_state.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'routes.dart';
import 'screens/redirect_home/redirect_home_screen.dart';
import 'states/signin_state.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => SigninState(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ChallengesState(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pre Boom',
      routes: routes,
      initialRoute: RedirectHomeScreen.routeName,
      theme: theme(),
      darkTheme: themeDark(),
    );
  }
}
