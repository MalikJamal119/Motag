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
                height: 100,
                width: 420,
                child: RichText( text:  TextSpan(

                  style: const TextStyle(
                    fontSize: 20.0,



                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'You can Transfer:\n',style: const TextStyle(color: Colors.black54,)),
                    TextSpan(text: '${loggedInUser.zarapoints}',style: const TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontFamily: 'Macondo',  decoration: TextDecoration.underline,)),
                    const TextSpan(text: ' Points from Zara.\n',style: const TextStyle(color: Colors.black54,)),
                    TextSpan(text: '${  loggedInUser.goldapoints}',style: const TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontFamily: 'Macondo',  decoration: TextDecoration.underline,)),
                    const TextSpan(text: ' Points from Golda.\n',style: const TextStyle(color: Colors.black54,)),
                    TextSpan(text: '${  loggedInUser.rebarpoints}',style: const TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontFamily: 'Macondo',  decoration: TextDecoration.underline,)),
                    const TextSpan(text: ' Points from Rebar.',style: const TextStyle(color: Colors.black54,)),


                  ],
                ),
                )),

      Container(
        height: 5,
      ),

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


                        //sending without having any points in wallet
                         if(loggedInUser.points == 0){
                        Fluttertoast.showToast(msg: "ERROR: You have no points in wallet\nScan points in order to transfer ",
                        backgroundColor: Colors.red,
                        toastLength: Toast.LENGTH_LONG,
                        textColor: Colors.white,
                        fontSize: 14,);
                        }

                        // no brands selected
                         else if((selectedItem == 'Send From') || (selectedItem2 == 'Send to')){
                          Fluttertoast.showToast(msg: "ERROR: Please select brand(s) from the list",
                            backgroundColor: Colors.red,
                            toastLength: Toast.LENGTH_LONG,
                            textColor: Colors.white,
                            fontSize: 14,);
                        }


                         //sending 0 points from any brand
                         else if(points == 0){
                           Fluttertoast.showToast(msg: "ERROR: Can't send 0 points",
                             backgroundColor: Colors.red,
                             toastLength: Toast.LENGTH_LONG,
                             textColor: Colors.white,
                             fontSize: 14,);
                         }
                        //same brands selected
                          else if (selectedItem == selectedItem2) {
                            Fluttertoast.showToast(
                                msg: "ERROR: Can't send to the same brand!",
                              backgroundColor: Colors.red,
                              toastLength: Toast.LENGTH_LONG,
                              textColor: Colors.white,
                              fontSize: 14,

                            );
                          }
                          //0 points from zara
                          else if (selectedItem == 'Zara' && loggedInUser.zarapoints == 0) {
                            Fluttertoast.showToast(
                                msg: "ERROR: You cant send points from Zara \nyou have 0 Zara points",
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: 14,);
                          }
                         //sending to zara without membership
                         else if (selectedItem2 == 'Zara' && loggedInUser.zarapoints == 0) {
                           Fluttertoast.showToast(
                             msg: "ERROR: You cant send points to Zara \nyou have to be a member first",
                             backgroundColor: Colors.red,
                             textColor: Colors.white,
                             toastLength: Toast.LENGTH_LONG,
                             fontSize: 14,);
                         }
                          //0 points from golda
                          else if (selectedItem == 'Golda' && loggedInUser.goldapoints == 0) {
                            Fluttertoast.showToast(
                                msg: "ERROR: You cant send points from Golda \nyou have 0 Golda points",
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 14,);
                          }
                          //sending to golda without membership
                         else if (selectedItem2 == 'Golda' && loggedInUser.goldapoints == 0) {
                           Fluttertoast.showToast(
                             msg: "ERROR: You cant send points to Golda \nyou have to be a member first",
                             backgroundColor: Colors.red,
                             textColor: Colors.white,
                             toastLength: Toast.LENGTH_LONG,
                             fontSize: 14,);
                         }
                          //0 points from rebar
                          else if (selectedItem == 'Rebar' && loggedInUser.rebarpoints == 0) {
                            Fluttertoast.showToast(
                              msg: "ERROR: You cant send points from Rebar \nyou have 0 Rebar points",
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 14,);
                          }
                         //sending to rebar without membership
                         else if (selectedItem2 == 'Rebar' && loggedInUser.rebarpoints == 0) {
                           Fluttertoast.showToast(
                             msg: "ERROR: You cant send points to Rebar \nyou have to be a member first",
                             backgroundColor: Colors.red,
                             textColor: Colors.white,
                             toastLength: Toast.LENGTH_LONG,
                             fontSize: 14,);
                         }
                         // sending the last zara point
                         else if ((selectedItem == 'Zara' && (loggedInUser.zarapoints == 1)) && points == 1 ){
                           Fluttertoast.showToast(
                             msg: "ERROR: You only have 1 Zara point!\nyou cant send it!",
                             backgroundColor: Colors.red,
                             textColor: Colors.white,
                             toastLength: Toast.LENGTH_LONG,
                             fontSize: 14,);
                         }
                         // sending the last golda  point
                         else if (selectedItem == 'Golda' && (loggedInUser.goldapoints == 1)  && points == 1){
                           Fluttertoast.showToast(
                             msg: "ERROR: You only have 1 Golda point!\nyou cant send it!",
                             backgroundColor: Colors.red,
                             textColor: Colors.white,
                             toastLength: Toast.LENGTH_LONG,
                             fontSize: 14,);
                         }
                         // sending the last rebar  point
                         else if (selectedItem == 'Rebar' && (loggedInUser.rebarpoints == 1)  && points == 1){
                           Fluttertoast.showToast(
                             msg: "ERROR: You only have 1 Rebar point!\nyou cant send it!",
                             backgroundColor: Colors.red,
                             textColor: Colors.white,
                             toastLength: Toast.LENGTH_LONG,
                             fontSize: 14,);
                         }
                         // sending all zara points to another brand
                           else if (selectedItem == 'Zara' && (loggedInUser.zarapoints! - points == 0) ){
                           Fluttertoast.showToast(
                             msg: "ERROR: You cant send all your Zara points to another brand !\nkeep at least one point",
                             backgroundColor: Colors.red,
                             textColor: Colors.white,
                             toastLength: Toast.LENGTH_LONG,
                             fontSize: 14,);
                         } // sending all golda points to another brand
                         else if (selectedItem == 'Golda' && (loggedInUser.goldapoints! - points == 0) ){
                           Fluttertoast.showToast(
                             msg: "ERROR: You cant send all your Golda points to another brand !\nkeep at least one point",
                             backgroundColor: Colors.red,
                             textColor: Colors.white,
                             toastLength: Toast.LENGTH_LONG,
                             fontSize: 14,);
                         }
                         // sending all rebar points to another brand
                         else if (selectedItem == 'Rebar' && (loggedInUser.rebarpoints! - points == 0) ){
                           Fluttertoast.showToast(
                             msg: "ERROR: You cant send all your Rebar points to another brand !\nkeep at least one point",
                             backgroundColor: Colors.red,
                             textColor: Colors.white,
                             toastLength: Toast.LENGTH_LONG,
                             fontSize: 14,);
                         }


                          // zara to golda
                          else if (selectedItem == 'Zara' && (loggedInUser.zarapoints! - points > 0) && selectedItem2 == 'Golda') {
                           player.play('tada.mp3');
                           loggedInUser.zarapoints = loggedInUser.zarapoints! - points;
                            loggedInUser.goldapoints = loggedInUser.goldapoints! + points;


                            Fluttertoast.showToast(msg: "Transfer Completed!\nyou have now ${loggedInUser.zarapoints} zara points and ${loggedInUser.goldapoints} golda points",
                              backgroundColor: Colors.lightGreen,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: 14,);
                            Map<String, dynamic> data = {"zarapoints": loggedInUser.zarapoints, "goldapoints": loggedInUser.goldapoints };
                            FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
                            showDoneDialog();

                         }
                          // zara to rebar
                          else if (selectedItem == 'Zara' && (loggedInUser.zarapoints! - points > 0) && selectedItem2 == 'Rebar') {
                           player.play('tada.mp3');
                           loggedInUser.zarapoints =
                                loggedInUser.zarapoints! - points;
                            loggedInUser.rebarpoints =
                                loggedInUser.rebarpoints! + points;

                            Fluttertoast.showToast(
                                msg: "Transfer Completed!\nyou have now ${loggedInUser
                                    .zarapoints} zara points and ${loggedInUser
                                    .rebarpoints} rebar points",
                              backgroundColor: Colors.lightGreen,
                              toastLength: Toast.LENGTH_LONG,
                              textColor: Colors.white,
                              fontSize: 14,);
                            Map<String, dynamic> data = {"zarapoints": loggedInUser.zarapoints, "rebarpoints": loggedInUser.rebarpoints,};
                            FirebaseFirestore.instance.collection("users").doc(
                                user?.uid).update(data);
                            showDoneDialog();

                         }
                          //golda to zara
                          else if (selectedItem == 'Golda' && (loggedInUser.goldapoints! - points > 0) && selectedItem2 == 'Zara') {
                           player.play('tada.mp3');
                           loggedInUser.goldapoints =
                                loggedInUser.goldapoints! - points;
                            loggedInUser.zarapoints =
                                loggedInUser.zarapoints! + points;


                            Fluttertoast.showToast(
                                msg: "Transfer Completed! , you have now ${loggedInUser
                                    .goldapoints} golda points and ${loggedInUser
                                    .zarapoints} zara points",
                              backgroundColor: Colors.lightGreen,
                              toastLength: Toast.LENGTH_LONG,
                              textColor: Colors.white,
                              fontSize: 14,);
                            Map<String, dynamic> data = {
                              "goldapoints": loggedInUser.goldapoints,
                              "zarapoints": loggedInUser.zarapoints,
                            };
                            FirebaseFirestore.instance.collection("users").doc(
                                user?.uid).update(data);
                            showDoneDialog();

                         }
                          //golda to rebar
                          else if (selectedItem == 'Golda' && (loggedInUser.goldapoints! - points > 0) && selectedItem2 == 'Rebar') {
                           player.play('tada.mp3');
                           loggedInUser.goldapoints =
                                loggedInUser.goldapoints! - points;
                            loggedInUser.rebarpoints =
                                loggedInUser.rebarpoints! + points;

                           Fluttertoast.showToast(

                              msg: "Transfer Completed!\nyou have now ${loggedInUser
                                    .goldapoints} golda points and ${loggedInUser
                                    .rebarpoints} rebar points",
                              backgroundColor: Colors.lightGreen,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: 14,);
                            Map<String, dynamic> data = {
                              "goldapoints": loggedInUser.goldapoints,
                              "rebarpoints": loggedInUser.rebarpoints,
                            };
                            FirebaseFirestore.instance.collection("users").doc(
                                user?.uid).update(data);
                            showDoneDialog();

                         }
                          //rebar to zara
                          else if (selectedItem == 'Rebar' && (loggedInUser.rebarpoints! - points > 0) && selectedItem2 == 'Zara') {
                           player.play('tada.mp3');
                           loggedInUser.rebarpoints =
                                loggedInUser.rebarpoints! - points;
                            loggedInUser.zarapoints =
                                loggedInUser.zarapoints! + points;

                            Fluttertoast.showToast(
                                msg: "Transfer Completed!\nyou have now ${loggedInUser
                                    .rebarpoints} rebar points and ${loggedInUser
                                    .zarapoints} zara points",
                              backgroundColor: Colors.lightGreen,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: 14,);
                            Map<String, dynamic> data = {
                              "rebarpoints": loggedInUser.rebarpoints,
                              "zarapoints": loggedInUser.zarapoints,

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
                                msg: "Transfer Completed! \n you have now ${loggedInUser
                                    .rebarpoints} rebar points and ${loggedInUser
                                    .goldapoints} golda points",
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.lightGreen,
                              textColor: Colors.white,
                              fontSize: 14,);
                            Map<String, dynamic> data = {
                              "rebarpoints": loggedInUser.rebarpoints,
                              "goldapoints": loggedInUser.goldapoints,
                            };
                            FirebaseFirestore.instance.collection("users").doc(
                                user?.uid).update(data);
                            showDoneDialog();

                         }

                          //if sending more than allowed
                            else{
                          Fluttertoast.showToast(
                              msg: "Error: Insufficient points!\n You're sending more than you have!",
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 14,);
                        }
                      },
                      child: const Text('Transfer',textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Macondo',letterSpacing: 10 ),),
                    ),
                  )
              ),

            ),

            Container(
              color: Colors.black12,
              height: 170,
              width: 470,
              child: Lottie.network('https://assets8.lottiefiles.com/packages/lf20_2KHZQg.json',  ) ,),


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
