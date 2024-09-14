
import 'dart:io';
import 'dbConnection.dart';
import 'resetpassword.dart';

Future login() async {
  var conn = await dbConnect();
  print("===  Welcome to Our Login Page  ===");
  print("===  Please Authorize your Identity ===");
  stdout.write("Enter your username: ");
  var user_username = stdin.readLineSync();

  stdout.write("Enter your password: ");

  stdin.echoMode = false;
  var user_password = stdin.readLineSync();
  stdin.echoMode = true;
  print("");
  var db_usernames = await conn.query("SELECT USERNAME FROM employee");
  var userList = [];
  for (var user in db_usernames) {
    userList.add(user.first.toString());
  }

  if (userList.contains(user_username)) {
    var u_username = user_username;

    var db_password = await conn.query("SELECT PASSWORD FROM employee WHERE USERNAME=?", [u_username]);
    var names = [];
    var db_names = await conn.query("select * from employee where USERNAME=?", [u_username]);

    for (var name in db_names.toList()) {
      names.add(name[0].toString());
      names.add(name[1].toString());
      names.add(name[2].toString());
      names.add(name[3].toString());
      names.add(name[4].toString());
      names.add(name[5].toString());
      names.add(name[6].toString());
    }
    var realPassword = db_password.toList()[0][0];
    if (realPassword.toString() == user_password.toString()) {
      print("welcome ${names[1]} ${names[2]}");
      print("Your registration ID is ${names[0]},You studied at ${names[4]},and your department is ${names[5]}");
      await conn.close();
    }else {
    print("incorrect password or username");
    stdout.write('Press [1. for reset password or any key to exit]: ');
          var reg = stdin.readLineSync();
          if(reg == '1'){
            resetpassword();
          }else{
            exit(0);
          }
  } 
  }else{
    print("incorrect password or username");
    stdout.write('Press [1. for reset password or any key to exit]: ');
          var reg = stdin.readLineSync();
          if(reg == '1'){
            resetpassword();
          }else{
            exit(0);
          }
  }
  await conn.close();
}
