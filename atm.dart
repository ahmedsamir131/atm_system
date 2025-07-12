 import 'dart:io';

int balance = 0;
void load_balance() {
  File file = File("balance.txt");
  String line = file.readAsStringSync();
  balance = int.parse(line);
}

void save_balance() {
  File file = File("balance.txt");
  file.writeAsStringSync(balance.toString());
}

void showBalance() {
  print("your balance is ---> $balance ");
}

void depositMoney() {
  print("entr eyour money wanted to add : ");
  int value = int.parse(stdin.readLineSync()!);
  if (value != null) {
    balance += value;
    save_balance();
  }
}

void withdrawMoney() {
  while (true) {
    print("entr your money wanted to withdrawal : ");
    int value = int.parse(stdin.readLineSync()!);
    if (value != null && balance > 0) {
      if (value > balance) {
        print("the value grater than balance . try again : ");
      } else {
        balance -= value;
        save_balance();
        break;
      }
    } else {
      print("your balance is 0 egp");
      break;
    }
  }
}

int login() {
  int count = 0;
  while (count < 3) {
    print("please entre the password : ");
    int password = int.parse(stdin.readLineSync()!);
    if (password == 1234) {
      return 1;
    } else {
      count++;
    }
  }
  return 0;
}

void show_menu() {
  if (login() == 0) {
    print("the password is wrong : please try another timr : ");
    return;
  }
  load_balance();
  while (true) {
    print("1 -  show balance ");
    print("2 -  depositMoney");
    print("3 -  withdrawMoney");
    print("4-   exit");
    print("entre the choice : ");
    int choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
        showBalance();
        break;

      case 2:
        depositMoney();
        break;
      case 3:
        withdrawMoney();
        break;
      case 4:
        return;
      default:
        print("invalid input ....");
    }
  }
}

void main() {
  show_menu();
}