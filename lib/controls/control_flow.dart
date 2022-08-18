import 'dart:async';
import 'package:flutter/material.dart';

import '../constant/global_variables.dart';
import '../constant/strings.dart';

class ControlFlow extends StatefulWidget {
  const ControlFlow({Key? key}) : super(key: key);

  @override
  _ControlFlowState createState() => _ControlFlowState();
}

class _ControlFlowState extends State<ControlFlow> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.run(() {
      isLogged
          ? Navigator.pushNamedAndRemoveUntil(context, home, (route) => false)
          : Navigator.pushNamedAndRemoveUntil(context, login, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
