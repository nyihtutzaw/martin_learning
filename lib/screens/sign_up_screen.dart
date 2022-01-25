import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimize/constants/active_constants.dart';
import 'package:optimize/providers/auth_provider.dart';
import 'package:optimize/screens/sign_in_screen.dart';
import 'package:optimize/widgets/message_dialog.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible = false;
  bool _actionLoading = false;
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
    'password_confirmation': ''
  };
  Map<String, String> _initValues = {
    'name': '',
    'email': '',
    'password': '',
    'password_confirmation': ''
  };
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isValidEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(email);
  }

  @override
  void initState() {
    _passwordVisible = false;
  }

  Future<void> _submit() async {
    if (!_actionLoading) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        try {
          setState(() {
            _actionLoading = true;
          });
          await Provider.of<Auth>(context, listen: false).register(_authData);
          setState(() {
            _actionLoading = false;
          });
          Fluttertoast.showToast(
            msg: "Success. You can login now",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInScreen(),
            ),
          );
        } catch (error) {
          print(error);
          setState(() {
            _actionLoading = false;
          });
          MessageDialog.show(
              context, error.toString(), "Sign Up Fails", "Try Again");
        }
      } else {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome !",
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
              Text(
                "Let's Create",
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
              Text(
                "Your Account",
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                initialValue: _initValues['name'],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Name is  required';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _authData['name'] = value!,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Type Your Name',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                initialValue: _initValues['email'],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email is  required';
                                  } else if (!isValidEmail(value)) {
                                    return 'Your email is invalid';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _authData['email'] = value!,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Type Your Email',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Password is  required';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) =>
                                        _authData['password'] = value!,
                                    obscureText:
                                        !_passwordVisible, //This will obscure text dynamically
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Type Your Password',
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),

                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.orange,
                                              width: 32.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),

                                      // Here is key idea
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ])),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Confirm Password is  required';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) =>
                                        _authData['password_confirmation'] =
                                            value!,
                                    obscureText:
                                        !_passwordVisible, //This will obscure text dynamically
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Type Your Confirm Password',
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),

                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.orange,
                                              width: 32.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),

                                      // Here is key idea
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ])),
                        SizedBox(
                          height: 30,
                        ),
                        FlatButton(
                          child: Text(
                            _actionLoading ? 'Loading...' : 'Create Account',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          color: activeColors.primary,
                          onPressed: _submit,
                          padding: EdgeInsets.symmetric(
                              horizontal: 60, vertical: 15),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()),
                            );
                          },
                          child: Text(
                            "Already a member? Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
