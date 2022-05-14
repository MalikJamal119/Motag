import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() {
  runApp(  const MaterialApp(
    home: Home()
  ));
}
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('my first app',
          style: TextStyle(
            fontFamily: 'AmaticSC',
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
      ),
      body:  Center(
        child: Image.asset('images/HM.png'),
       /*  child: Text('Hello',
          style: TextStyle(
            fontSize: 60.0,

            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,


          ),),*/
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.ellipsis_search,
        children: [
          SpeedDialChild(
            child: Icon(Icons.logout),
            label: 'Log Out',
          ),
          SpeedDialChild(
            child: Icon(Icons.wallet_giftcard),
            label: 'Enter New Points',
          ),
          SpeedDialChild(
            child: Icon(Icons.compare_arrows_rounded),
            label: 'Transfer Points',
          ),

        ],



        child: Icon(Icons.menu),



      ),

    );
  }
}
