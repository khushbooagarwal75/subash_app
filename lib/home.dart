import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subash_app/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> quant = ["Low", "Medium", "High"];
  String? dropdownValue1;
  String? dropdownValue2;
  String? dropdownValue3;

  int count = 0;
  void logout() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Get.off(() => Login()));
  }

  void savependata() {
    if (dropdownValue1 != "") {
      Map<String, dynamic> data = {
        "product 1": dropdownValue1,
      };
      if (count == 0) {
        FirebaseFirestore.instance.collection("Quantity").doc("pen").set(data);
        count = 1;
      } else {
        FirebaseFirestore.instance
            .collection("Quantity")
            .doc("pen")
            .update(data);
      }
    }
  }

  void savepencildata() {
    if (dropdownValue2 != "") {
      Map<String, dynamic> data = {
        "product 2": dropdownValue2,
      };
      if (count == 0) {
        FirebaseFirestore.instance
            .collection("Quantity")
            .doc("pencil")
            .set(data);
        count = 1;
      } else {
        FirebaseFirestore.instance
            .collection("Quantity")
            .doc("pencil")
            .update(data);
      }
    }
  }

  void savebookdata() {
    if (dropdownValue3 != "") {
      Map<String, dynamic> data = {
        "product 3": dropdownValue3,
      };
      if (count == 0) {
        FirebaseFirestore.instance
            .collection("Quantity")
            .doc("books")
            .set(data);
        count = 1;
      } else {
        FirebaseFirestore.instance
            .collection("Quantity")
            .doc("books")
            .update(data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Subhash Stationery"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          shape: Border.all(width: 2),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  children: [
                    TableRow(children: [
                      Text("Particulars"),
                      Text("inventory"),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Pen"),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue1,
                        hint: Text("Select Quantity"),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue1 = newValue!;

                            savependata();
                          });
                        },
                        items: quant
                            .map((e) => DropdownMenuItem<String>(
                                value: e, child: Text(e)))
                            .toList(),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Pencil"),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue2,
                        hint: Text("Select Quantity"),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue2 = newValue!;
                            savepencildata();
                          });
                        },
                        items: quant
                            .map((e) => DropdownMenuItem<String>(
                                value: e, child: Text(e)))
                            .toList(),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Books"),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue3,
                        hint: Text("Select Quantity"),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue3 = newValue!;
                            savebookdata();
                          });
                        },
                        items: quant
                            .map((e) => DropdownMenuItem<String>(
                                value: e, child: Text(e)))
                            .toList(),
                      ),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      logout();
                    },
                    child: Text("LogOut")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
