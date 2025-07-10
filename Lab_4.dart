class ShoppingCart {
  List<String> items = [];
  String? couponCode;
  late double totalPrice;
  String? deliveryAddress;

  void addItem(String item) {
    items.add(item);
  }

  void applyCoupon(String? code) {
    if (code != null && code.isNotEmpty) {
      couponCode = code;
    }
  }

  void calculateTotal() {
    totalPrice = items.length * 10.0;
    if (couponCode != null) {
      totalPrice *= 0.9;
    }
  }

  void checkout() {
    if (deliveryAddress == null || deliveryAddress!.isEmpty) {
      print("Delivery address is required.");
      return;
    }
    calculateTotal();
    print("Total: \$${totalPrice.toStringAsFixed(2)}");
    print("Deliver to: $deliveryAddress");
  }
}

void main(){
  ShoppingCart cart = ShoppingCart();
  cart.addItem("Apple");
  cart.addItem("Banana");
  cart.applyCoupon("WhiteFRIDAY");
  cart.deliveryAddress = "123 Main St";
  cart.checkout();
}