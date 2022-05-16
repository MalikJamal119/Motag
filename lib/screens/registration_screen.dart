import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //our form key
  final _formKey = GlobalKey<FormState>();
  //editing controller
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    // first name field
    final firstNameField = new TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      //validator: () {},
      onSaved: (value)
      {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          )
      ),
    );
    //second name field
    final secondNameField = new TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      //validator
      onSaved: (value)
      {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          )
      ),
    );
//email field
    final emailField = new TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      //validator
      onSaved: (value)
      {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          )
      ),
    );
//password field
    final passwordField = new TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      //validator
      onSaved: (value)
      {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          )
      ),
    );
//password confirmation field
    final confirmPasswordField = new TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      //validator
      onSaved: (value)
      {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){},
        child: Text('SignUp',textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),),
      ),
    );





    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.lightGreen,),
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
                    SizedBox(height: 15),
                    firstNameField,
                    SizedBox(height: 10),
                    secondNameField,
                    SizedBox(height: 10),
                    emailField,
                    SizedBox(height: 10),
                    passwordField,
                    SizedBox(height: 10),
                    confirmPasswordField,
                    SizedBox(height: 10),
                    signUpButton,
                    SizedBox(height: 15,)



                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


