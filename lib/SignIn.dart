import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pro_1_notes_taking/Signup.dart';

import 'Homepage.dart';

class SignIn extends StatefulWidget {
  const SignIn({ Key? key }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final _formKey = GlobalKey<FormState>();
  final _formKeyr = GlobalKey<FormState>();
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();

  Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

  Widget _portraitMode(){
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height/35,),
                Text("Welcome,",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: (Theme.of(context).brightness == Brightness.dark) ? Colors.white70 : Colors.black)),
                Text("Signin to continue!,",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20,color: (Theme.of(context).brightness == Brightness.dark) ? Colors.white : Colors.black45)),
          
                SizedBox(height: MediaQuery.of(context).size.height/10,),
          
                Form(
                        key: _formKey,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width/1.3,
                            child: Column(
                              children: [
    
                                SizedBox(height: MediaQuery.of(context).size.height/30,),
          
                                TextFormField(
                                  controller: _email,
                                  decoration: InputDecoration(
                                    hintText: "Mail ID",
                                    prefixIcon: Icon(Icons.mail),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 1.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 1.5,
                                      ),
                                    ),
                                    enabledBorder:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Colors.blueGrey.shade400,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty)
                                    {
                                      return 'Please Enter a valid Email';
                                    }
                                    if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                      return 'Please Enter a valid Email';
                                    }
                                    return null;
                                  },
                                ),
          
                                SizedBox(height: MediaQuery.of(context).size.height/30,),
          
                                TextFormField(
                                  controller: _pass,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    prefixIcon: Icon(Icons.lock),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 1.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 1.5,
                                      ),
                                    ),
                                    enabledBorder:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Colors.blueGrey.shade400,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty)
                                    {
                                      return 'Please a Enter Password';
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height/30,),

                                Row(
                                  children: [
                                    Expanded(flex: 1,child: Container()),
                                    Expanded(child: GestureDetector(
                                  onTap: () {                                  
                                    showDialog(context: context, builder: (BuildContext context) => Dialog(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.circular(15.0),
                                        ),
                                      height: MediaQuery.of(context).size.height/4,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width / 1.5,
                                              height: MediaQuery.of(context).size.height / 10.5,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              child: Form(
                                                key: _formKeyr,
                                                child: TextFormField(
                                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                                  controller: _email,
                                                  decoration: InputDecoration(
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.white, width: 2),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                                                    hintText: 'Enter Your Email',
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty ||
                                                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                                .hasMatch(value)) {
                                                      return 'Enter a valid email!';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width / 1.5,
                                              height: MediaQuery.of(context).size.height / 14,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15.0),
                                                color: Colors.black45,
                                              ),
                                              child: MaterialButton(
                                                  onPressed: ()  async {
                                                    if (_formKeyr.currentState!.validate()) {
                                                      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text);
                                                      Navigator.pop(context);
                                                  }
                                                  },
                                                  child: Text("Send resend link",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),);
                                    },
                                    child: Text("Forgot Password?",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),),
                                ),
                                    )
                                  ],
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height/30,),
          
                                Container(                              
                                  height: MediaQuery.of(context).size.height/13,
                                  width: MediaQuery.of(context).size.width/1.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    gradient: LinearGradient(
                                      colors: [Colors.pink.shade400, Colors.pink.shade300])
                                  ),
                                  child: MaterialButton(                                
                                    color: Colors.transparent,
                                    onPressed: () async {
                                      if(_formKey.currentState!.validate())
                                      {
                                        var cid;
                                        bool shouldNavigate =
                                        await signIn(_email.text, _pass.text);
                                        if (shouldNavigate) {
                                        FirebaseFirestore.instance.collection("users")
                                              .doc(FirebaseAuth.instance.currentUser!.uid).collection("User Data").where('Email',isEqualTo: _email.text).get()
                                              .then((QuerySnapshot querySnapshot) {
                                                  querySnapshot.docs.forEach((doc) {
                                                      cid=doc["ID"];
                                                  });
                                              })
                                              .then((value) => FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("User Data").doc(cid.toString()).update({"Password":_pass.text})
                                              .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage())))
                                             );
                                        }
                                        return;
                                      }else{
                                        print("UnSuccessfull");
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    textColor:Colors.white,
                                    child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("New user ? .",style: TextStyle(fontSize: 20),),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                child: Text("Signup",style: TextStyle(fontSize: 20,color: Colors.pink),),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                                },
                              ),
                            ),
                          ],
                        ),
              ],
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
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Column(
                        children: [
                Text("Welcome,",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: (Theme.of(context).brightness == Brightness.dark) ? Colors.white70 : Colors.black)),
                Text("Signin to continue!,",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 40,color: (Theme.of(context).brightness == Brightness.dark) ? Colors.white : Colors.black45)),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Form(
                        key: _formKey,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width/3,
                            child: Column(
                              children: [                                
                                SizedBox(height: MediaQuery.of(context).size.height/30,),
                  
                                TextFormField(
                                  controller: _email,
                                  decoration: InputDecoration(
                                    hintText: "Mail ID",
                                    prefixIcon: Icon(Icons.mail),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 1.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 1.5,
                                      ),
                                    ),
                                    enabledBorder:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Colors.blueGrey.shade400,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty)
                                    {
                                      return 'Please Enter a valid Email';
                                    }
                                    if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                      return 'Please Enter a valid Email';
                                    }
                                    return null;
                                  },
                                ),
                  
                                SizedBox(height: MediaQuery.of(context).size.height/30,),
                  
                                TextFormField(
                                  controller: _pass,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    prefixIcon: Icon(Icons.lock),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 1.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 1.5,
                                      ),
                                    ),
                                    enabledBorder:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Colors.blueGrey.shade400,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty)
                                    {
                                      return 'Please a Enter Password';
                                    }
                                    return null;
                                  },
                                ),
                  
                                SizedBox(height: MediaQuery.of(context).size.height/30,),

                                
                                Row(
                                  children: [
                                    Expanded(flex: 1,child: Container(
                                      
                                    )),
                                    Expanded(
                                      flex: 1,
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                  onTap: () {                                  
                                    showDialog(context: context, builder: (BuildContext context) => Dialog(
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black38,
                                          borderRadius: BorderRadius.circular(15.0),
                                          ),
                                        height: MediaQuery.of(context).size.height/2.5,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Form(
                                                key: _formKeyr,
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width/1.5,
                                                  child: TextFormField(
                                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                                    controller: _email,
                                                    decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.white, width: 2),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                                                      hintText: 'Enter Your Email',
                                                    ),
                                                    validator: (value) {
                                                      if (value!.isEmpty ||
                                                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                                  .hasMatch(value)) {
                                                        return 'Enter a valid email!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                              
                                              SizedBox(
                                                height: 10,
                                              ),

                                              Container(
                                                width: MediaQuery.of(context).size.width / 1.5,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  color: Colors.pink,
                                                ),
                                                child: MaterialButton(
                                                    onPressed: ()  async {
                                                      if (_formKeyr.currentState!.validate()) {
                                                        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text);
                                                        Navigator.pop(context);
                                                    }
                                                    },
                                                    child: Text("Send resend link",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),)),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),);
                                    },
                                    child: Text("Forgot Password?",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold,),),
                                ),
                                      ),
                                    )
                                  ],
                                ),
                                
                                SizedBox(height: MediaQuery.of(context).size.height/30,),
                  
                                Container(                              
                                  height: 60,
                                  width: MediaQuery.of(context).size.width/3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    gradient: LinearGradient(
                                      colors: [Colors.pink.shade400, Colors.pink.shade300])
                                  ),
                                  child: MaterialButton(                                
                                    color: Colors.transparent,
                                    onPressed: () async {
                                      if(_formKey.currentState!.validate())
                                      {
                                        var cid;
                                        bool shouldNavigate =
                                        await signIn(_email.text, _pass.text);
                                        if (shouldNavigate) {
                                        FirebaseFirestore.instance.collection("users")
                                              .doc(FirebaseAuth.instance.currentUser!.uid).collection("User Data").where('Email',isEqualTo: _email.text).get()
                                              .then((QuerySnapshot querySnapshot) {
                                                  querySnapshot.docs.forEach((doc) {
                                                      cid=doc["ID"];
                                                  });
                                              })
                                              .then((value) => FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("User Data").doc(cid.toString()).update({"Password":_pass.text})
                                              .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage())))
                                              );
                                        }
                                        return;
                                      }else{
                                        print("UnSuccessfull");
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    textColor:Colors.white,
                                    child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  ),
                                ),

                                SizedBox(height: 10,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("New here ? .",style: TextStyle(fontSize: 20),),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        child: Text("Signup",style: TextStyle(fontSize: 20,color: Colors.pink),),
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation){
          if(orientation == Orientation.portrait){
            return _portraitMode();
          }else{
            return _landscapeMode();
          }
        },
      ),
    );
  }
}