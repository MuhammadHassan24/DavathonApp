import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davathon_app/Screens/doctor_details.dart';
import 'package:davathon_app/Screens/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home_View extends StatefulWidget {
  const Home_View({super.key});

  @override
  State<Home_View> createState() => _Home_ViewState();
}

class _Home_ViewState extends State<Home_View> {
  int selectedindex = 0;
  List category = ["All", "Madicine", "Cadiology", "General"];
  logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Login_View()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffB28CFF),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
                color: Color(0xffB28CFF),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 340,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Search Your Doctor",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(27))),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Welcome Back",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Lets find your top doctor!",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Doctor's Inn",
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 75,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: category.length,
                padding: EdgeInsets.only(top: 0),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedindex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            color: selectedindex == index
                                ? Color(0xffB28CFF)
                                : Colors.white54,
                            borderRadius: selectedindex == index
                                ? BorderRadius.circular(15)
                                : BorderRadius.circular(10),
                            border: selectedindex == index
                                ? Border.all(color: Color(0xffB28CFF))
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              category[index].toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
                child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("doctor").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      // --------------------------return custom container to view data-----------------
                      return InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1),
                          ),
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 110,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 65,
                                        width: 50,
                                        child: Image.network(
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgut-XrUTj4kq8azPG0BcV3bwfaDrOvAEicg&usqp=CAU"),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star),
                                          Text("4.3")
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data["name"],
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(data["address"])
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 130),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Doctor_Details(doctordetail: data);
                            },
                          ));
                        },
                      );
                    }).toList(),
                  );
                }
                return Center(
                    child: Container(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator()));
              },
            )),
          )
        ],
      ),
    );
  }
}
