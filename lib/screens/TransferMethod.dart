import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/screens/BrandTransfer.dart';
import 'package:myapp/screens/UserTransfer.dart';

import '../models/user_model.dart';
import 'EnterPoints.dart';
import 'TransferMethod.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'my_wallet.dart';



class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  bool isLoading = false;
  bool isDone = true;
  bool isLoading1 = false;
  bool isDone1 = true;



  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value){
      loggedInUser = UserModel.fromMap(value.data());
      setState(()  {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title:  const Text(
          "Send or Switch points",
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
          height: 190.0,
          width: 500,

            child: RichText( text:  TextSpan(

              style: const TextStyle(
                fontSize: 22.0,


              ),
              children: <TextSpan>[
                const TextSpan(text: 'Your options:\n',style:  TextStyle(color: Colors.red,decoration: TextDecoration.underline,)),
                const TextSpan(text: 'You can send up to ',style:  TextStyle(color: Colors.black)),
                TextSpan(text: '${loggedInUser.points}', style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent,fontFamily: 'Macondo',  decoration: TextDecoration.underline,)),
                const TextSpan(text: ' points to any user from the list , or you can transfer:\n',style:  TextStyle(color: Colors.black)),
                TextSpan(text: '${loggedInUser.zarapoints}',style: const TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontFamily: 'Macondo',  decoration: TextDecoration.underline,)),
                const TextSpan(text: ' Points from Zara, to any other brand. \n',style:  TextStyle(color: Colors.black)),
                TextSpan(text: '${  loggedInUser.goldapoints}',style: const TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontFamily: 'Macondo',  decoration: TextDecoration.underline,)),
                const TextSpan(text: ' Points from Golda, to any other brand.\n',style:  TextStyle(color: Colors.black)),
                TextSpan(text: '${  loggedInUser.rebarpoints}',style: const TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontFamily: 'Macondo',  decoration: TextDecoration.underline,)),
                const TextSpan(text: ' Points from Rebar, to any other brand.',style: TextStyle(color: Colors.black)),


              ],
            ),
            )),

        Container(
          height: 105,
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
                : const Text('Transfer to user',style: TextStyle(color: Colors.white),),
            onPressed: () async {
              if(isLoading) return;
              setState(() => isLoading = true);
              await Future.delayed(const Duration(seconds: 1));
              Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) =>TransferUser(),), (route) => false,//if you want to disable back feature set to false
              );


            },
          ),

        ),
        SizedBox(
          height: 203,

          child:Lottie.asset('assets/exchange.json',reverse: true),


        ),
        Container(
          height: 105,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(32),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 24),
              minimumSize: const Size.fromHeight(72),
              shape: const StadiumBorder(),
            ),
            child: isLoading1
                ? Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(color: Colors.white),
                SizedBox(width: 24),
                Text('Working...',style: TextStyle(color: Colors.white),),
              ],
            )
                : const Text('Transfer to brand',style: TextStyle(color: Colors.white),),
            onPressed: () async {
              if(isLoading1) return;
              setState(() => isLoading1 = true);
              await Future.delayed(const Duration(seconds: 1));
              Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) =>TransferBrand(),), (route) => false,//if you want to disable back feature set to false
              );


            },
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