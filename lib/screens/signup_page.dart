import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khana_delivery/providers/auth_provider.dart';
import 'package:khana_delivery/screens/homePage.dart';
import 'package:khana_delivery/utils.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return SignupPageState();
  }


}
class SignupPageState extends State<SignupPage>{

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final authProvider = Provider.of<AuthenticationProvider>(context,listen: false);
      final user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;

      if(user != null){

        final status = await authProvider.registerUser(user.uid,
            user.displayName ?? "", user.photoURL ?? "", user.email ?? "");

        if(status){
          Utils.showToast("User logged in!");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) => false, // Remove all previous routes
          );
        } else {
          Utils.showToast("There was some issue registering user");
        }
      } else {
          Utils.showToast("Google S ign In Failed");
      }
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
   return Scaffold
     (body:Column(
     children: [
       Container(
         width: double.infinity,
         height: screenHeight * 0.5,
         decoration: BoxDecoration(
             image: DecorationImage(
               image:NetworkImage("https://unsplash.com/photos/5GK0KjhBLs4/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Mzh8fGZvb2R8ZW58MHx8fHwxNzI5MjE2NTg2fDA&force=true&w=640"),
               fit: BoxFit.cover,
             )
         )
       ),//
       Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [

         SizedBox(height: 27,),

         Padding(padding: EdgeInsets.symmetric(horizontal: 30),child: Text("Khana pohchaye minto me, apke ghar par turant",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:25),textAlign: TextAlign.center,),),
         SizedBox(height: 27,),
         Text("Log in or sign up",style: TextStyle(fontSize: 18),), SizedBox(height: 27,),
         OutlinedButton.icon(
           onPressed: () {
             signInWithGoogle();
           },
           style: OutlinedButton.styleFrom(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
           ),
           icon: Image.network("https://pngimg.com/d/google_PNG19635.png",width: 30,height: 30,),
           label: Text("Continue with Google", style: TextStyle(fontSize: 17)),
         ),
           SizedBox(height: 20,),
           Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: Text("By continuing,you agree to our Terms of Service, Privacy Policy Content Policy",textAlign: TextAlign.center,),),

       ],)
     ],
   )



   );
  }

}