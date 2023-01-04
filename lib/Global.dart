import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Global{
  static String? firstName;
  static String? lastName;
  static String? contact;
  static String? email;
  static File? file;
  static bool isDark = false;
  static List firstNameList = [];
  static List lastNameList = [];
  static List emailList = [];
  static List contactList = [];
  static TextEditingController contactController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController firstController = TextEditingController();
  static TextEditingController lastController = TextEditingController();


  static call({required String contact}) async {
    String number = contact;
    bool? call = await FlutterPhoneDirectCaller.callNumber(number);
  }
}