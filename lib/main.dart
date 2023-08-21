import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iitd_app/auth/authstate.dart';
import 'package:iitd_app/auth/splashscreen.dart';
import 'package:iitd_app/logic/approutes.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthState())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IITD App',
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
