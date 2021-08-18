import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Account.dart';
import 'Homepage.dart';
import 'Signup.dart';
import 'Trash.dart';
import 'view.dart';

class Add extends StatefulWidget {
  const Add({ Key? key }) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _title=TextEditingController();
  TextEditingController _content=TextEditingController();
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
                color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black38 : Colors.white38,
                height: MediaQuery.of(context).size.height/12,
                child: MaterialButton(
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
                      borderSide: BorderSide(width: 2.5,color: Colors.grey.shade400),
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
                      borderSide: BorderSide(width: 2.5,color: Colors.grey.shade400),
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
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Homepage()), (route) => false);
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
        new Scaffold(
          body: new Row(
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
                          color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black38 : Colors.white38,
                          child: Row(
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
                      height: MediaQuery.of(context).size.height / 12,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        controller: _title,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey.shade400,width: 2.5),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.pink,
                                    width: 1.5,
                                  ),
                                ),
                          hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          hintText: 'Title',
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        controller: _content,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: null,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey.shade400,width: 2.5),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.pink,
                                    width: 1.5,
                                  ),
                                ),
                          hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          hintText: 'Content',
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Container(
                      height: MediaQuery.of(context).size.height / 14,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.pink.shade400, Colors.pink.shade300]),
                        borderRadius: BorderRadius.circular(25.0),
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
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Homepage()), (route) => false);
                          },
                          child: Text("Add",style: TextStyle(fontSize: 20),)),
                    ),
                  ],
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