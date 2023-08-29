import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EventState>(create: (_) => EventState())
      ],
      child: MaterialApp(
        title: 'IITD App',
        theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
        initialRoute: AppRoutes.events,
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
