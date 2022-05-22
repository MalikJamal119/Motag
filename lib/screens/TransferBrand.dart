import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../models/user_model.dart';
import 'EnterPoints.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'my_wallet.dart';


class TransferBrand extends StatefulWidget {
  const TransferBrand({Key? key}) : super(key: key);

  @override
  State<TransferBrand> createState() => _TransferBrandState();
}

class _TransferBrandState extends State<TransferBrand> with SingleTickerProviderStateMixin {
  late AnimationController controller2;
  bool isLoading = false;
  bool isDone = true;
  // ignore: non_constant_identifier_names
  final Points = TextEditingController();
  List<String> items =['Send From','Zara','Golda','Rebar'];
  String? selectedItem = 'Send From';
  List<String> items2 =['Send to','Zara','Golda','Rebar'];
  String? selectedItem2 = 'Send to';




  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    controller2 = AnimationController(
      duration:  Duration(seconds: 3),
      vsync: this,
    );
    controller2.addStatusListener((status) async{
      if(status == AnimationStatus.completed){
        Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) =>  MyWallet(),), (route) => false,//if you want to disable back feature set to false
        );


      }
    });
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
  void dispose() {
    Points.dispose();
    controller2.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer to Brand",textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'AmaticSC',
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),),
      ),
      body:Column(
          children: [
            Container(
          color: Colors.black12,
          height: 150,
          width: 420,
            child: RichText( text:  const TextSpan(

            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontFamily: 'Macondo',
              fontWeight: FontWeight.bold,


            ),
            children: <TextSpan>[
              TextSpan(text:'1)  Choose brands from the list.\n',),
              TextSpan(text:'2)  Enter the amount of points you want to \n     transfer.\n'),
              TextSpan(text: '3)  Press Transfer.\n'),
              TextSpan(text: '4)  Enjoy :) ! '),


            ],
          ),

            ),),
            Container(
                color: Colors.lightGreen,
                height: 100,
                width: 420,
                child: RichText( text:  TextSpan(

                  style: const TextStyle(
                    fontSize: 20.0,


                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'You can Transfer:\n',),
                    TextSpan(text: '${loggedInUser.zarapoints}',style: const TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontFamily: 'Macondo',  decoration: TextDecoration.underline,)),
                    const TextSpan(text: ' Points from Zara.\n'),
                    TextSpan(text: '${  loggedInUser.goldapoints}',style: const TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontFamily: 'Macondo',  decoration: TextDecoration.underline,)),
                    const TextSpan(text: ' Points from Golda.\n'),
                    TextSpan(text: '${  loggedInUser.rebarpoints}',style: const TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontFamily: 'Macondo',  decoration: TextDecoration.underline,)),
                    const TextSpan(text: ' Points from Rebar .'),


                  ],
                ),
                )),

            SizedBox(
              width: 250,
                height: 80,


               child:   DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(width: 2,color: Colors.lightGreen),
                      )
                    ),

                  value:selectedItem,
                  items: items.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'Acme'),),
                ))
                  .toList(),
                onChanged: (item)=>setState(() =>selectedItem = item),),






            ),
            SizedBox(
              width: 250,
              height: 70,
              child:DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(width: 2,color: Colors.lightGreen),
                    )
                ),
                value:selectedItem2,
                items: items2.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'Acme'),),
                ))
                    .toList(),
                onChanged: (item)=>setState(() =>selectedItem2= item),),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: TextField(
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightGreen),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    prefixIcon: Icon(Icons.keyboard),
                    hintText: "Enter Points",
                    filled: true,
                    fillColor: Colors.black12),

                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: Points,
              ),
            ),
            Container(
              height: 125,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(32),
              child:(
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.lightGreen,
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: (){
                        final player = AudioCache();

                        int points = int.parse(Points.text);

                        // no brands selected
                         if((selectedItem == 'Send From') || (selectedItem2 == 'Send to')){
                          Fluttertoast.showToast(msg: "ERROR: Please select brand(s) from the list");
                        }
                         //sending 0 points from any brand
                         else if(points == 0){
                           Fluttertoast.showToast(msg: "ERROR: Can't send 0 points");
                         }
                        //same brands selected
                          else if (selectedItem == selectedItem2) {
                            Fluttertoast.showToast(
                                msg: "ERROR: Can't send to the same brand");
                          }
                          //0 points from zara
                          else if (selectedItem == 'Zara' && loggedInUser.zarapoints == 0) {
                            Fluttertoast.showToast(
                                msg: "ERROR: You cant send from Zara , you have 0 points");
                          }
                          //0 points from golda
                          else if (selectedItem == 'Golda' && loggedInUser.goldapoints == 0) {
                            Fluttertoast.showToast(
                                msg: "ERROR: You cant send from Golda , you have 0 points");
                          }
                          //0 points from rebar
                          else if (selectedItem == 'Rebar' && loggedInUser.rebarpoints == 0) {
                            Fluttertoast.showToast(
                                msg: "ERROR: You cant send from Rebar , you have 0 points");
                          }
                          // zara to golda
                          else if (selectedItem == 'Zara' && (loggedInUser.zarapoints! - points >= 0) && selectedItem2 == 'Golda') {
                           player.play('tada.mp3');
                           loggedInUser.zarapoints = loggedInUser.zarapoints! - points;
                            loggedInUser.goldapoints = loggedInUser.goldapoints! + points;
                            Fluttertoast.showToast(msg: "Transfer Completed! , you have now ${loggedInUser.zarapoints} zara points and ${loggedInUser.goldapoints} golda points");
                            Map<String, dynamic> data = {"zarapoints": loggedInUser.zarapoints, "goldapoints": loggedInUser.goldapoints};
                            FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
                            showDoneDialog();

                         }
                          // zara to rebar
                          else if (selectedItem == 'Zara' && (loggedInUser.zarapoints! - points >= 0) && selectedItem2 == 'Rebar') {
                           player.play('tada.mp3');
                           loggedInUser.zarapoints =
                                loggedInUser.zarapoints! - points;
                            loggedInUser.rebarpoints =
                                loggedInUser.rebarpoints! + points;
                            Fluttertoast.showToast(
                                msg: "Transfer Completed! , you have now ${loggedInUser
                                    .zarapoints} zara points and ${loggedInUser
                                    .rebarpoints} rebar points");
                            Map<String, dynamic> data = {
                              "zarapoints": loggedInUser.zarapoints,
                              "rebarpoints": loggedInUser.rebarpoints
                            };
                            FirebaseFirestore.instance.collection("users").doc(
                                user?.uid).update(data);
                            showDoneDialog();

                         }
                          //golda to zara
                          else if (selectedItem == 'Golda' && (loggedInUser.goldapoints! - points >= 0) && selectedItem2 == 'Zara') {
                           player.play('tada.mp3');
                           loggedInUser.goldapoints =
                                loggedInUser.goldapoints! - points;
                            loggedInUser.zarapoints =
                                loggedInUser.zarapoints! + points;
                            Fluttertoast.showToast(
                                msg: "Transfer Completed! , you have now ${loggedInUser
                                    .goldapoints} golda points and ${loggedInUser
                                    .zarapoints} zara points");
                            Map<String, dynamic> data = {
                              "goldapoints": loggedInUser.goldapoints,
                              "zarapoints": loggedInUser.zarapoints
                            };
                            FirebaseFirestore.instance.collection("users").doc(
                                user?.uid).update(data);
                            showDoneDialog();

                         }
                          //golda to rebar
                          else if (selectedItem == 'Golda' && (loggedInUser.goldapoints! - points >= 0) && selectedItem2 == 'Rebar') {
                           player.play('tada.mp3');
                           loggedInUser.goldapoints =
                                loggedInUser.goldapoints! - points;
                            loggedInUser.rebarpoints =
                                loggedInUser.rebarpoints! + points;
                            Fluttertoast.showToast(
                                msg: "Transfer Completed! , you have now ${loggedInUser
                                    .goldapoints} golda points and ${loggedInUser
                                    .rebarpoints} rebar points");
                            Map<String, dynamic> data = {
                              "goldapoints": loggedInUser.goldapoints,
                              "rebarpoints": loggedInUser.rebarpoints
                            };
                            FirebaseFirestore.instance.collection("users").doc(
                                user?.uid).update(data);
                            showDoneDialog();

                         }
                          //rebar to zara
                          else if (selectedItem == 'Rebar' && (loggedInUser.rebarpoints! - points >= 0) && selectedItem2 == 'Zara') {
                           player.play('tada.mp3');
                           loggedInUser.rebarpoints =
                                loggedInUser.rebarpoints! - points;
                            loggedInUser.zarapoints =
                                loggedInUser.zarapoints! + points;
                            Fluttertoast.showToast(
                                msg: "Transfer Completed! , you have now ${loggedInUser
                                    .rebarpoints} rebar points and ${loggedInUser
                                    .zarapoints} zara points");
                            Map<String, dynamic> data = {
                              "rebarpoints": loggedInUser.rebarpoints,
                              "zarapoints": loggedInUser.zarapoints
                            };
                            FirebaseFirestore.instance.collection("users").doc(
                                user?.uid).update(data);
                            showDoneDialog();

                         }
                          //rebar to golda
                          else if (selectedItem == 'Rebar' && (loggedInUser.rebarpoints! - points >= 0) && selectedItem2 == 'Golda') {
                           player.play('tada.mp3');
                           loggedInUser.rebarpoints = loggedInUser
                                .rebarpoints! - points;
                            loggedInUser.goldapoints = loggedInUser
                                .goldapoints! + points;
                            Fluttertoast.showToast(
                                msg: "Transfer Completed! , you have now ${loggedInUser
                                    .rebarpoints} rebar points and ${loggedInUser
                                    .goldapoints} golda points");
                            Map<String, dynamic> data = {
                              "rebarpoints": loggedInUser.rebarpoints,
                              "goldapoints": loggedInUser.goldapoints
                            };
                            FirebaseFirestore.instance.collection("users").doc(
                                user?.uid).update(data);
                            showDoneDialog();

                         }

                          //if sending more than allowed from zara
                            else{
                          Fluttertoast.showToast(
                              msg: "Insufficient points!!, You're sending more than you have!");
                        }
                      },
                      child: const Text('Transfer',textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                  )
              ),

            ),


            ]),
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
              Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) =>const HomeScreen(),), (route) => false,//if you want to disable back feature set to false
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
  void showDoneDialog () => showDialog(
      barrierDismissible: false,
      context: context,
      builder:(context)=> Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/completed.json',
                repeat: true,
                controller: controller2,
                onLoaded: (composition){
                  controller2.forward();

                },
              ),
              const Text(
                  'Transferred Successfully!',
                  style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
            ],
          )
      )
  );



}
