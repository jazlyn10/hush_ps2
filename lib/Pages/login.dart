import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hush/Pages/Register_page.dart';
import 'package:hush/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'fw_password.dart';

class Login extends StatefulWidget {
   Login({Key? key,required this.showRegisterpage}) : super(key: key);

   final VoidCallback showRegisterpage;


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordObscured = true;
  final emailController =TextEditingController();
  final passwordController =TextEditingController();
    String _error = '';
   void signin() async{

     try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
     } on FirebaseAuthException catch (e) {
       if (e.code == 'wrong-password') {
         setState(() {
           _error = 'The password is incorrect. Please try again.';
         });
       } else {
         setState(() {
           _error = 'Something went wrong. Please try again.';
         });
       }
     }



   }
  @override
  void dispose(){
     emailController.dispose();
     passwordController.dispose();
     super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:AppBar(systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.grey),),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(physics: NeverScrollableScrollPhysics(), children: [
            Container(
              height: 200,
              width: double.infinity,
              child: const Center(
                  child: Image(
                    image: AssetImage('assets/images/2.png'),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 900,
                width: double.infinity,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 14),
                      child: Center(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Username',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Color(0xFF42414D)),
                              ))),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: emailController,
                          decoration: InputDecoration(
                              filled: true,
                              suffixIcon: Icon(
                                Icons.account_box_outlined,
                                color: Colors.indigo,
                              ),
                              fillColor: const Color(0xFFF4F8FF),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.indigo, width: 2),
                                  borderRadius: BorderRadius.circular(11)))),
                    ),
                    const Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Center(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Password',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Color(0xFF42414D)),
                              ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: passwordController,
                          obscureText: passwordObscured,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFF4F8FF),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(
                                        () {
                                      passwordObscured = !passwordObscured;
                                    },
                                  );
                                },
                                child: Icon(
                                  passwordObscured
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.indigo,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.indigo, width: 2),
                                  borderRadius: BorderRadius.circular(11)))),
                    ),
                    Container(
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder:(context){
                                    return ForgotPasswordPage();
                                  }));
                                },
                                child: Text('Change password',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.indigoAccent,
                                        fontSize: 10)),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 14, 2, 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Expanded(
                            child: Divider(
                              height: 3,
                              color: Color(0xFFD5D9EE),
                              thickness: 1,
                            ),
                          ),
                          Text('        or        ',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                color: Color(0xFFC2C6D9),
                              )),
                          Expanded(
                            child: Divider(
                              color: Color(0xFFD5D9EE),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 49,
                              height: 49,
                              decoration: BoxDecoration(
                                color: Color(0xFFF4F8FF),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFF4F8FF).withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                border: Border.all(
                                    color: const Color(0xFFD5D9EE), width: 1),
                                borderRadius: BorderRadius.circular(11.0),
                              ),
                              child: InkWell(
                                  onTap:() => AuthService().signinWithGoogle(),
                                  child: Center(
                                      child: Image(
                                        image:
                                        AssetImage('assets/images/images.png'),
                                        height: 25,
                                        width: 25,
                                      )))),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          signin();
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF233C67),
                            minimumSize: Size(324, 49),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            )),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Text("Don't have an account?",style: TextStyle(fontFamily: 'poppins',fontSize: 10),),
                      TextButton(
                        onPressed:
                          widget.showRegisterpage
                        ,
                        child: Text('Sign up',
                            style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF2856D7), fontSize: 10)),
                      )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}