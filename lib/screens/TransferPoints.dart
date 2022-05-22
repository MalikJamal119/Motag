import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lottie/lottie.dart';

import '../models/user_model.dart';
import 'EnterPoints.dart';
import 'Transfer.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'my_wallet.dart';


class TransferPoints extends StatefulWidget {
  const TransferPoints({Key? key}) : super(key: key);

  @override
  State<TransferPoints> createState() => _TransferPointsState();
}

class _TransferPointsState extends State<TransferPoints> {
  bool isLoading = false;
  bool isDone = true;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title:  const Text(
          "Transfer Points",
          style: TextStyle(
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
          height: 120.0,

          child: const Text(" Our app allows you to transfer points between users and brands. ", style: TextStyle(
            fontSize: 28.0,
            fontFamily: 'Macondo',
            fontWeight: FontWeight.bold,


          ),
          ),
        ),
        Container(

            color: Colors.lightGreen,
            height: 55,
            width: 420,
            child: const Text('Click  "PROCEED" to continue ',style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontFamily: 'Macondo',
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,

            ),
            ),),





        SizedBox(
          height: 200,

          child:Lottie.asset('assets/delivery.json',reverse: true),


        ),
        Container(
          height: 120,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(32),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 24),
              minimumSize: const Size.fromHeight(72),
              shape: const StadiumBorder(),
            ),
            child: isLoading
            ? Row(
              mainAxisAlignment:MainAxisAlignment.center,
                children: const [
                CircularProgressIndicator(color: Colors.white),
            SizedBox(width: 24),
            Text('Working...',style: TextStyle(color: Colors.white),),
            ],
            )
            : const Text('Proceed',style: TextStyle(color: Colors.white),),
            onPressed: () async {
              if(isLoading) return;
              setState(() => isLoading = true);
              await Future.delayed(const Duration(seconds: 1));
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(builder: (BuildContext context) =>const Transfer(),), (route) => false,//if you want to disable back feature set to false
              );


            },
          ),
        ),
        Container(
          color: Colors.white,
          height:90,
          child: const Text("Note: By clicking 'Proceed' you agree that the points transferred can not be retrieved, unless the person you send the points to,sends them back! ",
            style: TextStyle(
              color: Colors.red,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,

            ),

          ),),
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
            child: const Icon(Icons.card_giftcard_sharp),
            onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MyWallet()));},

            label: 'My Wallet',
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