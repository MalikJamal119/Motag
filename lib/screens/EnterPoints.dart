
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EnterPoints extends StatefulWidget {
  const EnterPoints({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EnterPointsState();
}

class _EnterPointsState extends State<EnterPoints> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;


  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQRView(context),
            Positioned(bottom: 10,child: buildResult()),
            Positioned(top: 10, child: buildControlButton()),

          ],
        ),
    ),
    );
  Widget buildControlButton() => Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
          color: Colors.white24
    ),
    child: Row(
      mainAxisSize:  MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
          IconButton(
            icon: FutureBuilder<bool?>(
        future: controller?.getFlashStatus(),
        builder: (context, snapshot){
          if (snapshot.data != null) {
            return Icon(
              snapshot.data! ? Icons.flash_on : Icons.flash_off);



  }         else {
            return Container();
          }
  },
    ),
      onPressed: () async {
        await controller?.toggleFlash();
        setState(() {});
      },
),
      IconButton(
      icon: FutureBuilder(
      future:  controller?.getCameraInfo(),
      builder: (context, snapshot) {
        if (snapshot.data != null){
          return const Icon(Icons.switch_camera);
        } else {
          return Container();
      }
      },
),
      onPressed: () async {
        await controller?.flipCamera();
        setState(() {});
      },
      ),
      ],
    ),
  );
  Widget buildResult() => Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24,
    ),
    child: Text(
      barcode != null ? 'Result : ${barcode?.code}' : 'Scan a QR code to Earn points!',
      maxLines: 3,
    ),
  );



  Widget buildQRView(BuildContext context) =>
      QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.lightGreen,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width*0.8,
        ),
      );
  void onQRViewCreated(QRViewController controller){
    setState(() => this.controller = controller);

    controller.scannedDataStream
      .listen((barcode) => setState(() => this.barcode = barcode));{}




  }
}