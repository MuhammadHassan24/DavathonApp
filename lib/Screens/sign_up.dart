import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davathon_app/Screens/doctor_signup.dart';
import 'package:davathon_app/Screens/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup_View extends StatefulWidget {
  const Signup_View({super.key});

  @override
  State<Signup_View> createState() => _Signup_ViewState();
}

class _Signup_ViewState extends State<Signup_View> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final paswordcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  String drCategory = "All";
  List<String> drCategorylist = ["All", "Gerenal", "Madicine", "Cadiology"];
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
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "email": emailcontroller.text,
      "name": namecontroller.text,
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
                height: 450,
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
                         
                           SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 280,
                            child: DropdownButtonFormField<String>(
                              value: drCategory,
                              onChanged: (String? newValue) {
                                setState(() {
                                  drCategory = newValue!;
                                });
                              },
                              items: drCategorylist.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
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
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Doctor_Sigup_View()));
                            },
                            child: Text("Register For Doctor!"),
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
