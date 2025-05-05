import 'dart:io';

List<Map<String, dynamic>> userDetails = [];
String userName = "";
String userPin = "";
num userBalance = 0;
List<Map<String, dynamic>> transtions = [];
DateTime now = DateTime.now();
num finalAmount = 0;

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
  userName = stdin.readLineSync()!.toUpperCase();

  bool isTrue = true;

  print("Create a 4-digit PIN");
  userPin = stdin.readLineSync()!;

  while (isTrue) {
    if (userPin.length == 4) {
      isTrue = false;
    }
    if (userPin.length != 4) {
      print("❌ Invalid PIN! Please enter a 4-digit number.");
      String userPin = stdin.readLineSync()!;
      if (userPin.length == 4) {
        isTrue = false;
      }
    }
  }

  print("Enter starting balance");
  userBalance = int.parse(stdin.readLineSync()!);

  userDetails.add({
    "USER NAME": userName,
    "USER PIN": userPin,
    "USER BALANCE": userBalance,
    "USER TRANSTIONS": [],
  });

  print("""


 =============================
 Account created successfully!
 =============================


    """);

  print("""
=============================
    LOGIN ACCOUNT Press 1
=============================
    """);
  print("""
==================================
Check your Account Balance Press 2
==================================
    """);

  print("""
=============================
       EXIT Press 3
=============================
    """);

  String userPress = stdin.readLineSync()!;
  if (userPress == "1") {
    login();
  } else if (userPress == "2") {
    print("""

 =====================================================
 Your Account Statement  
 NAME :  ${userDetails[0]["USER NAME"]}
 CURRENT BALANCE :  ${userDetails[0]["USER BALANCE"]}
 =====================================================

""");
  } else if (userPress == "3") {
    exit(0);
  } else {
    print("Invalid Option");
  }
}

login() {
  print("Enter your Name");
  userName = stdin.readLineSync()!.toUpperCase();

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

  print("Enter your 4-digit PIN");
  userPin = stdin.readLineSync()!;

  bool Found = false;

  for (var i = 0; i < userDetails.length; i++) {
    if (userName == userDetails[i]["USER NAME"] &&
        userPin == userDetails[i]["USER PIN"]) {
      print("""

==========================
   LOGIN SUCCES FULL!
==========================

""");

      mainManu();
      Found = true;
      break;
    }
  }

  if (!Found) {
    print("Invalid username or PIN.");
  }
}

mainManu() {
  while (true) {
    print("""

Welcome, $userName!

=> 1. Check Balance
=> 2. Deposit Money
=> 3. Withdraw Money
=> 4. Show Transactions
=> 5. Change PIN
=> 6. Logout

Enter your choice:

""");
    String userChoice = stdin.readLineSync()!;

    if (userChoice == "6") {
      print("logged Out");
      exit(0);
    } else if (userChoice == "1") {
      checkBalance();
    } else if (userChoice == "2") {
      deposit();
    } else if (userChoice == "3") {
      withDraw();
    } else if (userChoice == "4") {
      showTransctions();
    }
  }
}

checkBalance() {
  for (var i = 0; i < userDetails.length; i++) {
    if (userName == userDetails[i]["USER NAME"] &&
        userPin == userDetails[i]["USER PIN"]) {
      print("""

========================================================
Your current balance is: ${userDetails[i]["USER BALANCE"]}
========================================================

""");
    }
  }
}

deposit() {
  print("ENTER AMOUNT TO DEPOSIT");
  num depositAmount = num.parse(stdin.readLineSync()!);
  finalAmount = depositAmount + userDetails[0]["USER BALANCE"];
  print("=> Deposit successful! New balance: $finalAmount");
  transtions = userDetails[0]["USER TRANSTIONS"][0];
  transtions.add({
    "type": "deposit",
    "amount": depositAmount,
    "time": now.toLocal(),
  });
  return transtions;
}

withDraw() {
  print("Enter amount to withdraw :");
  num withDrawAmount = num.parse(stdin.readLineSync()!);
  if (withDrawAmount > userDetails[0]["USER BALANCE"] ||
      withDrawAmount > finalAmount) {
    print("Not enough balance?");
    exit(0);
  }
  if (transtions.isEmpty) {
    finalAmount = userDetails[0]["USER BALANCE"];
    finalAmount -= withDrawAmount;
  }
  print("=> Withdrawal successful! New balance: $finalAmount");
  transtions.add({
    "type": "withdraw",
    "amount": withDrawAmount,
    "time": now.toLocal(),
  });
}

showTransctions() {
  if (transtions.isEmpty) {
    print("No transctions recorded");
  } else {
    print(transtions);
  }
}
