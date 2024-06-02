import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String email = '';
  String password = '';
  bool isLoading = false;

  // Function to handle sign in
  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        setState(() {
          isLoading = false;
        });
        // Navigate to home screen on successful login
        if (userCredential.user != null) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // This should not happen since userCredential.user should not be null
          print('User is null after signInWithEmailAndPassword');
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print('Firebase Error: $e');
        // Handle Firebase specific errors
        String errorMessage =
            'An error occurred, please check your credentials and try again.';
        if (e is FirebaseAuthException) {
          errorMessage = e.message ?? 'An undefined error happened.';
        }
        // Show dialog with error message
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Authentication Failed'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (val) => val!.length < 6
                          ? 'Enter a 6+ chars long password'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      child: Text('Login'),
                      onPressed: _signIn,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
