import 'dart:async';
import 'dart:io';

Map<String, num> users = {
  "ahmed": 12000,
  "mohamed": 10000,
  "ali": 13451,
  "said": 12342,
};
Map<String, num> passwords = {
  "ahmed": 1234,
  "mohamed": 1234,
  "ali": 1234,
  "said": 1234,
};

void loadUsers() {
  File file = File("users.txt");
  if (file.existsSync()) {
    List<String> lines = file.readAsLinesSync();
    for (String line in lines) {
      List<String> parts = line.split("=");
      String username = parts[0];
      num balance = num.parse(parts[1]);
      users[username] = balance;
    }
  }
}

void loadPasswords() {
  File file = File("passwords.txt");
  if (file.existsSync()) {
    List<String> lines = file.readAsLinesSync();
    for (String line in lines) {
      List<String> parts = line.split("=");
      String username = parts[0];
      num passwod = num.parse(parts[1]);
      passwords[username] = passwod;
    }
  }
}

void savepasswords() {
  File file = File("passwords.txt");
  String data = "";
  passwords.forEach((key, value) {
    data += '$key=$value\n';
  });
  file.writeAsStringSync(data);
}

void saveusers() {
  File file = File("users.txt");
  String data = "";
  users.forEach((key, value) {
    data += '$key=$value\n';
  });
  file.writeAsString(data);
}

void showBalance(String username) {
  print("your balance is ---> ${users[username]} ");
}

void depositMoney(String username) {
  print("entr eyour money wanted to add : ");
  int value = int.parse(stdin.readLineSync()!);
  if (value != null) {
    users[username] = users[username]! + value;
    saveusers();
  }
}

void withdrawMoney(String username) {
  while (true) {
    print("entr your money wanted to withdrawal : ");
    int value = int.parse(stdin.readLineSync()!);
    if (value != null && users[username]! > 0) {
      if (value > users[username]!) {
        print("the value grater than balance . try again : ");
      } else {
        users[username] = users[username]! - value;
        saveusers();

        break;
      }
    } else {
      print("your balance is 0 egp");
      break;
    }
  }
}

String login() {
  int count = 0;
  while (count < 3) {
    print("please entre the username : ");
    String username = stdin.readLineSync()!;
    print("please entre the password : ");
    int password = int.parse(stdin.readLineSync()!);
    if (password == passwords[username]) {
      return username;
    } else {
      count++;
    }
  }
  return 'a';
}

void initializeIfFilesMissing() {
  File userfile = File("users.txt");
  File passwordfile = File("passwords.txt");
  if (userfile.existsSync() == false) {
    saveusers();
  }
  if (passwordfile.existsSync() == false) {
    savepasswords();
  }
}

void show_menu() {
  while (true) {
    String username = login();
    if (username == 'a') {
      print("The password is wrong. Please try another time.");
      return;
    }

    while (true) {
      print("1 -  show balance ");
      print("2 -  depositMoney");
      print("3 -  withdrawMoney");
      print("4-   exit");
      print("5 -  back the login page");
      print("entre the choice : ");
      int choice = int.parse(stdin.readLineSync()!);
      switch (choice) {
        case 1:
          showBalance(username);
          break;

        case 2:
          depositMoney(username);
          break;
        case 3:
          withdrawMoney(username);
          break;
        case 4:
          return;
        case 5:
          break;
        default:
          print("invalid input ....");
      }
      if (choice == 5) {
        break;
      }
    }
  }
}

void main() {
  initializeIfFilesMissing();
  loadPasswords();
  loadUsers();
  show_menu();
}