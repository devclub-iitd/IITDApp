// import 'package:IITDAPP/modules/login/userlogin/signup_form.dart';

// import 'package:IITDAPP/ThemeModel.dart';
// import 'package:provider/provider.dart';
// import 'package:IITDAPP/widgets/cancel_alert.dart';
// import 'package:flutter/material.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';

// class SignUpPage extends StatelessWidget {
//   final Function onlogin;

//   SignUpPage(this.onlogin);

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => showCancelAlert(context, 'Cancel Sign-Up?',
//           'Are you sure you want to cancel making new account?'),
//       child: Scaffold(
//         backgroundColor:
//             Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
//         appBar: GradientAppBar(
//           title: Text('Create New User'),
//           centerTitle: true,
//           backgroundColorStart: Colors.indigo,
//           backgroundColorEnd: Colors.cyan,
//         ),
//         body: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).requestFocus(FocusNode());
//           },
//           behavior: HitTestBehavior.opaque,
//           child: ListView(
//             children: <Widget>[SignUpForm(onlogin)],
//           ),
//         ),
//       ),
//     );
//   }
// }
