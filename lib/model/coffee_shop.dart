import 'package:flutter/material.dart';

import 'coffee.dart';
class CoffeeShop extends ChangeNotifier{
   final List<Coffee> _shop = [
    Coffee(
      name: "Long Black",
      price: 4.10,
      imagePath: "lib/images/black.png",
    ),
     Coffee(
      name: "Latte",
      price: 4.00,
      imagePath: "lib/images/latte.png",
    ),
     Coffee(
      name: "Espresso",
      price: 4.40,
      imagePath: "lib/images/espresso.png",
    ),
     Coffee(
      name: "Iced Coffee",
      price: 5.00,
      imagePath: "lib/images/iced_coffee.png",
    ),
  ];
  List<Coffee> get coffeeShop => _shop;
  List<Coffee> _cart = [];
  List<Coffee> get cart => _cart;
  void addToCart(Coffee coffee, int quantity) {
    coffee.quantity = quantity;
    _cart.add(coffee);
    notifyListeners();
  }
  
  void removeFromCart(Coffee coffee) {
    //coffee.quantity -= 1;
    _cart.remove(coffee);
    notifyListeners();
  }
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}