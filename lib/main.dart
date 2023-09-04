import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iitd_app/core/approutes.dart';
import 'package:iitd_app/core/appstate.dart';
import 'package:provider/provider.dart';

Future main() async {
//  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EventState>(
          create: (_) => EventState(),
        ),
        ChangeNotifierProvider<LostAndFoundState>(
          create: (_) => LostAndFoundState(),
        ),
      ],
      child: MaterialApp(
        title: 'TownSquare',
        theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
        initialRoute: AppRoutes.events,
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
