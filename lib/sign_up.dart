import 'package:flutter/material.dart';
import 'package:login_test/app_card.dart';
import 'package:login_test/login.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:login_test/account_db.dart';



void main() => runApp(SignUp());

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

DatabaseHelper helper = DatabaseHelper();

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
      body: Container
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }*/



//class SignUp extends StatelessWidget {
  //const SignUp ({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromRGBO(46, 49, 146, 1.0), Color.fromRGBO(27, 255, 255, 1.0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Center(
              //Form(
              AppCard(
                child: Text(
                  "Sign Up",
                  style:TextStyle(fontSize: 32.0, color: Color.fromRGBO(27, 255, 255, 0.7)),
                  textAlign: TextAlign.center,
                ),
              ),
              AppCard(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: <Widget>[

                      TextFormField(
                        controller: usernameController,
                        //onChanged: (user_name) {},
                        decoration: InputDecoration(
                          labelText: "Username: ",
                          labelStyle: new TextStyle(
                            color: Color.fromRGBO(27, 255, 255, 0.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(46, 49, 146, 1.0)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(27, 255, 255, 0.4)),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email: ",
                          labelStyle: new TextStyle(
                            color: Color.fromRGBO(27, 255, 255, 0.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(46, 49, 146, 1.0)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(27, 255, 255, 0.4)),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Password: ",
                          labelStyle: new TextStyle(
                            color: Color.fromRGBO(27, 255, 255, 0.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(46, 49, 146, 1.0)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(27, 255, 255, 0.4)),
                          ),
                        ),
                      ),

                      Container(
                          width: double.infinity,
                          child: FlatButton(
                            //color: Color.fromRGBO(0, 0, 0, 0.2),
                            textColor: Color.fromRGBO(46, 49, 146, 1.0),
                            onPressed: (){

                              //Get feilds
                              //Add to database
                            /*
                              var user_account = Account(
                                username: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              */

                              Note temp =  new Note(usernameController.text, emailController.text, passwordController.text);

                            _add(temp);

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: Text("Sign Up"),
                          )),

                    ],
                  ),
                ),
              ),

              //)

            ],
          ),
        )
    );
  }

  void _add(Note note) async {
    int result = await helper.insertNote(note);
  }

}
