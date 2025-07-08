void main() {
  // Calc Triangle area
  calcTriangleArea(double base, double height) {
    double Formula = base * height / 2;
    print("Triangle Area = $Formula cm");
    print("------End of Triangle Area------");
    print("--------------------------------------------");
  }

  calcTriangleArea(5, 6);
  // ------------------------
  // Calc Time
  timeCalc(int seconds) {
    int hours = ((seconds ~/ 3600));
    int min = ((seconds ~/ 60) % 60);
    int sec = (seconds % 60);
    String convert = "hours: $hours : min: $min : sec: $sec ";
    print(convert);
    print("------End of Time Calc------");
    print("--------------------------------------------");
  }

  timeCalc(9001);
  // ------------------------
  // Calc Circle Area
  calcCircleArea(double radius) {
    double area = 3.14 * radius * radius;
    print("Circle Area = $area cm");

    double circumference = 2 * 3.14 * radius;
    print("Circle Circumference = $circumference cm");
    print("------End of Circle Area------");
    print("--------------------------------------------");
  }

  calcCircleArea(7);
  // ------------------------
  ageINnDays(int birthyear) {
    int currntYear = DateTime.now().year;
    int age = currntYear - birthyear;
    int ageInMonths = age * 12;
    int ageInDays = age * 365;
    print("Your age in years = $age years");
    print("Your age in months = $ageInMonths months");
    print("Your age in days = $ageInDays days");
    print("------End of Age in Days------");
    print("--------------------------------------------");
  }

  ageINnDays(2004);
  // --------------------------
  //Currency Converter
  currencyConverter(double amountInEGP, String targetCurrency) {
    double exchangeRate;

    if (targetCurrency == "USD") {
      exchangeRate = 0.032;
    } else if (targetCurrency == "EUR") {
      exchangeRate = 0.029;
    } else if (targetCurrency == "SAR") {
      exchangeRate = 0.12;
    } else {
      print("Unsupported currency: $targetCurrency");
      return;
    }
    double transfreFee = amountInEGP * 0.02;
    if (transfreFee < 50) {
      transfreFee = 50;
    }
    double totalAmount = amountInEGP - transfreFee;
    double convertedAmount = totalAmount * exchangeRate;
    print(
      "Converted amount in $targetCurrency: ${convertedAmount.toStringAsFixed(1)}",
    );
    print("Original amount: $amountInEGP EGP");
    print("Transfer fee: $transfreFee EGP");
    print("Amount after fee: $totalAmount EGP");
    print(
      "Converted to $targetCurrency: ${convertedAmount.toStringAsFixed(2)} $targetCurrency",
    );
  }

  currencyConverter(1000, "USD");
  // ---------------------------
  // -----------End-------------
}
