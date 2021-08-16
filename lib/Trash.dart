import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pro_1_notes_taking/view.dart';

import 'Account.dart';
import 'Homepage.dart';
import 'Signup.dart';

class Trash extends StatefulWidget {
  const Trash({ Key? key }) : super(key: key);

  @override
  _TrashState createState() => _TrashState();
}

class _TrashState extends State<Trash> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _sea=new TextEditingController(text: "");
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  var title;
  var content;
  var sea ="";
  var _hint;
  var _date;
  bool view=false;
  bool _search=false;
  Widget appBarTitle = new Text(
    "Trash",
    style: new TextStyle(fontSize: 20),
  );

  Widget _portraitMode(){
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        actions: [
          IconButton(onPressed: (){
            if(_search == false){
              setState(() {
                _search=true;
                appBarTitle= new TextField(
                  style: TextStyle( fontSize: 20),
                  controller: _sea,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 2.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    hintText: 'Search...',
                  ),
                  onChanged: (String value){
                    setState(() {
                      sea=value;
                    });
                  },
                );
              });
            }
            else{
              setState(() {
                _search=false;
                appBarTitle = new Text(
                  "Trash",
                  style: new TextStyle(fontSize: 20),
                );
              });
            }
          },
            icon: (_search==false)?Icon(Icons.search):Icon(Icons.close),),
        ],
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
                      Expanded(flex:3,child:Text("Home",style: TextStyle(fontSize: 20),)),
                      Expanded(child: Icon(Icons.home),flex: 1),
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
                    Divider(height: 2),
                    Container(height: MediaQuery.of(context).size.height/12,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ElevatedButton(onPressed: () {
                        setState(() {
                          title=data['Title'];
                          content=data['content'];
                          _hint=data["ID"];
                          _date=data["Date & Time"];
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>View(title,content,_hint,_date,false)));
                      }, child: Text(data["Title"],
                        style: TextStyle(fontSize: 20),
                      ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
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
                child: Container(
                  color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black38 : Colors.white38,
                  child: Column(
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
                                        color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black38 : Colors.white38,
                                      ),
                                      child: MaterialButton(onPressed: () {
                                        setState(() {
                                          title=data['Title'];
                                          content=data['content'];
                                          _hint=data["ID"];
                                          _date=data["Date & Time"];
                                        });
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>View(title,content,_hint,_date,false)));
                                      }, child: Text(data["Title"],
                                        style: TextStyle(fontSize: 20),
                                      ),
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
                  ),
                )
                ),
                Expanded(
                flex: 2,
                child: Container(),
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