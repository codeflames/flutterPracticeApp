import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  static const routeName = '/authScreen';

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {

  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _passwordController = TextEditingController();

  void dispose(){
    _textController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        height: deviceSize.height,
        width: double.infinity,
        color: Colors.black,
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.scatter_plot,
              color: Colors.purpleAccent,
              size: 50,
            ),
            Text(
              "CASSY'S",
              style: TextStyle(
                  color: Colors.purpleAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Card(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(14),
                    topLeft: Radius.circular(14)),
              ),
              elevation: 8.0,
              color: Colors.purpleAccent,
              child: Container(
                width: deviceSize.width * 0.8,
//                    height: 250,
                child: Form(
                  key: _formKey,
                    child: SingleChildScrollView(
                  padding: EdgeInsets.all(9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextFormField(
                        validator: (value){
                          if(value.isEmpty){
                            return 'Please enter your email address';
                          }
                          return null;
                        },
                        controller: _textController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value){
                          if(value.isEmpty){
                            return 'Please enter your email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(9),
                                  topLeft: Radius.circular(9))),
                          color: Colors.black,
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 16, color: Colors.purpleAccent),
                          ),
                          onPressed: () {
                            if(_formKey.currentState.validate()){
                              //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                              //Navigator.of(context).pushNamed('/');
//                               showDialog(
//                                   context: context,
//                                 builder: (context){
//                                     return AlertDialog(
//                                       content: Text('Your email is ' + _textController.text + ' and your password is ' + _passwordController.text),
//                                     );
//                                 }
//                               );
                               Navigator.of(context).pop();
                            }
                          })
                    ],
                  ),
                )),
              ),
            )
          ],
        ),
      )
    ]));
  }
}
