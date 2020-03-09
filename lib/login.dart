import 'package:flutter/material.dart';
import 'package:login_test/account_db.dart';
import 'package:login_test/app_card.dart';
import 'package:login_test/sign_up.dart';
import 'package:login_test/in_test.dart';

void main() => runApp(LoginPage());

class LoginPage extends StatelessWidget {
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
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

//class LoginPage extends StatelessWidget {
  //const LoginPage ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){
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
              AppCard(
                child: Text(
                  "Cardiff City Guide",
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
                        onPressed: () {

                          //get username field usernameController.text
                          _pull(usernameController.text, passwordController.text);

                          //String Y = result;

                          //Future<String> Y = result;

                      /*
                          if(get==1){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Intest()),
                            );
                          }else {
                            print("Nah Broken");
                          }*/

                          //if not there error
                          //if there compare database password to feild password
                          /*if(pass == passwordController.text){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          };*/
                          //if match login

                        },
                        child: Text("Login"),
                      )),

                  ],
                ),
              ),
            ),
            //)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Dont have an Account?",
                style:TextStyle(color: Color.fromRGBO(46, 49, 146, 0.7))),
                FlatButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  child: Text("Sign Up"),
                )
              ]
            )

          ],
        ),
      )
    );
  }



   _pull(String names, String passwords) async{
    final get= await helper.getNoteMapList(names, passwords);

    String Y = get;

    if(Y==passwordController.text){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Intest()),
      );
    } else {
    print("Nah Broken");}
  }
}