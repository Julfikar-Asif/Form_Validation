// ignore: file_names
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  // Controllers for form fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Variables to store form input data
  String _username = '';
  String _email = '';
  String _password = '';

  // Form submission function
  _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, retrieve data using the controllers
      setState(() {
        _username = _usernameController.text;
        _email = _emailController.text;
        _password = _passwordController.text;
      });
      //show a snackbar with successs
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form Submiited Succesfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Optionally, you could clear the fields after submission:
      // _usernameController.clear();
      // _emailController.clear();
      // _passwordController.clear();
    } else {
      //show a snackbar with error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form is invalid! please Fix Errors!!!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          dismissDirection: DismissDirection.vertical ,
          
        ),
      );
      print("Form is invalid.");
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources when the widget is disposed
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact Form",
          style: TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
        elevation: 10.0,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notification_add))
        ],
        shadowColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Username field with validation
              TextFormField(
                controller:
                    _usernameController, // Controller for username field
                autovalidateMode: AutovalidateMode.onUnfocus,
                decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(height: 20.0),

              // Email field with validation
              TextFormField(
                controller: _emailController, // Controller for email field
                autovalidateMode: AutovalidateMode.onUnfocus,
                decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Basic email format validation using regex
                  String emailPattern =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  RegExp regExp = RegExp(emailPattern);
                  if (!regExp.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null; // Return null if the email is valid
                },
              ),
              const SizedBox(height: 20.0),

              // Password field with validation
              TextFormField(
                controller:
                    _passwordController, // Controller for password field
                autovalidateMode: AutovalidateMode.onUnfocus,
                obscureText: true, // To hide the password
                decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null; // Return null if the password is valid
                },
              ),
              const SizedBox(height: 20.0),

              // Submit button
              SizedBox(
                height: 50.0,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              // Display the entered data below the form
              const SizedBox(height: 20.0),

              // Display user input after form submission
              if (_username.isNotEmpty ||
                  _email.isNotEmpty ||
                  _password.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your username is: $_username",
                        style: const TextStyle(color: Colors.amber)),
                    Text("Your email is: $_email",
                        style: const TextStyle(color: Colors.green)),
                    Text("Your password is: $_password",
                        style: const TextStyle(color: Colors.purple)),
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.email), label: 'Email'),
        BottomNavigationBarItem(icon: Icon(Icons.password), label: 'Password'),
        BottomNavigationBarItem(
            icon: Icon(Icons.verified_user), label: 'Username')
      ]),
    );
  }
}
