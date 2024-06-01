import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:larvae_classification/Screens/WelcomeScreen.dart';
import 'package:larvae_classification/Screens/mobileNavigationScreen.dart';
import 'package:larvae_classification/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:larvae_classification/Provider/UserData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>UserData()),
    ],
        child: MaterialApp(
          title: 'Larvae Classification',
          theme: ThemeData(
            useMaterial3: true,
          ),
          darkTheme: ThemeData(brightness: Brightness.dark),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return const  MobileNavigationScreen();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                return  WelcomeScreen();
              })),
        ));
  }
}
