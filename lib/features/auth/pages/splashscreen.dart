import 'package:flutter/material.dart';
import 'package:iitd_app/features/auth/authstate.dart';
import 'package:iitd_app/features/auth/pages/loginpage.dart';
import 'package:iitd_app/features/events/pages/eventspage.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<AuthState>(context, listen: false).checklogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AuthState>(
        builder: (context, provider, value) {
          if (provider.loading) {
            return Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "IITD APP",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 50,
                          fontWeight: FontWeight.w200),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'by DevClub',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
            );
          } else if (provider.signedIn) {
            return const EventPage() ;
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
