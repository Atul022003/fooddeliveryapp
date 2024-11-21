import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {   @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}
 class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("ProfilePAge"),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10,left: 20),
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.green,
              backgroundImage: NetworkImage(user?.photoURL ?? ""),

            ),


          ),
          SizedBox(height: 20,),
          Text(user?.displayName ?? "",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          SizedBox(height: 20,),
          Text(user?.email ?? "",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign:TextAlign.end,),
          Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    ElevatedButton(
    onPressed: () {},
    child: Text('Edit Profile'),
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    padding: EdgeInsets.symmetric(horizontal: 30),
    ),
    ),


    SizedBox(height: 40,),
    OutlinedButton(onPressed: (){},
    child: Text("Logout"),
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.black,
    padding: EdgeInsets.symmetric(horizontal: 30),
    side: BorderSide(color: Colors.blueAccent),
    ),),
        ],
    ),

    ])
    );
  }
}
