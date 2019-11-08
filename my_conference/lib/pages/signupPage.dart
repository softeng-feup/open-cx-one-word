import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_conference/services/authService.dart';

class SignupPage extends StatefulWidget {

  static final String id = 'signupPage';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _password;

  _submit(){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      //signupUser
      AuthService.signUpUser(context, _name, _email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'MyConference',
                style: TextStyle(
                  fontSize: 25
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 5
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (input) => input.trim().isEmpty ? 'Please enter a valid name' : null,
                        onSaved: (input) => _name = input,
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 5
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (input) => !EmailValidator.validate(input,true) ? 'Please enter a valid email' : null,
                        onSaved: (input) => _email = input,
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 5
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (input) => input.length < 6 ? 'Password must be at least 6 characters' : null,
                        onSaved: (input) => _password = input,
                        obscureText: true,
                      )
                    ),
                    Container(
                      width: 200,
                      margin: EdgeInsets.all(10),
                      child: FlatButton(
                        padding: EdgeInsets.all(10),
                        onPressed: _submit,
                        color: Colors.blue,
                        child: Text(
                          'Signup',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      //margin: EdgeInsets.all(5),
                      child: FlatButton(
                        padding: EdgeInsets.all(10),
                        onPressed: () => Navigator.pop(context),
                        color: Colors.blue,
                        child: Text(
                          'Back to Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}