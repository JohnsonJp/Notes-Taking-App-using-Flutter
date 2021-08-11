import 'package:flutter/material.dart';
import 'package:flutter_pro_1_notes_taking/SignIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usname = new TextEditingController();  
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();

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
                Text("Create Account,",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.black),),
                Text("Signup to get started!,",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20,color: Colors.black45),),
          
                SizedBox(height: MediaQuery.of(context).size.height/10,),
          
                Form(
                        key: _formKey,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width/1.3,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _usname,
                                  decoration: InputDecoration(
                                    hintText: "Full name",
                                    prefixIcon: Icon(Icons.person),
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
                                      return 'Please Enter your Full Name';
                                    }                                
                                    return null;
                                  },
                                ),
          
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
                                    onPressed: (){
                                      if(_formKey.currentState!.validate())
                                      {
                                        print("successful");
                                        return;
                                      }else{
                                        print("UnSuccessfull");
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    textColor:Colors.white,
                                    child: Text("Create Account",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
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
                            Text("Already have a Account. ",style: TextStyle(fontSize: 20),),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                child: Text("Signin",style: TextStyle(fontSize: 20,color: Colors.pink),),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
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
                          Text("Create Account,",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: (Theme.of(context).brightness == Brightness.dark) ? Colors.white70 : Colors.black),),
                          Text("Signup to get started!,",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 40,color: (Theme.of(context).brightness == Brightness.dark) ? Colors.white38 : Colors.black45)),
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
                                TextFormField(
                                  controller: _usname,
                                  decoration: InputDecoration(
                                    hintText: "Full name",
                                    prefixIcon: Icon(Icons.person),
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
                                      return 'Please Enter your Full Name';
                                    }                                
                                    return null;
                                  },
                                ),
                  
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
                                    onPressed: (){
                                      if(_formKey.currentState!.validate())
                                      {
                                        print("successful");
                                        return;
                                      }else{
                                        print("UnSuccessfull");
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    textColor:Colors.white,
                                    child: Text("Create Account",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  ),
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height/20,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Already have a Account. ",style: TextStyle(fontSize: 20),),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        child: Text("Signin",style: TextStyle(fontSize: 20,color: Colors.pink),),
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
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