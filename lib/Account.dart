import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Homepage.dart';
import 'Signup.dart';
import 'Trash.dart';

class Account extends StatefulWidget {
  const Account({ Key? key }) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _usname=TextEditingController();
  bool _vi=false;
  var us,id;

  @override
  void initState() {
    FirebaseFirestore.instance.collection("users")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection("User Data")
    .where('Email',isEqualTo: FirebaseAuth.instance.currentUser!.email)
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            _usname.text=doc["Username"];
            id=doc["ID"];
        });
    });
  }

    Widget _portraitMode(){
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Scaffold(
      appBar: AppBar(
        title: Text("Account")
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height/12,
                child: ElevatedButton(
                  onPressed: () { 
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Account()));
                   },
                  child: Row(
                    children: [
                      Expanded(flex:3,child:Text("Account",style: TextStyle(fontSize: 20),)),
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
              Divider(height: 2),
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
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(children: [
            SizedBox(height: 30,),
             
                      SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.height / 10.5,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                              child: Center(
                                child: Text("Username    :",style:TextStyle(fontSize: 20)),
                              ),
                            )),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: TextFormField(
                                  enabled: _vi,
                                  style: TextStyle(fontSize: 20),
                                  controller: _usname,
                                  decoration: InputDecoration(
			                            border: (_vi==false)?InputBorder.none:OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter a valid username!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(icon: Icon((_vi == false)?Icons.edit:Icons.update),
                                  onPressed: (){
                                  if(_vi == true){
                                    setState(() {
                                      _vi = false;
                                    });
                                    //
                                    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("User Data").doc(id).update({"Username":_usname.text});
                                    //
                                  }
                                  else{
                                    setState(() {
                                      _vi = true;
                                    });
                                  }
                                  },
                                ),
                            ),
                          ],
                        ),
                      ),
             SizedBox(height: 20,),
             Container(
               decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 10.5,
              child: Center(child: Text("Email  : "+(FirebaseAuth.instance.currentUser!.email).toString(),style: TextStyle(fontSize: 20),)),
             ),
             SizedBox(height: 20,),
             Container(
               width: MediaQuery.of(context).size.width/1.2,
               height: MediaQuery.of(context).size.height/10.5,
               decoration: BoxDecoration(
                 gradient: LinearGradient(
                colors: [Colors.pink.shade400, Colors.pink.shade300]), 
                borderRadius: BorderRadius.circular(15),
              ),
              child: MaterialButton(
                child: Center(child: Text("Delete Account",style: TextStyle(fontSize: 20)),),
                onPressed: (){
                  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).delete().then((value) => FirebaseAuth.instance.currentUser!.delete());
                },
              ),
             ),
          ],),
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
        new Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(),
            ),
          Expanded(
            flex: 9,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Column(children: [
                  SizedBox(height: 30,),
                            SizedBox(height: 20,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.height / 10.5,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                    child: Center(
                                      child: Text("Username    :",style:TextStyle(fontSize: 20)),
                                    ),
                                  )),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      child: TextFormField(
                                        enabled: _vi,
                                        style: TextStyle(fontSize: 20),
                                        controller: _usname,
                                        decoration: InputDecoration(
                                            border: (_vi==false)?InputBorder.none:OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter a valid username!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(icon: Icon((_vi == false)?Icons.edit:Icons.update),
                                        onPressed: (){
                                        if(_vi == true){
                                          setState(() {
                                            _vi = false;
                                          });
                                          //
                                          FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("User Data").doc(id).update({"Username":_usname.text});
                                          //
                                        }
                                        else{
                                          setState(() {
                                            _vi = true;
                                          });
                                        }
                                        },
                                      ),
                                  ),
                                ],
                              ),
                            ),
                   SizedBox(height: 20,),
                   Container(
                     decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 10.5,
                    child: Center(child: Text("Email  : "+(FirebaseAuth.instance.currentUser!.email).toString(),style: TextStyle(fontSize: 20),)),
                   ),
                   SizedBox(height: 20,),
                   Container(
                     width: MediaQuery.of(context).size.width/1.2,
                     height: MediaQuery.of(context).size.height/10.5,
                     decoration: BoxDecoration(
                       gradient: LinearGradient(
                      colors: [Colors.pink.shade400, Colors.pink.shade300]), 
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: MaterialButton(
                      child: Center(child: Text("Delete Account",style: TextStyle(fontSize: 20)),),
                      onPressed: (){
                        FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).delete().then((value) => FirebaseAuth.instance.currentUser!.delete());
                      },
                    ),
                   ),
                ],),
              ),
            ),
          ),
        ],
      ),
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