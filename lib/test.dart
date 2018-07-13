void main(){
  RegExp mobile = new RegExp(r"(0|86)?(1)[0-9]{10}");
  print(mobile.hasMatch("01381234567"));
}