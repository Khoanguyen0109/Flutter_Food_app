class AuthUtils {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return ("Please Enter Your Email");
    }
    // reg expression for email validation
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
      return ("Please Enter a valid email");
    }
    return null;
  }

  static String? validatePasswrod(String value) {
    RegExp regex = new RegExp(r'^.{6,}$');
    if (value.isEmpty) {
      return "Password is required for login";
    }
    if (!regex.hasMatch(value)) {
      return "Enter Valid Password(Min. 6 Character)";
    }
    return null;
  }

  static String? validateConfirmPassword(String value, String password) {
    if (value != password) {
      return "Password does not match ";
    }
    return null;
  }

  static String? validatePhone(String value) {
    if (value.isEmpty) {
      return ("Please Enter Your Phone number");
    }
    return null;
  }

  static String errorMessage(String errorCode) {
    String message = "";
    switch (errorCode) {
      case "invalid-email":
        message = "Your email address appears to be malformed.";

        break;
      case "wrong-password":
        message = "Your password is wrong.";
        break;
      case "user-not-found":
        message = "User with this email doesn't exist.";
        break;
      case "user-disabled":
        message = "User with this email has been disabled.";
        break;
      case "too-many-requests":
        message = "Too many requests";
        break;
      case "operation-not-allowed":
        message = "Signing in with Email and Password is not enabled.";
        break;
      default:
        message = "An undefined Error happened.";
    }
    return message;
  }
}
