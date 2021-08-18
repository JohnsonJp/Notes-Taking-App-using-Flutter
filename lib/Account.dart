import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Homepage.dart';
import 'Signup.dart';
import 'Trash.dart';
import 'view.dart';

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

  //home
  TextEditingController _sea=new TextEditingController(text: "");
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  var title;
  var content;
  List keya=[];
  var sea ="";
  var _hint;
  var _date;
  bool _search=false;

  @override
  // ignore: must_call_super
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
        backgroundColor: (Theme.of(context).brightness == Brightness.dark) ? Colors.black38 : Colors.white38,
        title: Text("Account")
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            children: [
              Container(
                color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black38 : Colors.white38,
                height: MediaQuery.of(context).size.height/12,
                child: MaterialButton(
                  
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
              Divider(height: 2,color: Colors.grey.shade400,),
              Container(
                color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black38 : Colors.white38,
                height: MediaQuery.of(context).size.height/12,
                child: MaterialButton(
                  onPressed: () { 
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Homepage()), (route) => false);
                   },
                  child: Row(
                    children: [
                      Expanded(flex:3,child:Text("Home",style: TextStyle(fontSize: 20,),)),
                      Expanded(child: Icon(Icons.home),flex: 1),
                    ],
                  ),
                ),
              ),
              Divider(height: 2,color: Colors.grey.shade400,),
              Container(
                color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black38 : Colors.white38,
                height: MediaQuery.of(context).size.height/12,
                child: MaterialButton(
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
              Divider(height: 2,color: Colors.grey.shade400,),
              Container(
                color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black38 : Colors.white38,
                height: MediaQuery.of(context).size.height/12,
                child: MaterialButton(
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
              Divider(height: 2,color: Colors.grey.shade400,),
            ],
      ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(height: 30,),
           
                    SizedBox(height: 20,),
                    Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 10.5,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              color: Colors.transparent,
                              child: Center(
                              child: Text("Username    :",style:TextStyle(fontSize: 20)),
                            ),
                          )),
                          Expanded(
                            flex: 3,
                            child: Container(
                              color: Colors.transparent,
                              child: TextFormField(
                                enabled: _vi,
                                style: TextStyle(fontSize: 20),
                                controller: _usname,
                                decoration: InputDecoration(
			                            border: (_vi==false)?InputBorder.none:UnderlineInputBorder(borderRadius: BorderRadius.circular(15)),
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
              color: Colors.transparent, 
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
      ],
    );
  }

  Widget _landscapeMode(){
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Scaffold(
      body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: (_search==false)?
                      Container(
                          color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black38 : Colors.white38,                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(flex: 1,child: Container()),
                            Expanded(child: Text("Home",style: TextStyle(fontSize: 30),),flex: 6,),
                            Expanded(flex: 1,child: Center(child: IconButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Trash()));
                              }, 
                            icon: Icon(Icons.delete,semanticLabel: "Go to Trash",)))),
                            Expanded(
                              flex: 1,
                              child: Center(child: IconButton(onPressed: (){
                              if(_search == false){
                              setState(() {
                                _search=true;
                              });
                              }
                              else{
                                setState(() {
                                  _search=false;
                                });
                              }
                            },
                          icon: (_search==false)?Icon(Icons.search):Icon(Icons.close),),
                          ),
                          ),
                          Expanded(flex: 1,child: IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Account()));                         
                          }, 
                          icon: Icon(Icons.person),
                          ),
                          ),
                          ],
                        ),
                      ):
                      Container(
                        color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black38 : Colors.white38,
                        child: new TextField(
                                  style: TextStyle(fontSize: 20),
                                  controller: _sea,                                
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(onPressed: (){
                                      if(_search == false){
                                      setState(() {
                                        _search=true;
                                      });
                                      }
                                      else{
                                        setState(() {
                                          _search=false;
                                        });
                                      }
                                    }, icon: (_search==false)?Icon(Icons.search):Icon(Icons.close),),
                                    hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                    hintText: 'Search...',
                                  ),
                                  onChanged: (String value){
                                    setState(() {
                                      sea=value;
                                    });
                                  },
                                ),
                      ),
                    ),
                    Divider(height: 2,color: Colors.grey.shade400,),
                    Expanded(
                      flex: 9,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: (_search==true)
                            ? FirebaseFirestore.instance.collection("users")
                            .doc(firebaseUser!.uid)
                            .collection("notes")
                            .where("Key", arrayContains: sea)
                            .snapshots()
                      
                            : FirebaseFirestore.instance.collection("users")
                            .doc(firebaseUser!.uid)
                            .collection("notes").snapshots(),
                      
                        builder: (context, snapshot) {
                          return (snapshot.connectionState == ConnectionState.waiting)
                              ? Center(child: CircularProgressIndicator())
                              : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data = snapshot.data!.docs[index];
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(height: MediaQuery.of(context).size.height/12,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black12 : Colors.white12,
                                      ),
                                      child: MaterialButton(onPressed: () {
                                        setState(() {
                                          title=data['Title'];
                                          content=data['content'];
                                          _hint=data["ID"];
                                          _date=data["Date & Time"];
                                        });
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>View(title,content,_hint,_date,true)));
                                      }, child: Text(data["Title"],
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      color: Colors.transparent,
                                      ),
                                    ),
                                    Divider(height: 3,color: Colors.grey.shade400,),
                                    
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                )
                ),
                Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              color: Colors.transparent,
                            child: Center(
                              child: Text("Username    :",style:TextStyle(fontSize: 20)),
                            ),
                          )),
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: MediaQuery.of(context).size.width/3,
                              color: Colors.transparent,
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
                       color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height / 10.5,
                    child: Center(child: Text("Email  : "+(FirebaseAuth.instance.currentUser!.email).toString(),style: TextStyle(fontSize: 20),)),
                   ),
                   SizedBox(height: 20,),
                   Container(
                     width: MediaQuery.of(context).size.width/3,
                     height: MediaQuery.of(context).size.height/12,
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
                   SizedBox(height: 10,),
                   Container(
                     width: MediaQuery.of(context).size.width/3,
                     height: MediaQuery.of(context).size.height/12,
                     decoration: BoxDecoration(
                       gradient: LinearGradient(
                      colors: [Colors.pink.shade400, Colors.pink.shade300]), 
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: MaterialButton(
                      child: Center(child: Text("Logout",style: TextStyle(fontSize: 20)),),
                      onPressed: () async {
                          await _auth.signOut();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                      },
                    ),
                   ),
                ],),
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