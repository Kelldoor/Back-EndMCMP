import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> login(String userName, String passwordHash) async {
  try {
    // Sending login request to server
    var response = await http.post(
      Uri.parse('http://10.0.2.2/api/login.php'),
      body: {'userName': userName, 'passwordHash': passwordHash},
    );

    if (response.statusCode == 200) {
      // Parse data response
      var data = json.decode(response.body);
      if (data['success']) {
        return "Success"; // Login was successful
      } else {
        return "Login failed. Please check your credentials.";
      }
    } else {
      return "An error occurred. Please try again later.";
    }
  } catch (e) {
    return "An error occurred. Please try again later.";
  }
}

Future<String> signup(String firstName, String lastName, String studentID,
    String studentEmail, String userName, String passwordHash) async {
  try {
    var response = await http.post(
      // Sending signup request to server
      Uri.parse('http://10.0.2.2/api/signup.php'),
      body: {
        'firstName': firstName,
        'lastName': lastName,
        'studentID': studentID,
        'studentEmail': studentEmail,
        'userName': userName,
        'passwordHash': passwordHash,
      },
    );

    if (response.statusCode == 200) {
      // Parse data response
      var data = json.decode(response.body);
      if (data['status'] == true &&
          data['message'] == "User successfully created.") {
        return "Success"; // Signup was successful
        // Error occurred.
      } else {
        return "Failed to register user. Please try again later.";
      }
    } else {
      return "An error occurred. Please try again later.";
    }
  } catch (e) {
    return "An error occurred. Please try again later.";
  }
}
