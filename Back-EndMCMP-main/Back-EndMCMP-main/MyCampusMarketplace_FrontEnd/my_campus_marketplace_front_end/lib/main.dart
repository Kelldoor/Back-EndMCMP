import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/user.dart';
import 'package:mycampusmarketplace/Repositories/userClient.dart';
import 'package:mycampusmarketplace/Views/aboutus.dart';
import '../views/mainMenu.dart';

final UserClient client = new UserClient();

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({Key? key}) : super(key: key);

  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _studentIDController = TextEditingController();
  final TextEditingController _studentEmailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordHashController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Sign Up'),
      ),
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (!_isLogin)
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            if (!_isLogin)
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            if (!_isLogin)
              TextFormField(
                controller: _studentIDController,
                decoration: InputDecoration(
                  labelText: 'Student ID',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            if (!_isLogin)
              TextFormField(
                controller: _studentEmailController,
                decoration: InputDecoration(
                  labelText: 'Student Email',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            TextFormField(
              controller: _userNameController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            TextFormField(
              controller: _passwordHashController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              obscureText: true,
              style: TextStyle(color: Colors.white),
            ),
            if (!_isLogin)
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                obscureText: true,
                style: TextStyle(color: Colors.white),
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLogin ? _login : _signup,
              child: Text(_isLogin ? 'Login' : 'Sign Up'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(
                  _isLogin ? 'Create an account' : 'Have an account? Sign in'),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _navigateToAboutUs(context);
                  },
                  child: Text(
                    'About Us',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text(
                  'Version 0.0.1',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Login method
  void _login() async {
    String userName = _userNameController.text.trim();
    String passwordHash = _passwordHashController.text.trim();

    // Calling the login function
    String loginResponse = await client.login(userName, passwordHash);

    userName = await _getUsername();

    if (loginResponse == "Success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(userName: userName)),
      );
    } else {
      _showErrorDialog(loginResponse);
    }
  }

  // Signup method
  void _signup() async {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String studentID = _studentIDController.text.trim();
    String studentEmail = _studentEmailController.text.trim();
    String userName = _userNameController.text.trim();
    String passwordHash = _passwordHashController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    // Validations for signup
    if (!_isLogin) {
      if (firstName.isEmpty) {
        _showErrorDialog("Please enter your first name.");
        return;
      }
      if (lastName.isEmpty) {
        _showErrorDialog("Please enter your last name.");
        return;
      }
      if (studentID.isEmpty) {
        _showErrorDialog("Please enter your student ID.");
        return;
      }
      if (studentEmail.isEmpty) {
        _showErrorDialog("Please enter your student email.");
        return;
      }
      if (!studentEmail.endsWith('@my.sctcc.edu') &&
          !studentEmail.endsWith('@sctcc.edu')) {
        _showErrorDialog(
            "Please enter a valid SCTCC email address ending in @my.sctcc.edu or @sctcc.edu");
        return;
      }
      if (passwordHash.length < 8) {
        _showErrorDialog("Password must be at least 8 characters long.");
        return;
      }
      if (passwordHash != confirmPassword) {
        _showErrorDialog("Passwords do not match.");
        return;
      }
    }

    // Calling the signup function
    String signupResponse = await client.signup(
        firstName, lastName, studentID, studentEmail, userName, passwordHash);

    if (signupResponse == "Success") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginSignupPage(),
        ),
      );
    } else {
      _showErrorDialog(signupResponse);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> _getUsername() async {
    // calling the function to get a User object
    User? user = await client.getUser();

    if (user != null) {
      return user.userName;
    } else {
      return client.getErrorMessage();
    }
  }

  // About us page navigation
  void _navigateToAboutUs(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutUsPage()),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Campus Marketplace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginSignupPage(),
    );
  }
}
