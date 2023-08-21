// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iitd_app/features/auth/authstate.dart';
import 'package:iitd_app/features/auth/casioauth.dart';
import 'package:iitd_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    void onLoginSuccess(BuildContext context, String newtoken) async {
      // if (!Provider.of<AuthState>(context, listen: false).loading) {
      //   showLoading(context);
      // }
      const storage = FlutterSecureStorage();

      // final res = await http.get(Uri.parse('$uri/api/user/getAllCourses'),
      //     headers: {'authorization': 'Bearer $newtoken'});
      // var parsed = json.decode(res.body);

      // List<dynamic> tp = parsed['data'];

      // List<dynamic> allcoursesnames = tp.map((e) => e.toString().toLowerCase()).toList();
      // List<dynamic> alldepartmentslist = allcoursesnames
      //     .map((e) => e.substring(0, 2))
      //     .toSet()
      //     .map((e) => {
      //           'name': e,
      //           'color': DeptWise.getColor(e).withOpacity(1.0),
      //           'icondata': DeptWise.getIcondata(e)
      //         })
      //     .toList();
      // alldepartments = {
      //   for (var v in alldepartmentslist)
      //     v['name']: {'color': v['color'], 'icondata': v['icondata']}
      // };
      // allcourses = allcoursesnames
      //     .map((e) => Course(name: e, slot: js[e.toUpperCase()]))
      //     .toList();
      // allcourses.shuffle();

      // final test = await http.get(Uri.parse('$uri/api/user/me'),
      //     headers: {'authorization': 'Bearer $newtoken'});
      // if (json.decode(test.body)['data']['courses'].length == 0) {
      //   final resp = await http.get(Uri.parse('$uri/api/user/getCourses'),
      //       headers: {'authorization': 'Bearer $newtoken'});
      // }

      final response = await http.get(
          Uri.parse('${EndPoints.baseURL}/api/user/me'),
          headers: {'authorization': 'Bearer $newtoken'});
      if (response.statusCode == 200) {
        //var parsedJson = json.decode(response.body);
        //Update settings
        // SettingsHandler.setSettingValue('showEventNotifications',
        //     parsedJson['data']['notifications']['eventNotifications']);
        // SettingsHandler.setSettingValue('showNewsNotifications',
        //     parsedJson['data']['notifications']['newsNotifications']);

        // currentUser = User.fromJson(parsedJson['data']);

        await storage.write(key: 'token', value: newtoken);

        token = newtoken;
        if (!Provider.of<AuthState>(context, listen: false).loading) {
          Navigator.pop(context);
        }
        Provider.of<AuthState>(context, listen: false).signIn();

        // Notification Handling
        //await initialiseNotifications();

        // final response2 = await http.post("$uri/api/user/updatefcm",
        //     headers: {'authorization': 'Bearer $token'},
        //     body: {'fcmRegistrationToken': fcm});
      } else {
        if (!Provider.of<AuthState>(context, listen: false).loading) {
          Navigator.pop(context);
        }
        // await showErrorAlert(
        //     context, 'Login Failed', 'Something went wrong. Please Try Again');
      }
    }

    Future login(BuildContext context, {bool pop = true}) async {
      // const storage = FlutterSecureStorage();
      // var oldToken = await storage.read(key: 'token');
      var clientId = dotenv.env['CLIENT_ID']; //'5f7ca56f01cb380034260a02';
      // Dear Noob-Hackers, don't worry, you still can't do anything with this (even if you reach two level higher than this)
      var secret = dotenv.env['CASI_SECRET'];
      // CasiLogin oauth2 = CasiLogin(clientId!, secret!);
      // try {
      //   await oauth2.refreshToken(
      //       oldToken: oldToken!,
      //       onRefreshSuccess: (String newToken) {
      //         onLoginSuccess(context, newToken);
      //       });
      // } catch (e) {
      //   await CasiLogin(clientId, secret,
      //       onSuccess: (String token, CasiUser user) {
      //     onLoginSuccess(context, token);
      //   }).signIn();
      // }
      await CasiLogin(clientId!, secret!,
          onSuccess: (String token, CasiUser user) {
        onLoginSuccess(context, token);
      }).signIn();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                // ignore: deprecated_member_use
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    elevation: MaterialStateProperty.all<double>(4.0),
                  ),
                  onPressed: () async {
                    await login(context);
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: InkWell(
                  onTap: () {
                    guest = true;
                    Provider.of<AuthState>(context, listen: false).signIn();
                  },
                  child: const Text(
                    'Continue as Guest',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
