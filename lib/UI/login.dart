import 'package:empire_furniture_city/UI/home.dart';
import 'package:empire_furniture_city/constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'input_field.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  var auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Scaffold
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.lightBlueAccent,
        child: Stack(
          children: <Widget>[
            const Align(
              alignment: Alignment.bottomRight,
              heightFactor: 0.5,
              widthFactor: 0.5,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(200.0)),
                color: Color.fromRGBO(255, 255, 255, 0.4),
                child: SizedBox(
                  width: 400,
                  height: 400,
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 400,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Material(
                        elevation: 10.0,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/soccer.png",
                            width: 80,
                            height: 80,
                          ),
                        )),
                    Form(
                      child: InputField(
                          email,
                          //Calling inputField  class

                          const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          "Username"),
                    ),
                    Form(
                      child: InputField(
                          password,
                          const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          "Password"),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        //Raised Button
                        onPressed: () {
                          loginUser();
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            )),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        moveToHome();
                      },
                      child: const Text(
                        'Continue without sign in',
                        style: TextStyle(
                          color: Colors.indigo,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginUser() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
        moveToHome();
      }).catchError((error) {
        debugPrint(error.toString());
      });
    }
  }

  void moveToHome() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Home(
            title: Constants.businessName,
            analytics: analytics,
            observer: observer)));
  }
}
