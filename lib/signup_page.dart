
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shrine/db_handler.dart';
import 'package:shrine/user_db.dart';
import 'package:alert_dialog/alert_dialog.dart';


class SignupPage extends StatefulWidget {
  @override
  _Signup createState()=>_Signup();
}

class _Signup extends State<SignupPage>{
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController c_password = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  GlobalKey<FormState> signupkey = GlobalKey<FormState>();

  var database;

  void initState(){
    super.initState();
    database = DbHelper();
  }


  //DATABASE INSERT INTO TRIGGER PAKAI VAR DATABASE
  signup() async {
    String _username = username.text;
    String _email = email.text;
    String _pw = password.text;
    String cpw = c_password.text;
    String phone = phoneNo.text;

    if (signupkey.currentState!.validate()) {
      if (_pw != cpw) {

        return alert(context, title: Text('Password Mismatch', textAlign: TextAlign.center), content: Text('Please check password'), textOK: Text('OK'),);

      } else {
        signupkey.currentState!.save();

        UserDetail uModel = UserDetail(_username, _email, _pw, phone);
        await database.saveData(uModel).then((userData) {

          return alert(context, title: Text('Create Account Success', textAlign: TextAlign.center), content: Text('Successfully Saved'), textOK: Text('OK'),);

        }).catchError((error) {
          print(error);

          return alert(context, title: Text('Error', textAlign: TextAlign.center), content: Text('Username already exist'), textOK: Text('OK'),);

        });
      }
    }
  }

  @override
  Widget build (BuildContext context)
  {
    bool isvalid = EmailValidator.validate(email.text);
    print(isvalid);
    return Scaffold(
        resizeToAvoidBottomInset: false,

        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading:
          IconButton( onPressed: (){
            Navigator.pop(context);
          },icon:const Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Form(
               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                key: signupkey,
                child: Column(
                  children: [
                Column(
                children: [
                Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text ("Sign up", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                    const SizedBox(height: 20,),
                    Text("Fill the form to create account",style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),),
                    const SizedBox(height: 30,)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: username,
                        decoration: InputDecoration(hintText: 'username', border: OutlineInputBorder(),),
                        validator: (value){
                          if(value!.isEmpty)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Username empty!')),
                              );
                            }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 30,),

                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(hintText: 'email', border: OutlineInputBorder(),),
                        validator: (value){
                          if(value!.isEmpty)
                          {

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('email empty!')),
                            );
                          }
                          else if(isvalid){
                            return null;
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Enter Valid Email!')),
                            );
                          }
                        },
                      ),

                      SizedBox(height: 30,),
                      TextFormField(
                        controller: phoneNo,
                        decoration: InputDecoration(hintText: 'Phone Number', border: OutlineInputBorder(),),
                        validator: (value){
                          if(value!.isEmpty)
                          {

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Phone number empty!')),
                            );
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 30,),
                      TextFormField(
                        controller: password,
                        decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder(),),
                        validator: (value){
                          if(value!.isEmpty)
                          {

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Password empty!')),
                            );
                          }
                          else{
                            return null;
                          }
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 30,),
                      TextFormField(
                        controller: c_password,
                        decoration: InputDecoration(hintText: 'Confirm password', border: OutlineInputBorder(),),
                        validator: (value){
                          if(value!.isEmpty)
                          {

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Password not match!')),
                            );
                          }
                          else{
                            return null;
                          }
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 50,),
                      FloatingActionButton.extended(
                        extendedPadding: EdgeInsets.all(150),

                        onPressed: signup,  label: Text('Sign up'),

                      ),
                    ],
                  ),
                ),
                    ],

                  ),
                  ],

                ),

              ),
            ),
          ),
        ),
      );
    }
  }




