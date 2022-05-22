import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:myapp/screens/home_screen.dart';

import '../models/user_model.dart';
import 'EnterPoints.dart';
import 'TransferPoints.dart';
import 'login_screen.dart';
import 'my_wallet.dart';


class TransferUser extends StatefulWidget {
  const TransferUser({Key? key}) : super(key: key);


  @override
  State<TransferUser> createState() => _TransferUserState();
}

class _TransferUserState extends State<TransferUser> {
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


  final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection('users').snapshots();

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
    body:Column(
      children: [
        Container(
          height: 80,
          width: 500,
          child: Text('You can send up to ${loggedInUser.points} points to any user from the list',textAlign: TextAlign.center,
              style: TextStyle(
            fontFamily: 'Macondo',
            fontSize: 30,
            fontWeight: FontWeight.bold,


          ),),
        ),
        Container(
      height: 250,
      padding: const EdgeInsets.symmetric(vertical: 20),
          child: StreamBuilder<QuerySnapshot>(
            stream: users,
            builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
              if(snapshot.hasError){
                return Text('Something went wrong.');
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Text('Loading');
              }
              final data = snapshot.requireData;

              return ListView.builder(
                itemCount: data.size,
                  itemBuilder: (context, index){
                    return Text('Send Points to ${data.docs[index]['firstName']} ${data.docs[index]['secondName']}');
                  },
              );

          },
          ),
    ),]),
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
                MaterialPageRoute(builder: (context) => const MyWallet()));},
          child: const Icon(Icons.card_giftcard_sharp),
          label: 'My Wallet',
        ),
        SpeedDialChild(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EnterPoints()));},
          child: const Icon(Icons.qr_code_scanner),
          label: 'Enter New Points',

        ),
        SpeedDialChild(
          onTap: (){
            Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) =>HomeScreen(),), (route) => false,//if you want to disable back feature set to false
            );
          },
          child: const Icon(Icons.home),
          label: 'Home Screen',
        ),

      ],
      child: const Icon(Icons.menu),
    ),
    );


  }
  Future<void> logout(BuildContext context) async
  {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }



        
    
      


}
