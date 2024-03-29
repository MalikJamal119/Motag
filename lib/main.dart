import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/UserTransfer.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/my_wallet.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MaterialApp(home: Home()));
}
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Email and password Login',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
      home: LoginScreen(),
      routes: {
          '/MyWallet' :(context) => MyWallet(),
      },
    );
  }
}
