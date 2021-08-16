import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Account.dart';
import 'Homepage.dart';
import 'Signup.dart';
import 'Trash.dart';

// ignore: must_be_immutable
class View extends StatefulWidget {
  var title;
  var content;
  var id;
  var date;
  bool where;
  View(this.title,this.content,this.id,this.date,this.where);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  //view
  final firestoreInstance = FirebaseFirestore.instance;
  bool _edit = false;
  TextEditingController _title=new TextEditingController();
  TextEditingController _content=new TextEditingController();
  var id;
  List keya=[];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //home
  TextEditingController _sea=new TextEditingController(text: "");
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  var title="";
  var content="";
  var sea ="";
  var _hint;
  var _date="";
  bool _search=false;

  @override
  // ignore: must_call_super
  void initState() {
    _title.text=widget.title;
    _content.text=widget.content;
    id=widget.id;
  }

    Widget _portraitMode(){
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Scaffold(
      appBar: (widget.where==true)?

      AppBar(
          backgroundColor: Colors.black54,
          title: Text("View"),
          actions: [
            IconButton(onPressed: (){
              var firebaseUser =  FirebaseAuth.instance.currentUser;
              FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid).collection("Trash").add(
                  {
                    "Title" : _title.text,
                    "content":_content.text,
                    "Date & Time":DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
                    "ID":"",
                  }).then((value) => FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).collection("Trash").doc(value.id).update(
                  {
                    "ID":value.id,
                  }).then((value) => FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).collection("notes").doc(id).delete()),
              );
              
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
            }, icon: Icon(Icons.delete)),
            IconButton(onPressed: () async {
              if(_edit == true){
                setState(() {
                  _edit =false;
                });
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
                //
                var firebaseUser =  FirebaseAuth.instance.currentUser;
                FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid).collection("notes").doc(id).update(
                    {
                      "Title" : _title.text,
                      "content":_content.text,
                      "Date & Time":DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
                      "Key":widget.key,
                    }
                );
                //
              }
              else{
                setState(() {
                  _edit =true;
                });
                print("True");
              }
            },
              icon: (_edit == false)?Icon(Icons.edit):Icon(Icons.update),
            ),
          ]
      ):
      // Trash view
      AppBar(
          backgroundColor: Colors.black54,
          title: Text("View"),
          actions: [
            IconButton(onPressed: (){
              var firebaseUser =  FirebaseAuth.instance.currentUser;
              FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid).collection("Trash").doc(id).delete();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Trash()));
            }, icon: Icon(Icons.delete)),
            IconButton(onPressed: () async {
                //
                var firebaseUser =  FirebaseAuth.instance.currentUser;
                FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid).collection("notes").add(
                    {
                      "Title" : _title.text,
                      "content":_content.text,
                      "Date & Time":DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
                      "ID":"",
                    }
                ).then((value) =>
                FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).collection("notes").doc(value.id).update({"ID":value.id})
                ).then((value) => FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).collection("Trash").doc(id).delete());
                //
            },
              icon: Icon(Icons.update),
            ),
          ]
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
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black12,
                      ),
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
              Divider(height: 2),
              Container(
                height: MediaQuery.of(context).size.height/12,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black12,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Trash()));
                  },
                  child: Row(
                    children: [
                      Expanded(child: Text("Trash",style: TextStyle(fontSize: 20),),flex: 3,),
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
      

      body: (widget.where==true)

          ?Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Last edited time : "+'''
                  '''+widget.date,textAlign:TextAlign.center,style: TextStyle(fontSize: 20,),),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: MediaQuery.of(context).size.height / 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextFormField(
                  style: TextStyle(fontSize: 20),
                  controller: _title,
                  enabled: _edit,
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
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextFormField(
                  style: TextStyle(fontSize: 20),
                  enabled: _edit,
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
            ],
          ),
        ),
      )

          :Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Deleted on  : "+'''
                  '''+widget.date,textAlign:TextAlign.center,style: TextStyle(fontSize: 20),),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: MediaQuery.of(context).size.height / 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextFormField(
                  style: TextStyle(fontSize: 20),
                  controller: _title,
                  enabled: _edit,
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
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextFormField(
                  style: TextStyle(fontSize: 20),
                  enabled: _edit,
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
        Scaffold(
          body: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: (widget.where)?Column(
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
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
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
                              return Column(
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>View(title,content,_hint,_date,true,)));
                                    }, child: Text(data["Title"],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    color: Colors.transparent,
                                    ),
                                  ),
                                  Divider(height: 3,color: Colors.grey.shade400,),
                                  
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ):
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: (_search==false)?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 1,child: Container()),
                          Expanded(child: Text("Trash",style: TextStyle(fontSize: 30),),flex: 6,),
                          Expanded(flex: 1,child: Center(child: IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
                          }, 
                          icon: Icon(Icons.home,semanticLabel: "Go to Home",)))),
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
                        ],
                      ):
                      new TextField(
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
                    Divider(height: 2,color: Colors.grey.shade400,),
                    Expanded(
                      flex: 9,
                      child: Container(
                      child:StreamBuilder<QuerySnapshot>(
                        stream: (_search==true)
                            ? FirebaseFirestore.instance.collection("users")
                            .doc(firebaseUser!.uid)
                            .collection("Trash")
                            .where("Key", arrayContains: sea)
                            .snapshots()
                      
                            : FirebaseFirestore.instance.collection("users")
                            .doc(firebaseUser!.uid)
                            .collection("Trash").snapshots(),
                      
                        builder: (context, snapshot) {
                          return (snapshot.connectionState == ConnectionState.waiting)
                              ? Center(child: CircularProgressIndicator())
                              : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data = snapshot.data!.docs[index];
                              return Column(
                                children: [
                                  Container(height: MediaQuery.of(context).size.height/12,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black45 : Colors.white38,
                                    ),
                                    child: MaterialButton(onPressed: () {
                                      setState(() {
                                        _title.text=data['Title'];
                                        _content.text=data['content'];
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
                                  Divider(height: 2,color: Colors.grey.shade400,),
                                ],
                              );
                            },
                          );
                        },
                      ),
                                        ),
                    ),
                  ],
                )
                ),
                Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: (widget.where==true)?Container(
                          color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black38 : Colors.white38,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: Container(),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(onPressed: (){
                                  var firebaseUser =  FirebaseAuth.instance.currentUser;
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
                                  FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid).collection("Trash").add(
                                      {
                                        "Title" : _title.text,
                                        "content":_content.text,
                                        "Date & Time":DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
                                        "ID":"",
                                        "key":key,
                                      }).then((value) => FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).collection("Trash").doc(value.id).update(
                                      {
                                        "ID":value.id,
                                      }).then((value) => FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).collection("notes").doc(id).delete()),
                                  );
                                  
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
                                  }, icon: Icon(Icons.delete)),
                                ),
                              Expanded(
                                flex: 1,
                                child: IconButton(onPressed: () async {
                                  if(_edit == true){
                                  setState(() {
                                    _edit =false;
                                  });
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
                                  //
                                  var firebaseUser =  FirebaseAuth.instance.currentUser;
                                  FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid).collection("notes").doc(id).update(
                                      {
                                        "Title" : _title.text,
                                        "content":_content.text,
                                        "Date & Time":DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
                                        "Key":key,
                                      }
                                  );
                                  //
                                }
                                else{
                                  setState(() {
                                    _edit =true;
                                  });
                                  print("True");
                                }
                                },
                                  icon: (_edit == false)?Icon(Icons.edit):Icon(Icons.update),
                                ),
                              ),
                            ],
                          ),
                        )
                        :Container(
                          color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black38 : Colors.white38,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: Container(),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(onPressed: (){
                                var firebaseUser =  FirebaseAuth.instance.currentUser;
                                FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid).collection("Trash").doc(id).delete();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Trash()));
                              }, icon: Icon(Icons.delete)),
                              ),
                            Expanded(
                              flex: 1,
                              child: IconButton(onPressed: () async {
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
                                        "Date & Time":DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
                                        "ID":"",
                                        "Key":key,
                                      }
                                  ).then((value) =>
                                  FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).collection("notes").doc(value.id).update({"ID":value.id})
                                  ).then((value) => FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).collection("Trash").doc(id).delete());
                                  //
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Trash()));
                              },
                                icon: Icon(Icons.update),
                              ),
                            ),
                            ],
                          ),
                        ),

                      ),
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(100, 200, 100, 200),
                          child: (widget.where==true)
                              ?Container(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.4,
                                    height: MediaQuery.of(context).size.height / 12,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text("Last edited time : "+'''
                                      '''+widget.date,textAlign:TextAlign.center,style: TextStyle(fontSize: 20,),),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    style: TextStyle(fontSize: 20),
                                    controller: _title,
                                    enabled: _edit,
                                    
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                      hintText: 'Title',
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  TextFormField(
                                    style: TextStyle(fontSize: 20),
                                    enabled: _edit,
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
                                  SizedBox(height: 10,),
                                ],
                              ),
                            ),
                          )
               :Container(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.4,
                                    height: MediaQuery.of(context).size.height / 12,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text("Last edited time : "+'''
                                      '''+widget.date,textAlign:TextAlign.center,style: TextStyle(fontSize: 20,),),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    style: TextStyle(fontSize: 20),
                                    controller: _title,
                                    enabled: _edit,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                      hintText: 'Title',
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  TextFormField(
                                    style: TextStyle(fontSize: 20),
                                    enabled: _edit,
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
                                  SizedBox(height: 10,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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