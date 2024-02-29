import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subash_app/firebase_options.dart';
import 'package:subash_app/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (FirebaseAuth.instance.currentUser != null) ? Home() : Login(),
    );
  }
}

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email_tc = TextEditingController();

  TextEditingController password_tc = TextEditingController();

  bool visible = false;

  void _showMessage(String message) {
    Get.snackbar(
      "Authentication",
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
      backgroundColor: Colors.black,
      colorText: Colors.amberAccent,
    );
  }

  void login() async {
    String email = email_tc.text.trim();
    String password = password_tc.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        if (userCredential.user?.uid == "CuzZwIWRXVX1YYqHmqzKm9XxaXt2") {
          Get.off(() => Home());
        }
      }
    } on FirebaseAuthException catch (ex) {
      _showMessage(ex.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: Image.asset("assets/images/stationary.jpg"),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Log in"),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: email_tc,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2,
                          ))),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter  email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: password_tc,
                      decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(visible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2,
                          ))),
                      obscureText: visible,
                      obscuringCharacter: "*",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter  password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login();
                            } else {
                              Get.snackbar(
                                  "Message:", "Please fill both the fields");
                            }

                            // Navigator.push(context, MaterialPageRoute(builder: (context) {
                            //   return Home();
                            // },))
                          },
                          child: Text("Log In")),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
