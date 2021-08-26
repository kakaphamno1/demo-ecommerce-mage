extension string_x on String{
  bool isNumeric() {
    return double.tryParse(this) != null;
  }
}