import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/screens/EnterPoints.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/home_screen.dart';



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
    if((loggedInUser.zarapoints != null) && (loggedInUser.goldapoints != null) && ( loggedInUser.goldapoints != null )){
      loggedInUser.points = loggedInUser.zarapoints! + loggedInUser.rebarpoints! + loggedInUser.goldapoints!;
      Map<String, dynamic> data = {"points": loggedInUser.points};
      FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
    }
    else{
      loggedInUser.points = loggedInUser.zarapoints! + loggedInUser.rebarpoints! + loggedInUser.goldapoints!;
      Map<String, dynamic> data = {"points": loggedInUser.points};
      FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
    }



    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title:  Text(
        "${loggedInUser.firstName}'s Wallet",
        style: const TextStyle(
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

      child: const Text(" Your wallet is how much points you've collected so far. ", style: TextStyle(
          fontSize: 18.0,
          fontFamily: 'NotoSerif',
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,

        ),
      ),
    ),
     Container(

       color: Colors.lightGreen,
       height: 100,
        width: 420,
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
        child: const Text("To scan points , click on the menu button at the bottom and click on Enter New Points. ",
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'NotoSerif',
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,

          ),

      ),),
      Container(
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('images/motag.png'),
          )
        ),
      ),



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
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  EnterPoints()));},
          child: const Icon(Icons.qr_code_scanner),
          label: 'Enter New Points',

        ),
        SpeedDialChild(
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

