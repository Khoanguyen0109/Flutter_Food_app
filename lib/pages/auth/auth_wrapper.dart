// import 'package:flutter/material.dart';
// import 'package:food_app/models/user_model.dart';
// import 'package:food_app/pages/auth/login.dart';
// import 'package:food_app/pages/home/home.dart';
// import 'package:food_app/pages/home/shipper_home.dart';
// import 'package:food_app/providers/auth_service.dart';
// import 'package:food_app/widgets/loading.dart';
// import 'package:provider/provider.dart';

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final AuthService authService = Provider.of<AuthService>(context);
//     return StreamBuilder(
//         stream: authService.user,
//         builder: (_, AsyncSnapshot<User?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             final User? user = snapshot.data;
//             String role = 'user';

//             return user == null
//                 ? Login()
//                 : (role == 'shipper' ? ShipperHome() : Home());
//           } else {
//             return Loading();
//           }
//         });
//   }
// }
