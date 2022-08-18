import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'app_router.dart';
import 'constant/global_variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  prefs =await SharedPreferences.getInstance();
  runApp(MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder:(context, orientation, deviceType) {
          return MaterialApp(
            title: 'Kortobaa task',
            theme: ThemeData(fontFamily: 'Almarai'),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generateRouts,
          );
        }
    );
  }
}
