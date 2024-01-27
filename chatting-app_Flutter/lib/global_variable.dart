import 'package:flash_chat_flutter_app_challenge/constants.dart';

// bool loggedUserStatus = false;
// String loggedUserEmail = '';
Map<String, dynamic> _loggedUserData = {
  kLoggedUserStatusKey: false,
  kLoggedUserEmailKey: '',
};

void setLoggedUserStatus(bool userStatus) {
  _loggedUserData[kLoggedUserStatusKey] = userStatus;
}

String getLoggedUserEmail() {
  return _loggedUserData[kLoggedUserEmailKey];
}

void setLoggedUserEmail(String userEmail) {
  _loggedUserData[kLoggedUserEmailKey] = userEmail;
}

String removeSpecialChar(String input) {
  String output = input;
  if (input.isNotEmpty) {
    /// '.', '#', '$', '[', or ']'
    var pattern = RegExp("[ .#\$\\[\\]]");
    output = input.replaceAll(pattern, '');
  }
  return output;
}
