import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user_login/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  Future<FirebaseUser> login(String email, String pass) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e);
      return null;
    }

  }

//  Future<bool> loginUser(String phone, BuildContext context) async{
//    FirebaseAuth _auth = FirebaseAuth.instance;
//
//    _auth.verifyPhoneNumber(
//        phoneNumber: phone,
//        timeout: Duration(seconds: 60),
//        verificationCompleted: (AuthCredential credential) async{
//          Navigator.of(context).pop();
//
//          AuthResult result = await _auth.signInWithCredential(credential);
//
//          FirebaseUser user = result.user;
//
//          if(user != null){
//            Navigator.push(context, MaterialPageRoute(
//              builder: (context) => HomeScreen(user: user,)
//            ));
//          }else{
//            print("Error");
//          }
//
//          //This callback would gets called when verification is done auto maticlly
//        },
//        verificationFailed: (AuthException exception){
//          print(exception);
//        },
//        codeSent: (String verificationId, [int forceResendingToken]){
//          showDialog(
//            context: context,
//            barrierDismissible: false,
//            builder: (context) {
//              return AlertDialog(
//                title: Text("Give the code?"),
//                content: Column(
//                  mainAxisSize: MainAxisSize.min,
//                  children: <Widget>[
//                    TextField(
//                      controller: _codeController,
//                    ),
//                  ],
//                ),
//                actions: <Widget>[
//                  FlatButton(
//                    child: Text("Confirm"),
//                    textColor: Colors.white,
//                    color: Colors.blue,
//                    onPressed: () async{
//                      final code = _codeController.text.trim();
//                      AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);
//
//                      AuthResult result = await _auth.signInWithCredential(credential);
//
//                      FirebaseUser user = result.user;
//
//                      if(user != null){
//                        Navigator.push(context, MaterialPageRoute(
//                            builder: (context) => HomeScreen(user: user,)
//                        ));
//                      }else{
//                        print("Error");
//                      }
//                    },
//                  )
//                ],
//              );
//            }
//          );
//        },
//        codeAutoRetrievalTimeout: null
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Login", style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.w500),),

                  SizedBox(height: 16,),

                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Email"
                    ),
                    controller: _emailController,
                  ),

                  SizedBox(height: 16,),

                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Password"
                    ),
                    controller: _passController,
                  ),

                  SizedBox(height: 16,),

                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      child: Text("LOGIN"),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: () async{
                        final email = _emailController.text.toString().trim();
                        final pass = _passController.text.toString().trim();

                        FirebaseUser user = await login(email, pass);

                        if(user != null){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen(name: user.displayName, imageUrl: user.photoUrl, )
                          ));
                        } else {
                          print("Error");
                        }
                      },
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
