import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/screens/my_wallet.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:audioplayers/audioplayers.dart';

class EnterPoints extends StatefulWidget {
  const EnterPoints({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EnterPointsState();
}

class _EnterPointsState extends State<EnterPoints> with SingleTickerProviderStateMixin{
  late AnimationController controller2;

  final _auth = FirebaseAuth.instance;
  //our form key
  final _formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    controller2 = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    controller2.addStatusListener((status) async{
      if(status == AnimationStatus.completed){
        Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => MyWallet(),), (route) => false,//if you want to disable back feature set to false
        );


      }
    });
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
  void dispose(){
    controller?.dispose();
    controller2.dispose();
    super.dispose();
  }
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);
    });
  }
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    controller!.pauseCamera();

  }
// Qr codes
  void readQr() async {

    if (result != null) {
      final player = AudioCache();
      print(result!.code);

      // if result is zara code
      if (result?.code == '+50 Zara Points!!') {


        player.play('Cash.mp3');

        if (loggedInUser.zarapoints != 0) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            loggedInUser.zarapoints = loggedInUser.zarapoints! + 50;
            Fluttertoast.showToast(msg: "Scanned 50 Zara points! you currently have ${loggedInUser.zarapoints} Zara points!");
            Map<String, dynamic> data = {"zarapoints": loggedInUser.zarapoints};
            FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
            showDoneDialog();

          });
        }
        else if(loggedInUser.zarapoints == 0) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            var newZaraPoints = 50;
            loggedInUser.zarapoints = newZaraPoints;
            Fluttertoast.showToast(msg: "Successfully Scanned!! Your First ${loggedInUser.zarapoints} Zara points!");
            Map<String, dynamic> data = {"zarapoints": newZaraPoints, "zaramember": true};
            FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
            showDoneDialog();
          });
      }}
      //if result is golda code
      if (result?.code == '+100 Golda Points!!') {
        player.play('Cash.mp3');


        if (loggedInUser.goldapoints != 0) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            loggedInUser.goldapoints = loggedInUser.goldapoints! + 100;
            Fluttertoast.showToast(msg: "Scanned 100 Golda points! you currently have ${loggedInUser.goldapoints} Golda points!");
            Map<String, dynamic> data = {"goldapoints": loggedInUser.goldapoints};
            FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
            showDoneDialog();

          });
        }
        else if(loggedInUser.goldapoints == 0) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            var newGoldaPoints = 100;
            loggedInUser.goldapoints = newGoldaPoints;
            Fluttertoast.showToast(msg: "Successfully Scanned!! Your First ${loggedInUser.goldapoints} Golda points!");
            Map<String, dynamic> data = {"goldapoints": newGoldaPoints, "goldamember": true};
            FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
            showDoneDialog();

          });
        }}
      // if result is rebar code
      if (result?.code == '+150 Rebar Points!!') {
        player.play('Cash.mp3');


        if (loggedInUser.rebarpoints != 0) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            loggedInUser.rebarpoints = loggedInUser.rebarpoints! + 150;
            Fluttertoast.showToast(msg: "Scanned 150 Rebar points! you currently have ${loggedInUser.rebarpoints} Rebar points!");
            Map<String, dynamic> data = {"rebarpoints": loggedInUser.rebarpoints};
            FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
            showDoneDialog();

          });
        }
        else if(loggedInUser.rebarpoints == 0) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            var newRebarPoints = 150;
            loggedInUser.rebarpoints = newRebarPoints;
            Fluttertoast.showToast(msg: "Successfully Scanned!! Your First ${loggedInUser.rebarpoints} Rebar points!");
            Map<String, dynamic> data = {"rebarpoints": newRebarPoints, "rebarmember": true};
            FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
            showDoneDialog();

          });
        }}
      // if the result is anything else
      else{
        Fluttertoast.showToast(msg: "Result : ${result!.code}. Please scan a valid code");
      }
      controller!.dispose();
    }
  }

  @override
  //QR view
  Widget build(BuildContext context) {
    readQr();
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.orange,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 250,
        ),
      ),
    );
  }
  void showDoneDialog () => showDialog(
      barrierDismissible: false,
      context: context,
      builder:(context)=> Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/done.json',
                repeat: false,
                controller: controller2,
                onLoaded: (composition){
                  controller2.forward();

                },
              ),
              const Text(
                  'Scanned Successfully!',
                  style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
            ],
          )
      )
  );


}