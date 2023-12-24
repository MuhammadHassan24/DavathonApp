import 'package:davathon_app/Screens/home_view.dart';
import 'package:davathon_app/Screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login_View extends StatefulWidget {
  const Login_View({super.key});

  @override
  State<Login_View> createState() => _Login_ViewState();
}

class _Login_ViewState extends State<Login_View> {
  final _formkey = GlobalKey<FormState>();
  final emailcontrollor = TextEditingController();
  final paswordcontrollor = TextEditingController();
  loginuser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontrollor.text,
        password: paswordcontrollor.text,
      );
      print("Login Ho gaya");
      emailcontrollor.clear();
      paswordcontrollor.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home_View()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  useralert() {
    if (_formkey.currentState!.validate()) {}
  }

  String? validatemail(value) {
    if (value!.isEmpty) {
      return "Please Enter Your Email";
    }
    RegExp emailregexp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailregexp.hasMatch(value)) {
      return "Please Enter Valid Email";
    }
    return null;
  }

  String? passwordvalidat(value) {
    if (value.isEmpty) {
      return "Please Enter Your Email";
    }
    if (value.length < 8) {
      return "Please Enter 8 Digit Password";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                left: 50,
                right: 50,
                top: 50,
                child: Image.asset("assets/images/Login_pic.png")),
            Positioned(
                top: 250,
                right: 50,
                left: 130,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                )),
            Positioned(
              top: 250,
              right: 50,
              left: 50,
              child: Container(
                height: 350,
                width: 280,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: Column(
                    children: [
                      Form(
                        key: _formkey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: TextFormField(
                                  validator: validatemail,
                                  controller: emailcontrollor,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: passwordvalidat,
                                controller: paswordcontrollor,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Container(
                                  width: 180,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: BeveledRectangleBorder(),
                                        backgroundColor: Color(0xffB28CFF),
                                      ),
                                      onPressed: () {
                                        loginuser();
                                      },
                                      child: Text("Login")),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signup_View()));
                                  },
                                  child: Text(
                                    "Register Your Account!",
                                    
                                  ))
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
