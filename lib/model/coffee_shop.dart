import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'coffee.dart';

class CoffeeShop extends ChangeNotifier {
  List<Coffee> _shop = [];
  List<Coffee> _userCart = [];

  CoffeeShop(){
    _fetchProducts();
  }

  List<Coffee> get coffeeShop => _shop;
  List<Coffee> get userCart => _userCart;

  void addItemToCart(Coffee coffee, int quantity){
    coffee.quantity = quantity;
    _userCart.add(coffee);
    notifyListeners();
  }

  void removeFromCart(Coffee coffee){
    _userCart.remove(coffee);
    notifyListeners();
  }

  void clearCart(){
    _userCart = [];
    notifyListeners();
  }


  void _fetchProducts() async{
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("products").get();
    _shop = snapshot.docs.map((doc) {
      return Coffee(
      id: doc.id,
      name: doc["name"],
      price: doc["price"],
      imagePath: doc["imagePath"],
      );
    }).toList();
    notifyListeners();
  }

}