extension StringExtension on String {
  static const checkIsValidEmail =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  bool isEmail() {
    final RegExp regex = RegExp(checkIsValidEmail);
    return regex.hasMatch(this);
  }
}
