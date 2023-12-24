import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Doctor_Details extends StatefulWidget {
  final Map<String, dynamic> doctordetail;
  const Doctor_Details({super.key, required this.doctordetail});

  @override
  State<Doctor_Details> createState() => _Doctor_DetailsState();
}

class _Doctor_DetailsState extends State<Doctor_Details> {
  int selectedindex = 0;
  List doctortiming = [
    "11:00AM",
    "12:00AM",
    "04:00AM",
    "05:00AM",
    "07:00AM",
    "08:00AM",
  ];
  final lastdatecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            "Appointment",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                height: 90,
                width: 80,
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgut-XrUTj4kq8azPG0BcV3bwfaDrOvAEicg&usqp=CAU",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              widget.doctordetail["name"],
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              padding: EdgeInsets.all(15),
              height: 140,
              width: 350,
              decoration: BoxDecoration(
                  color: Color(0xffB28CFF),
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 130,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "350+",
                          style: TextStyle(fontSize: 30),
                        ),
                        Text("Patients"),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 130,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "5+",
                          style: TextStyle(fontSize: 30),
                        ),
                        Text("Exp-Years"),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 130,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "200+",
                          style: TextStyle(fontSize: 30),
                        ),
                        Text("Reviews"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About Doctor",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Dr. Maria Waston is the top most Cardiologist specialist in Nanyang Hospotalat London. She is available for private consultation.",
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Date",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  width: 280,
                  child: TextFormField(
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2030));
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        setState(() {
                          lastdatecontroller.text = formattedDate;
                        });
                      }
                    },
                    controller: lastdatecontroller,
                    decoration: InputDecoration(
                      labelText: "Enter Date",
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Visit Hour",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 75,
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemCount: doctortiming.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedindex = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            height: 20,
                            width: 80,
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
                                doctortiming[index].toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffB28CFF)),
                  onPressed: () {},
                  child: Text("Book Appointment")))
        ],
      ),
    );
  }
}
