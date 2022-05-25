import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/screens/EnterPoints.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/home_screen.dart';

import 'TransferPoints.dart';



class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {




    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title:  Text(
        "${loggedInUser.firstName}'s Wallet",
        style: const TextStyle(
          color: Colors.white,
        fontFamily: 'AmaticSC',
        fontSize: 60,
        fontWeight: FontWeight.bold,
    ),
    ),
    centerTitle: true,
    ),
    body: Column(children: [
      Container(
      color: Colors.black12,
      height: 80.0,
      width: 450,

      child: RichText( text:  const TextSpan(

        style: TextStyle(


        ),
        children: <TextSpan>[
          TextSpan(text: '  Our app works with QR scanning\n',style: TextStyle(color: Colors.black,fontSize:24,fontWeight: FontWeight.bold ,fontFamily: 'Macondo',letterSpacing: 1)),
          TextSpan(text: ' Just point your camera at one of our generated QR\n                          codes to earn points!',style: TextStyle(color: Colors.black,fontSize: 18)),


        ],
      ),
      )
    ),
     Container(

       color: Colors.lightGreen,
       height: 100,
        width: 430,
        child: RichText( text:  TextSpan(

          style: const TextStyle(
            fontSize: 20.0,


          ),
          children: <TextSpan>[
            const TextSpan(text: 'Overall , You have ',),
            TextSpan(text: '${loggedInUser.points}', style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent,fontFamily: 'Macondo',  decoration: TextDecoration.underline,)),
            const TextSpan(text: ' Points, Which are:\n'),
            TextSpan(text: '${loggedInUser.zarapoints}',style: const TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontFamily: 'Macondo',  decoration: TextDecoration.underline,)),
            const TextSpan(text: ' Points from Zara.\n'),
            TextSpan(text: '${  loggedInUser.goldapoints}',style: const TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontFamily: 'Macondo',  decoration: TextDecoration.underline,)),
            const TextSpan(text: ' Points from Golda.\n'),
            TextSpan(text: '${  loggedInUser.rebarpoints}',style: const TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontFamily: 'Macondo',  decoration: TextDecoration.underline,)),
            const TextSpan(text: ' Points from Rebar .'),


          ],
        ),
        )),



      Container(
        color: Colors.black12,
        height: 100,
        child: const Text("To scan points , click the menu button and click on Enter New Points.\n", textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            fontFamily: 'Macondo',
            fontWeight: FontWeight.bold,

          ),

      ),),
      Container(
        height: 300,

        child:Lottie.network('https://assets3.lottiefiles.com/private_files/lf30_le9o8vmt.json',reverse: true),


      )
    ],),
      floatingActionButton: SpeedDial(
      backgroundColor: Colors.lightGreen,
      animatedIcon: AnimatedIcons.menu_close,
      children: [

        SpeedDialChild(
            child: const Icon(Icons.logout),
            label: 'Log Out',
            onTap: () {
              logout(context);
            }

        ),
        SpeedDialChild(
            child: const Icon(Icons.home),
            label: 'Home Screen',
            onTap: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(builder: (BuildContext context) =>const HomeScreen(),), (route) => false,//if you want to disable back feature set to false
              );
            }

        ),

        SpeedDialChild(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  const EnterPoints()));},
          child: const Icon(Icons.qr_code_scanner),
          label: 'Enter New Points',

        ),
        SpeedDialChild(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const TransferPoints()));

          },
          child: const Icon(Icons.cached_sharp),
          label: 'Transfer Points',
        ),

      ],
      child: const Icon(Icons.menu),
    ),);
  }
  Future<void> logout(BuildContext context) async
  {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }


}

