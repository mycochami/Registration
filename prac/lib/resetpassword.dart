import 'dart:io';
import 'login.dart';
import 'UserRegister.dart';
import 'dart:async';
import 'dbConnection.dart';

Future resetpassword() async {
  var con = await dbConnect();
  print('Welcome in reset password page\n');
  stdout.write('Write your current first name: ');
  var infname = stdin.readLineSync();

  var dbfname = await con.query("SELECT EMPNAME FROM employee");
  var fnamelist = [];
  for (var fname1 in dbfname) {
    fnamelist.add(fname1.first.toString());
  }
  var dblname = await con.query("SELECT LEMPNAME FROM employee");
  var lnamelist = [];
  for (var lname2 in dblname) {
    lnamelist.add(lname2.first.toString());
  }
  if (fnamelist.contains(infname)) {
    stdout.write('write your current last name: ');
    var lername = stdin.readLineSync();

    if (lnamelist.contains(lername)) {
      var lstnamedb = await con
          .query('select USERNAME from employee where LEMPNAME =?', [lername]);
    print('');
    print('Password should contain upper & small letters, numbers, and special characters.');

        stdout.write('write your new password: ');
        stdin.echoMode = false;
        var reset = stdin.readLineSync().hashCode;
        stdin.echoMode = true;
        print('');

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
        stdout.write('verify your password: ');
        stdin.echoMode = false;
        var verset = stdin.readLineSync().hashCode;
        stdin.echoMode = true;
        print('');
         if (verset == reset) {
          var newpass = await con.query(
              'update employee set PASSWORD =? where LEMPNAME = ?',[verset, lername]);
         print('welcome $infname $lername:Your password reset is successfully\n');
          
          stdout.write('Press 1 for login or any key for exit:');
          var log = stdin.readLineSync();
          if (log == '1') {
            login();
          } else {
            exit(0);
          }
          
        } else {
          print('password did not match');
          stdout.write('Press [1. for register]: ');
          var reg = stdin.readLineSync();
          if (reg == '1') {
            userRegister();
          } else {
            exit(0);
          }
        }
      }
    } else {
      print('Username not found');
      stdout.write('Press [1. for register]: ');
      var reg = stdin.readLineSync();
      if (reg == '1') {
        userRegister();
      } else {
        exit(0);
      }
    }
 
  await con.close();
  }


