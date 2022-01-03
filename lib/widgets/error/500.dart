import 'package:flutter/material.dart';

class Error500 extends StatelessWidget {
  const Error500({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Somethign went wrong")),
    );
  }
}
