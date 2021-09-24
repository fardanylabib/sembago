class StringHelper{
  static String productNameToCode(String name){
    return name.replaceAll(' ', '-').toLowerCase();
  }
}