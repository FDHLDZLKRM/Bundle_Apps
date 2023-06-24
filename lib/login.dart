

import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrine/db_handler.dart';
import 'package:shrine/signup_page.dart';
import 'package:shrine/user_db.dart';
import '/home.dart';
import'/app.dart';
import 'colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  GlobalKey<FormState> loginkey = GlobalKey<FormState>();
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  var database;

  @override
  void initState(){
    super.initState();
    database = DbHelper();
  }

// check database logic.
  login() async{
    String username = _usernameController.text;
    String passwd = _passwordController.text;

    if (username.isEmpty) {

      return alert(context, title: Text('Username Empty', textAlign: TextAlign.center), content: Text('Please Enter Username'), textOK: Text('OK'),);



    } else if (passwd.isEmpty) {

      return alert(context, title: Text('Password Empty', textAlign: TextAlign.center), content: Text('Please Enter Password'), textOK: Text('OK'),);


    } else {
      //trigger database class pakai 'database'
      await database.getLoginUser(username, passwd).then((userData) {
        if (userData != null) {

          // data check betul dia push and remove until
          //mksud dia route tu dh xboleh back
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomePage(username : username)), (Route<dynamic> route) => false);


          });
          //return alert(context, title: Text('Login Successfull', textAlign: TextAlign.center), content: Text('Welcome To Skyrider Airlines'), textOK: Text('OK'),);
        } else {

          return alert(context, title: Text('Error', textAlign: TextAlign.center), content: Text('User Not Found. Please Create an Account'), textOK: Text('OK'),);


        }
      }).catchError((error) {
        print(error);

        return alert(context, title: Text('Error',textAlign: TextAlign.center), content: Text('Login Fail'), textOK: Text('OK'),);

        });
    }

  }

  Future setSP(UserDetail user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_name", user.user_name);
    sp.setString("password", user.password);
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: ListView(

            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              const SizedBox(height: 80.0),
              Column(
                children: <Widget>[
                  Image.asset('assets/Bundle_logo.png'),
                  const SizedBox(height: 16.0),

                ],
              ),
              const SizedBox(height: 120.0),
              //FORM UTK COLLECT LOGIN INPUT DARI USER
              Form(
                key: loginkey,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(

                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 12.0),
                    OverflowBar(
                      alignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Center(
                          child: ElevatedButton(
                            child: const Text('LOG IN'),
                            onPressed: login,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: kShrineBrown900,
                              backgroundColor: kShrinePink100,
                              elevation: 8.0,
                              shape: const BeveledRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(7.0)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                            children: <Widget>[
                              const Text('Create an account, it''s' +
                                  'less than a minute.',),
                              TextButton(onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                              },
                                  child: Text('SIGN UP',
                                    style: TextStyle(fontSize: 18),)),

                            ]

                        ),

                      ],
                    ),
                  ],

                ),
              ),
            ],
          ),
        ),
      );
    }
  }

