import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/my_wallet.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
class EnterPoints extends StatefulWidget {
  const EnterPoints({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EnterPointsState();
}

class _EnterPointsState extends State<EnterPoints> {

  final _auth = FirebaseAuth.instance;
  //our form key
  final _formKey = GlobalKey<FormState>();

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

  void readQr() async {
    if (result != null) {
      controller!.stopCamera();
      print(result!.code);
      // if result is zara code
      if (result?.code == '+50 Zara Points!!') {

        if (loggedInUser.zarapoints != 0) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            loggedInUser.zarapoints = loggedInUser.zarapoints! + 50;
            Fluttertoast.showToast(msg: "Scanned 50 Zara points! you currently have ${loggedInUser.zarapoints} Zara points!");
            Map<String, dynamic> data = {"zarapoints": loggedInUser.zarapoints};
            FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
            Navigator.pushNamed(context, '/MyWallet');

          });
        }
        else if(loggedInUser.zarapoints == 0) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            var newZaraPoints = 50;
            loggedInUser.zarapoints = newZaraPoints;
            Fluttertoast.showToast(msg: "Successfully Scanned!! Your First ${loggedInUser.zarapoints} Zara points!");
            Map<String, dynamic> data = {"zarapoints": newZaraPoints, "zaramember": true};
            FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
            Navigator.pushNamed(context, '/MyWallet');

          });
      }}
      //if result is golda code
      if (result?.code == '+100 Golda Points!!') {

        if (loggedInUser.goldapoints != 0) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            loggedInUser.goldapoints = loggedInUser.goldapoints! + 100;
            Fluttertoast.showToast(msg: "Scanned 100 Golda points! you currently have ${loggedInUser.goldapoints} Golda points!");
            Map<String, dynamic> data = {"goldapoints": loggedInUser.goldapoints};
            FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
            Navigator.pushNamed(context, '/MyWallet');

          });
        }
        else if(loggedInUser.goldapoints == 0) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            var newGoldaPoints = 100;
            loggedInUser.goldapoints = newGoldaPoints;
            Fluttertoast.showToast(msg: "Successfully Scanned!! Your First ${loggedInUser.goldapoints} Golda points!");
            Map<String, dynamic> data = {"goldapoints": newGoldaPoints, "goldamember": true};
            FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
            Navigator.pushNamed(context, '/MyWallet');

          });
        }}
      // if result is rebar code
      if (result?.code == '+150 Rebar Points!!') {

        if (loggedInUser.rebarpoints != 0) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            loggedInUser.rebarpoints = loggedInUser.rebarpoints! + 150;
            Fluttertoast.showToast(msg: "Scanned 150 Rebar points! you currently have ${loggedInUser.rebarpoints} Rebar points!");
            Map<String, dynamic> data = {"rebarpoints": loggedInUser.rebarpoints};
            FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
            Navigator.pushNamed(context, '/MyWallet');

          });
        }
        else if(loggedInUser.rebarpoints == 0) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            var newRebarPoints = 150;
            loggedInUser.rebarpoints = newRebarPoints;
            Fluttertoast.showToast(msg: "Successfully Scanned!! Your First ${loggedInUser.rebarpoints} Rebar points!");
            Map<String, dynamic> data = {"rebarpoints": newRebarPoints, "rebarmember": true};
            FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
            Navigator.pushNamed(context, '/MyWallet');

          });
        }}
      // if the result is anything else
      else{
        Fluttertoast.showToast(msg: "Result : ${result!.code}");
      }
      controller!.dispose();
    }
  }

  @override
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}