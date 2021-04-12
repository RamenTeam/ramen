class Validator {
  static final alphanumeric = RegExp(r'^[a-zA-Z0-9_]+$');
  static final numerical = RegExp(r'^\d+$');
  static final email = RegExp(r'^[a-zA-Z.@]+$');
  static String validatePhoneNumber(String input) {
    if (input.isEmpty) return "Phone number is required!";
    if (!numerical.hasMatch(input)) return "Please use numbers!";
    return "";
  }

  static String validateUsername(String input) {
    if (input.isEmpty) return "Username is required!";
    return "";
  }

  static String validatePassword(String input) {
    if (input.isEmpty) return "Password is required!";
    if (!alphanumeric.hasMatch(input))
      return "Please don't use special characters!";
    return "";
  }

  static String validateName(String input) {
    if (input.isEmpty) return "Name is required!";
    if (!alphanumeric.hasMatch(input))
      return "Please don't use special characters!";
    return "";
  }

  static String validateEmail(String input) {
    if (input.isEmpty) return "Email is required!";
    if (!email.hasMatch(input)) return "Please don't use special characters!";
    return "";
  }
}
