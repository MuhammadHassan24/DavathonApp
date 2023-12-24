import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davathon_app/Screens/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Doctor_Sigup_View extends StatefulWidget {
  const Doctor_Sigup_View({super.key});

  @override
  State<Doctor_Sigup_View> createState() => _Doctor_Sigup_ViewState();
}

class _Doctor_Sigup_ViewState extends State<Doctor_Sigup_View> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final paswordcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final addresscontrol = TextEditingController();

  registeruser() async {
    try {
      UserCredential Credentialuser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text,
        password: paswordcontroller.text,
      );
      String? uid = Credentialuser.user?.uid;
      if (uid != null) {
        adddataonfirestore(uid);

        emailcontroller.clear();
        namecontroller.clear();
        paswordcontroller.clear();
      }

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home_View()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  adddataonfirestore(String uid) async {
    await FirebaseFirestore.instance.collection("doctor").doc(uid).set({
      "email": emailcontroller.text,
      "name": namecontroller.text,
      "address": addresscontrol.text,
      "id": uid,
    });
  }

  registeralert() {
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
            Container(
              height: 200,
              child: Center(child: Image.asset("assets/images/Login_pic.png"))),
          
            Center(
              child: Container(
                color: Colors.white,
                height: 380,
                width: 280,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Name";
                              }
                              return null;
                            },
                            controller: namecontroller,
                            decoration: InputDecoration(
                              labelText: "Full Name",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: paswordcontroller,
                            validator: passwordvalidat,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: emailcontroller,
                            validator: validatemail,
                            decoration: InputDecoration(
                              labelText: "Email",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Address";
                              }
                              return null;
                            },
                            controller: addresscontrol,
                            decoration: InputDecoration(
                              labelText: "Address",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Container(
                              width: 150,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xffB28CFF)),
                                  onPressed: () {
                                    registeralert();
                                    registeruser();
                                  },
                                  child: Text(
                                    "Register",
                                    
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
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
