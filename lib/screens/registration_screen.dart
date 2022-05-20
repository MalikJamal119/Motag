import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  //our form key
  final _formKey = GlobalKey<FormState>();
  //editing controller
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // first name field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value){
        RegExp regex = RegExp(r'^.{3,}$');
        if(value!.isEmpty)
        {
          return("First Name is required for SignUp");
        }
        if(!regex.hasMatch(value))
        {
          return("Your First Name is too short(Min. 3 Characters)");
        }
      },
      onSaved: (value)
      {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          )
      ),
    );
    //second name field
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value){
        RegExp regex = RegExp(r'^.{3,}$');
        if(value!.isEmpty)
        {
          return("Second Name is required for SignUp");
        }
        if(!regex.hasMatch(value))
        {
          return("Your Second Name is too short(Min. 3 Characters)");
        }
      },
      onSaved: (value)
      {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          )
      ),
    );
//email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value)
      {
        if(value!.isEmpty)
        {
          return("Please Enter Your Email");
        }
        //reg expression for email validation
        if(!RegExp("^[a-zA-z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
        {
          return("Please Enter a valid email!");
        }
        return null;
      },
      onSaved: (value)
      {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          )
      ),
    );
//password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value){
        RegExp regex = new RegExp(r'^.{6,}$');
        if(value!.isEmpty)
        {
          return("Password is required for SignUp");
        }
        if(!regex.hasMatch(value))
        {
          return("Please Enter a Valid Password(Min. 6 Characters)");
        }
      },
      onSaved: (value)
      {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          )
      ),
    );
//password confirmation field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if(confirmPasswordEditingController.text != passwordEditingController.text) {
          return "Password does not match!";
        }
        return null;
      },
      onSaved: (value)
      {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          )
      ),
    );

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.lightGreen,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text('SignUp',textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),),
      ),
    );





    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.lightGreen,),
          onPressed: (){
            // passing this to our root
            Navigator.of(context).pop();
      },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(

            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children:<Widget> [
                    SizedBox(

                        height: 200,
                        child: Image.asset('images/motag.png',

                          fit: BoxFit.contain,)
                    ),
                    const SizedBox(height: 5),
                    firstNameField,
                    const SizedBox(height: 5),
                    secondNameField,
                    const SizedBox(height: 5),
                    emailField,
                    const SizedBox(height: 5),
                    passwordField,
                    const SizedBox(height: 5),
                    confirmPasswordField,

                    const SizedBox(height: 15),
                    signUpButton,




                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  void signUp(String email,String password) async{
    if(_formKey.currentState!.validate()) {
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }


  postDetailsToFirestore() async
  {
    // calling our firestore
    //calling our user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;
    userModel.password = passwordEditingController.text;
    userModel.points = 0;
    userModel.zarapoints = 0;
    userModel.goldapoints = 0;
    userModel.rebarpoints = 0;
    userModel.zaramember = false;
    userModel.goldamember = false;
    userModel.rebarmember = false;




    await firebaseFirestore.collection("users").doc(user.uid).set(userModel.toMap());

    Fluttertoast.showToast(msg: "Signed Up successfully!:)");

    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);




  }
}





