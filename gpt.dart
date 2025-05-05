import 'dart:io';

List<Map<String, dynamic>> userDetails = [];
int? loggedInIndex;

void main() {
  while (true) {
    print("""

    ================================
         WELCOME TO MY BANK ATM     
    ================================

    => PRESS 1 TO SIGN UP
    => PRESS 2 TO LOGIN
    => PRESS 3 TO EXIT
    """);

    String choice = stdin.readLineSync()!;
    if (choice == "1") {
      signUp();
    } else if (choice == "2") {
      login();
    } else if (choice == "3") {
      print("Thank you for using My Bank ATM!");
      exit(0);
    } else {
      print("❌ Invalid Choice!");
    }
  }
}

void signUp() {
  print("Enter your name:");
  String name = stdin.readLineSync()!.toUpperCase();

  String pin = "";
  while (true) {
    print("Create a 4-digit PIN:");
    pin = stdin.readLineSync()!;
    if (pin.length == 4 && int.tryParse(pin) != null) break;
    print("❌ Invalid PIN! Try again.");
  }

  print("Enter starting balance:");
  num balance = num.parse(stdin.readLineSync()!);

  userDetails.add({
    "name": name,
    "pin": pin,
    "balance": balance,
    "transactions": [],
  });

  print("✅ Account created successfully!\n");
}

void login() {
  print("Enter your name:");
  String name = stdin.readLineSync()!.toUpperCase();

  print("Enter your 4-digit PIN:");
  String pin = stdin.readLineSync()!;

  for (int i = 0; i < userDetails.length; i++) {
    if (userDetails[i]["name"] == name && userDetails[i]["pin"] == pin) {
      loggedInIndex = i;
      print("✅ Login successful!\n");
      mainMenu();
      return;
    }
  }
  print("❌ Invalid credentials. Try again.");
}

void mainMenu() {
  while (true) {
    print("""

    ========== MAIN MENU ==========
    => 1. Check Balance
    => 2. Deposit Money
    => 3. Withdraw Money
    => 4. Show Transactions
    => 5. Change PIN
    => 6. Logout
    """);

    String choice = stdin.readLineSync()!;
    if (choice == "1") {
      checkBalance();
    } else if (choice == "2") {
      deposit();
    } else if (choice == "3") {
      withdraw();
    } else if (choice == "4") {
      showTransactions();
    } else if (choice == "5") {
      changePin();
    } else if (choice == "6") {
      print("🔒 Logged out.\n");
      loggedInIndex = null;
      break;
    } else {
      print("❌ Invalid choice!");
    }
  }
}

void checkBalance() {
  var user = userDetails[loggedInIndex!];
  print("💰 Current balance: ${user["balance"]}");
}

void deposit() {
  print("Enter amount to deposit:");
  num amount = num.parse(stdin.readLineSync()!);
  userDetails[loggedInIndex!]["balance"] += amount;

  userDetails[loggedInIndex!]["transactions"].add({
    "type": "Deposit",
    "amount": amount,
    "time": DateTime.now().toLocal(),
  });

  print("✅ Deposited successfully!");
}

void withdraw() {
  print("Enter amount to withdraw:");
  num amount = num.parse(stdin.readLineSync()!);
  num balance = userDetails[loggedInIndex!]["balance"];

  if (amount > balance) {
    print("❌ Insufficient funds.");
    return;
  }

  userDetails[loggedInIndex!]["balance"] -= amount;

  userDetails[loggedInIndex!]["transactions"].add({
    "type": "Withdraw",
    "amount": amount,
    "time": DateTime.now().toLocal(),
  });

  print("✅ Withdrawn successfully!");
}

void showTransactions() {
  List trans = userDetails[loggedInIndex!]["transactions"];
  if (trans.isEmpty) {
    print("📭 No transactions yet.");
  } else {
    print("\n📋 Transactions:");
    for (var t in trans) {
      print("${t["type"]} - ${t["amount"]} - ${t["time"]}");
    }
  }
}

void changePin() {
  print("Enter your old PIN:");
  String oldPin = stdin.readLineSync()!;
  if (oldPin == userDetails[loggedInIndex!]["pin"]) {
    print("Enter your new 4-digit PIN:");
    String newPin = stdin.readLineSync()!;
    if (newPin.length == 4 && int.tryParse(newPin) != null) {
      userDetails[loggedInIndex!]["pin"] = newPin;
      print("✅ PIN changed successfully!");
    } else {
      print("❌ Invalid PIN format.");
    }
  } else {
    print("❌ Incorrect old PIN.");
  }
}
