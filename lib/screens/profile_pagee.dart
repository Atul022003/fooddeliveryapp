import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePagee extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProfilePageeState();
  }

}
class ProfilePageeState extends State<ProfilePagee>{
  Widget listTile({ required IconData icon, required String title}){
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
     return Column(children: [
       Container(child: Column(
         children: [

           Container(
               height: 120,width: double.infinity,
               color: Colors.white10,
               padding: EdgeInsets.only(top: 10),
               child: Row(children: [
                 CircleAvatar(
                   radius: 50,
                   backgroundColor: Colors.white54,
                   backgroundImage: NetworkImage(
                       user?.photoURL ?? ""
                   ),
                 ),
                 Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                     children: [
                       Text(user?.displayName ?? "",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                       Text(user?.email ?? "",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign:TextAlign.end,),
                     ])
               ]
               )
           ),


         ],
       ),





       ),
       Expanded(child:Container(
         width: double.infinity,
         padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.only(
             topLeft: Radius.circular(30),
             topRight: Radius.circular(30),
           ),
         ),
         child: ListView(
           children: [
             listTile(icon: Icons.edit, title:"Edit Profile"),
             listTile(icon: Icons.shop, title:"My Orders"),
             listTile(icon: Icons.location_on_outlined, title:"My Delivery Address"),
             listTile(icon: Icons.person_outlined, title:"Refer a Friend"),
             listTile(icon: Icons.policy_outlined, title:"Terms ans Conditions"),
             listTile(icon: Icons.add_chart, title:"Add Cart"),
             listTile(icon: Icons.exit_to_app_outlined, title:"Logout"),

           ],
         ),

       ))
     ]);


  }

}