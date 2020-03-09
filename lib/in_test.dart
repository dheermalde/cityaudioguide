import 'package:flutter/material.dart';
import 'package:login_test/account_db.dart';
import 'package:login_test/app_card.dart';
import 'package:login_test/sign_up.dart';
import 'package:login_test/fav_db.dart';

void main() => runApp(Intest());

class Intest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}
//DatabaseHelper helper = DatabaseHelper();
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
          /*child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              textColor: Color.fromRGBO(46, 49, 146, 1.0),
              onPressed: () {
              Fav temp =  new Fav('001', usernameController.text, '001');
              help_add(temp);
              },
              child: Text("add to favs"),
              ),
            
            FlatButton(
              textColor: Color.fromRGBO(46, 49, 146, 1.0),
              onPressed: () {
                
               },
              child: Text("get favs"),
            ),
            
          ]
        )*/
        ));
  }
  void help_add(Fav fav) async{
   // helper.addFavDb(fav);
  }

}