
import 'dart:io';

List<Map<String, dynamic>> userDetails = [];

void main() {
  // ASSIGNMENT 04 DART PROJECT
  // For this assignment, you are required to create a console-based application using Dart, demonstrating your understanding of fundamental programming concepts, including lists, maps, loops, and functions. The goal of this project is to test your ability to apply these concepts effectively in a practical application.

  // Console Based ATM Management System

  print("""



                    ====================================
                   |                                    |
                   |                                    |
                   |      WELCOME TO MY BANK ATM        |
                   |                                    |
                   |                                    |
                    ====================================

      ========================                ======================== 
     |                        |              |                        |
     |   PRESS 1 => SIGN UP   |              |    PRESS 2 => LOGIN    |
     |                        |              |                        |
      ========================                ========================

    """);

  String userPress = stdin.readLineSync()!;

  if (userPress == "1") {
    signUp();
  } else if (userPress == "2") {
    login();
  } else {
    print("SOMETHING WRONG");
  }
}

signUp() {
  print("Enter Your Name");
  String userName = stdin.readLineSync()!;

  bool isTrue = true;

  print("Create a 4-digit PIN");
  String userPin = stdin.readLineSync()!;

  while (isTrue) {
    if (userPin.length != 4) {
      print("❌ Invalid PIN! Please enter a 4-digit number.");
      String userPin = stdin.readLineSync()!;
      if (userPin.length == 4) {
        isTrue = false;
      }
    }
  }

  
  print("Enter starting balance");
  String userBalance = stdin.readLineSync()!;


  userDetails.add({
    "USER NAME": userName,
    "USER PIN": userPin,
    "USER BALANCE": userBalance,
  });

  print("""
      =============================
      Account created successfully!
      =============================
    """);

  print("transcations continue press 1");
  print("EXIT press 2");

  String userPress = stdin.readLineSync()!;
  if (userPress == "1") {
    login();
  } else if (userPress == "2") {
    exit(0);
  } else {
    print("Invalid Option");
  }
}

login() {
  print("Enter your Name");
  String userName = stdin.readLineSync()!;

  if (userDetails.isEmpty) {
    print("""

USER NOT FOUND

PRESS 1 FOR SIGN UP
PRESS 2 FOR EXIT

      """);

    String userPress = stdin.readLineSync()!;

    if (userPress == "1") {
      signUp();
      return;
    } else if (userPress == "2") {
      exit(0);
    } else {
      print("something wrong");
      exit(0);
    }
  }

  bool isTrue = true;

  print("Enter your 4-digit PIN");
  String userPin = stdin.readLineSync()!;

  while (isTrue) {
    if (userPin.length != 4) {
      print("❌ Invalid PIN! Please enter a 4-digit number.");
      String userPin = stdin.readLineSync()!;
      if (userPin.length == 4) {
        isTrue = false;
      }
    }
  }

  bool Found = false;

  for (var i = 0; i < userDetails.length; i++) {
    if (userName == userDetails[i]["USER NAME"] &&
        userPin == userDetails[i]["USER PIN"]) {
      print("Login Succesfull!");
      Found = true;
      break;
    }
  }

  if (!Found) {
    print("Invalid username or PIN.");
  }
}
