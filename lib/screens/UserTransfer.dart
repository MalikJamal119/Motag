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










class TransferUser extends StatefulWidget {
  const TransferUser({Key? key}) : super(key: key);


  @override
  State<TransferUser> createState() => _TransferUserState();
}

class _TransferUserState extends State<TransferUser> with SingleTickerProviderStateMixin {

  var UserID;

  var UserPoints;

  var UserFirstName;

  var UserLastName;

  var UserZP;

  var UserGP;

  var UserRP;



  var setDefaultMake = true;
  late AnimationController controller2;
  bool isLoading = false;
  bool isDone = true;


  // ignore: non_constant_identifier_names
  final Points = TextEditingController();
  List<String> items = [
    'Choose a brand to send from',
    'Zara',
    'Golda',
    'Rebar'
  ];
  String? selectedItem = 'Choose a brand to send from';
  List<String> items2 = ['Choose a brand to send to', 'Zara', 'Golda', 'Rebar'];
  String? selectedItem2 = 'Choose a brand to send to';


  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    controller2 = AnimationController(
      duration:  Duration(seconds: 3),
      vsync: this,
    );
    controller2.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
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
        backgroundColor: Colors.lightGreen,
        title: const Text(
          "Transfer to User",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'AmaticSC',
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
          children: [

            Container(
                color: Colors.black12,
                height: 100,
                width: 420,
                child: RichText(text: TextSpan(

                  style: const TextStyle(
                    fontSize: 20.0,


                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'You can Transfer:\n',style: TextStyle(color: Colors.black54,)),
                    TextSpan(text: '${loggedInUser.zarapoints}',
                        style: const TextStyle(color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Macondo',
                          decoration: TextDecoration.underline,)),
                    const TextSpan(text: ' Points from Zara to any user.\n',style: TextStyle(color: Colors.black54,)),
                    TextSpan(text: '${ loggedInUser.goldapoints}',
                        style: const TextStyle(color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Macondo',
                          decoration: TextDecoration.underline,)),
                    const TextSpan(text: ' Points from Golda to any user.\n',style: TextStyle(color: Colors.black54,)),
                    TextSpan(text: '${ loggedInUser.rebarpoints}',
                        style: const TextStyle(color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Macondo',
                          decoration: TextDecoration.underline,)),
                    const TextSpan(text: ' Points from Rebar to any user.',style: TextStyle(color: Colors.black54,)),


                  ],
                ),
                )),


            // Users list
            Container(
              height: 60,

              padding: const EdgeInsets.symmetric(vertical: 20),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').orderBy(
                    'firstName').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return Container();


                  return DropdownButton(
                    icon: Icon(Icons.person),
                    hint: const Text('Choose a user'),
                    isExpanded: false,
                    value: UserFirstName,
                    items: snapshot.data?.docs.map((value) {
                      return DropdownMenuItem(

                        value: value.get('firstName'),
                        child: Text('${value.get('firstName')}  ${value.get(
                            'secondName')}'),
                        onTap: () {
                          UserPoints = value.get('points');
                          UserLastName = value.get('secondName');
                          UserID = value.get('uid');
                          UserZP = value.get('zarapoints');
                          UserGP = value.get('goldapoints');
                          UserRP = value.get('rebarpoints');
                        },
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(
                            () {
                          UserFirstName = value;

                          setDefaultMake = false;
                        },
                      );
                    },
                  );
                },
              ),
            ),


            //two lists of brands
      SizedBox(
        width: 280,
        height: 80,


        child:   DropdownButtonFormField<String>(
          icon: Icon(Icons.send),

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
        width: 280,
        height: 70,
        child:DropdownButtonFormField<String>(
          icon: Icon(Icons.attach_money),

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
                    // if no user was chosen
                    if(UserFirstName == null){
                      Fluttertoast.showToast(
                        msg: "ERROR: Please select a user!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 14,);

                    }


                    //  sending points to the same user
                    else if (loggedInUser.firstName == UserFirstName && loggedInUser.secondName == UserLastName) {
                      Fluttertoast.showToast(
                        msg: "ERROR: Can't send points to yourself!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 14,);
                    }
                    //sending without having any points in wallet
                    else if(loggedInUser.points == 0){
                      Fluttertoast.showToast(msg: "ERROR: You have no points in wallet\nScan points in order to transfer ",
                        backgroundColor: Colors.red,
                        toastLength: Toast.LENGTH_LONG,
                        textColor: Colors.white,
                        fontSize: 14,);
                    }
                    // sending to a user who has 0 points
                    else if(UserPoints == 0 || UserPoints == null){
                      Fluttertoast.showToast(
                        msg: "ERROR: $UserFirstName is not a member of any brand!\nYou can't send him any points!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 14,);

                    }
                    // no brands selected
                    else if ((selectedItem == 'Choose a brand to send from') || (selectedItem2 == 'Choose a brand to send to')) {
                      Fluttertoast.showToast(
                        msg: "ERROR: Please select brand(s) from the list!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 14,);
                    }


                    //sending 0 points from any brand
                    else if (points == 0) {
                      Fluttertoast.showToast(msg: "ERROR: Can't send 0 points!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 14,);
                    }


                    //0 points from zara
                    else if (selectedItem == 'Zara' && loggedInUser.zarapoints == 0) {
                      Fluttertoast.showToast(
                        msg: "ERROR: You cant send from Zara \nyou have 0 points!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 14,);
                    }
                    //sending to zara without membership
                    else if (selectedItem2 == 'Zara' && (UserZP == 0 || UserZP == null)) {
                      Fluttertoast.showToast(
                        msg: "ERROR: $UserFirstName is not a Zara member \nyou can't send him zara points!",
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: 14,);
                    }

                    //0 points from golda
                    else if (selectedItem == 'Golda' && loggedInUser.goldapoints == 0) {
                      Fluttertoast.showToast(
                        msg: "ERROR: You cant send from Golda \nyou have 0 points!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 14,);
                    }
                    //sending to golda without membership
                    else if (selectedItem2 == 'Golda' && (UserGP == 0 || UserGP == null)) {
                      Fluttertoast.showToast(
                        msg: "ERROR: $UserFirstName is not a Golda member \nyou can't send him golda points!",
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: 14,);
                    }

                    //0 points from rebar
                    else if (selectedItem == 'Rebar' && loggedInUser.rebarpoints == 0) {
                      Fluttertoast.showToast(
                        msg: "ERROR: You cant send from Rebar \nyou have 0 points!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 14,);
                    }
                    //sending to rebar without membership
                    else if (selectedItem2 == 'Rebar' && (UserRP == 0 || UserRP == null)) {
                      Fluttertoast.showToast(
                        msg: "ERROR: $UserFirstName is not a Rebar member \nyou can't send him rebar points!",
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
                        msg: "ERROR: You cant send all your Zara points !\nkeep at least one point",
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: 14,);
                    } // sending all golda points to another brand
                    else if (selectedItem == 'Golda' && (loggedInUser.goldapoints! - points == 0) ){
                      Fluttertoast.showToast(
                        msg: "ERROR: You cant send all your Golda points !\nkeep at least one point",
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: 14,);
                    }
                    // sending all rebar points to another brand
                    else if (selectedItem == 'Rebar' && (loggedInUser.rebarpoints! - points == 0) ){
                      Fluttertoast.showToast(
                        msg: "ERROR: You cant send all your Rebar points!\nkeep at least one point",
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: 14,);
                    }


                    //same brands selected
                    else if (selectedItem == selectedItem2)
                    {
                      // if zara selected
                      if(selectedItem == 'Zara'){

                              if(loggedInUser.zarapoints! - points > 0){
                                loggedInUser.zarapoints = loggedInUser.zarapoints! - points;
                                loggedInUser.points = loggedInUser.points! - points;
                                UserZP = UserZP + points;
                                UserPoints = UserPoints + points;


                                player.play('tada.mp3');

                                Fluttertoast.showToast(
                                  msg: "Transfer Completed! \nyou've sent $points Zara to $UserFirstName Zara's!",
                                  toastLength: Toast.LENGTH_LONG,
                                  backgroundColor: Colors.lightGreen,
                                  textColor: Colors.white,
                                  fontSize: 14,);

                                Map<String, dynamic> data = {"zarapoints": loggedInUser.zarapoints , "points": loggedInUser.points};
                                      FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
                                      Map<String, dynamic> data1 = {"zarapoints": UserZP,"points": UserPoints};
                                      FirebaseFirestore.instance.collection("users").doc(UserID).update(data1);
                                showDoneDialog();}



                            }
                      // if golda selected
                          else if(selectedItem == 'Golda'){

                               if(loggedInUser.goldapoints! - points > 0){
                                loggedInUser.goldapoints = loggedInUser.goldapoints! - points;
                                loggedInUser.points = loggedInUser.points! - points;
                                UserGP = UserGP + points;
                                UserPoints = UserPoints + points;

                                player.play('tada.mp3');

                                Fluttertoast.showToast(
                                  msg: "Transfer Completed! \nyou've sent $points Golda points to $UserFirstName Golda's!",
                                  toastLength: Toast.LENGTH_LONG,
                                  backgroundColor: Colors.lightGreen,
                                  textColor: Colors.white,
                                  fontSize: 14,);
                                Map<String, dynamic> data = {"goldapoints": loggedInUser.goldapoints, "points": loggedInUser.points};
                                FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
                                Map<String, dynamic> data1 = {"goldapoints": UserGP,"points": UserPoints};
                                FirebaseFirestore.instance.collection("users").doc(UserID).update(data1);
                                showDoneDialog();}


                      }
                      //if rebar selected
                      else{

                               if(loggedInUser.rebarpoints! - points > 0){
                                loggedInUser.rebarpoints = loggedInUser.rebarpoints! - points;
                                loggedInUser.points = loggedInUser.points! - points;
                                UserRP = UserRP + points;
                                UserPoints = UserPoints+ points;

                                player.play('tada.mp3');

                                Fluttertoast.showToast(
                                  msg: "Transfer Completed!\nyou've sent $points Rebar points to $UserFirstName Rebar's!",
                                  toastLength: Toast.LENGTH_LONG,
                                  backgroundColor: Colors.lightGreen,
                                  textColor: Colors.white,
                                  fontSize: 14,);

                                Map<String, dynamic> data = {"rebarpoints": loggedInUser.rebarpoints ,"points":loggedInUser.points};
                                FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
                                Map<String, dynamic> data1 = {"rebarpoints": UserRP,"points":UserPoints};
                                FirebaseFirestore.instance.collection("users").doc(UserID).update(data1);
                                showDoneDialog();}


                      }
                    }

                    // zara to golda
                    else if (selectedItem == 'Zara' && (loggedInUser.zarapoints! - points > 0) && selectedItem2 == 'Golda') {
                      loggedInUser.zarapoints = loggedInUser.zarapoints! - points;
                      loggedInUser.points = loggedInUser.points! - points;
                      UserGP = UserGP + points;
                      UserPoints = UserPoints + points;


                      player.play('tada.mp3');

                      Fluttertoast.showToast(
                        msg: "Transfer Completed!\nyou've sent $points Zara to $UserFirstName Golda's!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.lightGreen,
                        textColor: Colors.white,
                        fontSize: 14,);

                      Map<String, dynamic> data = {"zarapoints": loggedInUser.zarapoints,"points":loggedInUser.points};
                      FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
                      Map<String, dynamic> data1 = {"goldapoints": UserGP,"points":UserPoints};
                      FirebaseFirestore.instance.collection("users").doc(UserID).update(data1);showDoneDialog();
                    }


                    // zara to rebar
                    else if (selectedItem == 'Zara' && (loggedInUser.zarapoints! - points > 0) && selectedItem2 == 'Rebar') {
                      loggedInUser.zarapoints = loggedInUser.zarapoints! - points;
                      UserRP = UserRP + points;
                      UserPoints = UserPoints+ points;
                      loggedInUser.points = loggedInUser.points! - points;

                      player.play('tada.mp3');

                      Fluttertoast.showToast(
                        msg: "Transfer Completed!\nyou've sent $points Zara Points to $UserFirstName Rebar's!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.lightGreen,
                        textColor: Colors.white,
                        fontSize: 14,);
                      Map<String, dynamic> data = {"zarapoints": loggedInUser.zarapoints,"points":loggedInUser.points};
                      FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
                      Map<String, dynamic> data1 = {"rebarpoints": UserRP,"points":UserPoints};
                      FirebaseFirestore.instance.collection("users").doc(UserID).update(data1);
                      showDoneDialog();
                    }
                    //golda to zara
                    else if (selectedItem == 'Golda' && (loggedInUser.goldapoints! - points > 0) && selectedItem2 == 'Zara') {
                      loggedInUser.goldapoints = loggedInUser.goldapoints! - points;
                      UserZP = UserZP + points;
                      UserPoints = UserPoints+ points;
                      loggedInUser.points = loggedInUser.points! - points;
                      player.play('tada.mp3');

                      Fluttertoast.showToast(
                        msg: "Transfer Completed!\nyou've sent $points Golda  Points to $UserFirstName Zara's!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.lightGreen,
                        textColor: Colors.white,
                        fontSize: 14,);
                      Map<String, dynamic> data = {"goldapoints": loggedInUser.goldapoints,"points":loggedInUser.points};
                      FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
                      Map<String, dynamic> data1 = {"zarapoints": UserZP,"points":UserPoints};
                      FirebaseFirestore.instance.collection("users").doc(UserID).update(data1);
                      showDoneDialog();
                    }
                    //golda to rebar
                    else if (selectedItem == 'Golda' && (loggedInUser.goldapoints! - points > 0) && selectedItem2 == 'Rebar') {
                      loggedInUser.goldapoints = loggedInUser.goldapoints! - points;
                      UserRP = UserRP + points;
                      UserPoints = UserPoints + points;
                      loggedInUser.points = loggedInUser.points! - points;
                      player.play('tada.mp3');

                      Fluttertoast.showToast(
                        msg: "Transfer Completed!\nyou've sent $points Golda Points to $UserFirstName Rebar's!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.lightGreen,
                        textColor: Colors.white,
                        fontSize: 14,);
                      Map<String, dynamic> data = {"goldapoints": loggedInUser.goldapoints,"points":loggedInUser.points};
                      FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
                      Map<String, dynamic> data1 = {"rebarpoints": UserRP,"points":UserPoints};
                      FirebaseFirestore.instance.collection("users").doc(UserID).update(data1);
                      showDoneDialog();
                    }
                    //rebar to zara
                    else if (selectedItem == 'Rebar' && (loggedInUser.rebarpoints! - points > 0) && selectedItem2 == 'Zara') {
                      player.play('tada.mp3');
                      loggedInUser.rebarpoints = loggedInUser.rebarpoints! - points;
                      UserZP = UserZP + points;
                      UserPoints = UserPoints + points;
                      loggedInUser.points = loggedInUser.points! - points;

                      Fluttertoast.showToast(
                        msg: "Transfer Completed!\nyou've sent $points Rebar Points to $UserFirstName Zara's!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.lightGreen,
                        textColor: Colors.white,
                        fontSize: 14,);
                      Map<String, dynamic> data = {"rebarpoints": loggedInUser.rebarpoints,"points":loggedInUser.points};
                      FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
                      Map<String, dynamic> data1 = {"zarapoints": UserZP,"points":UserPoints};
                      FirebaseFirestore.instance.collection("users").doc(UserID).update(data1);
                      showDoneDialog();
                    }
                    //rebar to golda
                    else if (selectedItem == 'Rebar' && (loggedInUser.rebarpoints! - points > 0) && selectedItem2 == 'Golda') {
                      loggedInUser.rebarpoints = loggedInUser.rebarpoints! - points;
                      UserGP = UserGP + points;
                      UserPoints = UserPoints + points;
                      loggedInUser.points = loggedInUser.points! - points;

                      player.play('tada.mp3');
                      Fluttertoast.showToast(
                        msg: "Transfer Completed!\nyou've sent $points Rebar Points to $UserFirstName Golda's!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.lightGreen,
                        textColor: Colors.white,
                        fontSize: 14,);
                      Map<String, dynamic> data = {"rebarpoints": loggedInUser.rebarpoints,"points":loggedInUser.points};
                      FirebaseFirestore.instance.collection("users").doc(user?.uid).update(data);
                      Map<String, dynamic> data1 = {"goldapoints": UserGP,"points":UserPoints};
                      FirebaseFirestore.instance.collection("users").doc(UserID).update(data1);
                      showDoneDialog();
                    }

                    //if sending more than allowed
                    else {
                      Fluttertoast.showToast(
                        msg: "Error: Insufficient points!\nYou're sending more than you have!",
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
              height: 118.42,
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
                  MaterialPageRoute(builder: (context) => const MyWallet()));
            },
            child: const Icon(Icons.card_giftcard_sharp),
            label: 'My Wallet',
          ),
          SpeedDialChild(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EnterPoints()));
            },
            child: const Icon(Icons.qr_code_scanner),
            label: 'Enter New Points',

          ),
          SpeedDialChild(
            onTap: () {
              Navigator.pushAndRemoveUntil<dynamic>(context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const HomeScreen(),), (
                    route) => false, //if you want to disable back feature set to false
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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
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



        
    
      





