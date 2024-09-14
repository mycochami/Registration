import 'dart:async';
import 'dart:io';
import 'login.dart';
import 'dbConnection.dart';

Future userRegister() async {
  var conn = await dbConnect();
  print("=====WELCOME TO OUR REGISTRATION =====");

  print("");

  stdout.write("====1. Enter your work ID: ");
  var EMPID = stdin.readLineSync();

  stdout.write("====1. Enter your first name: ");
  var EMPNAME = stdin.readLineSync();
  
  stdout.write ("====2. Enter your lName name: ");
  var LEMPNAME = stdin.readLineSync();

  print("===== Select Your Gender =====");
  print("===== 1. Male            ======");
  print("===== 2. Female          =====");
  stdout.write("press (1) for Male or  (2) for Female: ");
  var user_gender = stdin.readLineSync();
  var GENDER;
  if (user_gender == "1")  {
    GENDER = "MALE";
  } else if (user_gender == "2") {
    GENDER = "FEMALE";
  }
  
 stdout.write("====1. Enter your department: ");
  var DEPARTMENT = stdin.readLineSync();

   stdout.write("====1. Enter your College: ");
  var COLLEGUE = stdin.readLineSync();

  stdout.write("====3. Enter your username: ");
  var USERNAME = stdin.readLineSync();
   print('');
  print('Password should contain upper & small letters, numbers, and special characters.');
   

 bool strong(String password) {
  bool upper = password.contains(RegExp(r'[A-Z]'));
  bool lower = password.contains(RegExp(r'[a-z]'));
  bool number = password.contains(RegExp(r'[0-9]'));
  bool special = password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
  bool length = password.length >= 8;
  
  return upper && lower && number && special && length;
}
  String password;
  do {
    print('');
    stdout.write("Enter password: ");
    stdin.echoMode = false;
    password = stdin.readLineSync()!;
    stdin.echoMode = true;
    if (!strong(password)) {
      print('Password is not strong enough, try again');
    }
  } while (!strong(password));
   
  print("");
  stdout.write("====5. Enter your password to verify: ");
  
  stdin.echoMode = false;
  var verPassword = stdin.readLineSync().hashCode;
  stdin.echoMode = true;
  print("");
  var PASSWORD = verPassword;

    var employee_data_insert = await conn.query(
      'insert into employee values(?,?,?,?,?,?,?,?)',
      [EMPID, EMPNAME, LEMPNAME, GENDER,COLLEGUE, DEPARTMENT, USERNAME, PASSWORD,]);
  
    print("Thank you for using our registration menu");
    print("=====You are successfuly registered=====");
    print(" ______________________________________ ");
    print("#______________________________________#");
    print("You Want to login...?: ");
    print("1. Yes");
    print("2. No");

    stdout.write("Press (1) to accept login page or (2) to cancel ");
    var userAcception = stdin.readLineSync();
    if (userAcception == "1") {
      login();
    } else  {
      exit(0);
    }
  
   await conn.close();
}
