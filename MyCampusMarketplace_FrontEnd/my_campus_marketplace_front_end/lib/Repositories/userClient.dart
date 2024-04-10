import 'package:http/http.dart' as http;
import 'dart:convert';

class UserClient {
  String sessionState = "";

  Future<String> login(String userName, String passwordHash) async {
    try {
      // Sending login request to server
      var response = await http.post(
        Uri.parse('http://10.0.2.2/api/login.php'),
        body: {'userName': userName, 'passwordHash': passwordHash},
      );

      // Parse data response
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['success']) {
          // Login was successful
          sessionState = data['data'];
          return "Success";
        } else {
          if (data['reason'][0] == "banned") {
            return "Your account has been permanently banned. Please contact the administrators if you believe this is a mistake.";
          } else if (data['reason'][0] == "login") {
            return "Your username or password was incorrect. Try again or create a new account.";
          } else if (data['reason'][0] == "server_error") {
            return "There was an issue with the server. Please try again later.";
          } else if (data['reason'][0] == "wrong_method") {
            return "There was an issue with the application. Please contact the administrators.";
          } else {
            return "An error occurred. Please try again later.";
          }
        }
      } else {
        if (data['reason'][0] == "banned") {
          return "Your account has been permanently banned. Please contact the administrators if you believe this is a mistake.";
        } else if (data['reason'][0] == "login") {
          return "Your username or password was incorrect. Try again or create a new account.";
        } else if (data['reason'][0] == "server_error") {
          return "There was an issue with the server. Please try again later.";
        } else if (data['reason'][0] == "wrong_method") {
          return "There was an issue with the application. Please contact the administrators.";
        } else {
          return "An error occurred. Please try again later.";
        }
      }
    } catch (e) {
      return "Login failed.";
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

      // Parse data response
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['status'] == true &&
            data['message'] == "User successfully created.") {
          return "Success"; // Signup was successful
          // Error occurred.
        } else {
          return data['message'];
        }
      } else {
        return data['message'];
      }
    } catch (e) {
      return "An error occurred. Please try again later.";
    }
  }

  Future<String> logout() async {
    try {
      // Sending login request to server
      var response = await http.post(
        Uri.parse('http://10.0.2.2/api/logout.php'),
        headers: {'Cookie': "PHPSESSID=$sessionState"},
      );

      // Parse data response
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['success']) {
          return "Success"; // Login was successful
        } else {
          if (data['reason'][0] == "not_logged_in") {
            return "This user is not logged in.";
          } else if (data['reason'][0] == "server_error") {
            return "There was an issue with the server. Please try again later.";
          } else {
            return "An error occurred. Please try again later.";
          }
        }
      } else {
        if (data['reason'][0] == "not_logged_in") {
          return "This user is not logged in.";
        } else if (data['reason'][0] == "server_error") {
          return "There was an issue with the server. Please try again later.";
        } else {
          return "An error occurred. Please try again later.";
        }
      }
    } catch (e) {
      return "An error occurred. Please try again later.";
    }
  }
}
