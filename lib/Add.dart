import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Account.dart';
import 'Homepage.dart';
import 'Signup.dart';
import 'Trash.dart';

class Add extends StatefulWidget {
  const Add({ Key? key }) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _title=TextEditingController();
  TextEditingController _content=TextEditingController();

    Widget _portraitMode(){
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Scaffold(
      appBar: AppBar(
        title: Text("Add"),
      ),

      drawer: Drawer(
        child: Container(
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height/12,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black12,
                      ),
                  onPressed: () { 
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Account()));
                   },
                  child: Row(
                    children: [
                      Expanded(flex:3,child:Text("Account",style: TextStyle(fontSize: 20,),)),
                      Expanded(child: Icon(Icons.account_circle),flex: 1),
                    ],
                  ),
                ),
              ),
              Divider(height: 2,),
              Container(
                height: MediaQuery.of(context).size.height/12,
                child: ElevatedButton(
                  onPressed: () { 
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
                   },
                  child: Row(
                    children: [
                      Expanded(flex:3,child:Text("Home",style: TextStyle(fontSize: 20,),)),
                      Expanded(child: Icon(Icons.home),flex: 1),
                    ],
                  ),
                ),
              ),
              Divider(height: 2,),
              Container(
                height: MediaQuery.of(context).size.height/12,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Trash()));
                  },
                  child: Row(
                    children: [
                      Expanded(child: Text("Trash",style: TextStyle(fontSize: 20,),),flex: 3,),
                      Expanded(child: Icon(Icons.delete),flex: 1,),
                    ],
                  ),
                ),
              ),
              Divider(height: 2,),
              Container(
                height: MediaQuery.of(context).size.height/12,
                child: ElevatedButton(
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                  },
                  child: Row(
                    children: [
                      Expanded(child: Text("Logout",style: TextStyle(fontSize: 20,),),flex: 3,),
                      Expanded(child: Icon(Icons.logout),flex: 1,),
                    ],
                  ),
                ),
              ),
              Divider(height: 2,),
            ],
      ),
        ),
      ),

      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: MediaQuery.of(context).size.height / 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  controller: _title,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    hintText: 'Title',
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: MediaQuery.of(context).size.height / 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  controller: _content,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    hintText: 'Content',
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: MediaQuery.of(context).size.height / 14,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink.shade400, Colors.pink.shade300]),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                
                child: MaterialButton(
                    onPressed: () {
                      //
                      List<String> key = [];
                      String temp = "";
                      for (int i = 0; i < _title.text.length; i++) {
                        temp = temp + _title.text[i].toUpperCase();
                        key.add(temp);
                      }
                      temp="";
                      for (int i = 0; i < _title.text.length; i++) {
                        temp = temp + _title.text[i].toLowerCase();
                        key.add(temp);
                      }
                      //
                      var firebaseUser =  FirebaseAuth.instance.currentUser;
                      FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid).collection("notes").add(
                          {
                            "Title" : _title.text,
                            "content":_content.text,
                            "ID":" ",
                            "Date & Time":DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
                            "Key":key,
                          }
                      ).then((value){
                        FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).collection("notes").doc(value.id).update(
                            {
                              "ID":value.id,
                            }
                        );
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
                    },
                    child: Text("Add",style: TextStyle(fontSize: 20),)),
              ),
            ],
          ),
        ),
      ),
    ),
      ],
    );
  }

  Widget _landscapeMode(){
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
          ],
        ),
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation){
        if(orientation == Orientation.portrait){
          return _portraitMode();
        }else{
          return _landscapeMode();
        }
      },
    );
  }
}