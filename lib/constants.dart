import 'package:flutter/material.dart';
import 'package:igig/size_config.dart';

const CONST_COR_PRIMARIA = Color(0xFF006fa4);
const CONST_COR_DELETAR = Color(0xFFfb3127);
const CONST_COR_CINZA = Color(0xffcccccc);
const CONST_COR_SUBTITULO = Color(0xFF757575);
const CONST_COR_VERDE = Color(0xFF4CD62B);
// const CONST_COR_VERDE_ESCURO = Colors.deepOrangeAccent.withOpacity(0.8);
const CONST_COR_AZUL = Color(0xFF5965E0);
const CONST_COR_AZUL_ESCURO = Color(0xFF4953B8);
const CONST_COR_VERMELHO = Color(0xFFE83F5B);
const CONST_COR_TITLE = Color(0xFF2E384D);
const CONST_COR_TEXTO = Color(0xFF666666);
const CONST_COR_BACKGROUND = Color(0xFFF2F3F5);
const CONST_COR_BRANCA = Color(0xFFfffFFF);
const CONST_COR_PENDENTE = Color(0xfffca23c);
// const CONST_COR_ = Color(0xFF);

const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: 50,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kCPFNullError = "Please Enter your address";


final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
