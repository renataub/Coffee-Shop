// import 'package:flutter/material.dart';

// import 'coffee.dart';
// class CoffeeShop extends ChangeNotifier{
//    final List<Coffee> _shop = [
//     Coffee(
//       name: "Long Black",
//       price: 4.10,
//       imagePath: "lib/images/black.png",
//     ),
//      Coffee(
//       name: "Latte",
//       price: 4.00,
//       imagePath: "lib/images/latte.png",
//     ),
//      Coffee(
//       name: "Espresso",
//       price: 4.40,
//       imagePath: "lib/images/espresso.png",
//     ),
//      Coffee(
//       name: "Iced Coffee",
//       price: 5.00,
//       imagePath: "lib/images/iced_coffee.png",
//     ),
//   ];

//   List<Coffee> get coffeeShop => _shop;
//   List<Coffee> _cart = [];
//   List<Coffee> get cart => _cart;
  
//   void addToCart(Coffee coffee, int quantity) {
//     coffee.quantity = quantity;
//     _cart.add(coffee);
//     notifyListeners();
//   }
  
//   void removeFromCart(Coffee coffee) {
//     //coffee.quantity -= 1;
//     _cart.remove(coffee);
//     notifyListeners();
//   }
//   void clearCart() {
//     _cart.clear();
//     notifyListeners();
//   }
// }




import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as path;

class Coffee {
  final String id; // Unique ID for the coffee product
  final String name;
  final double price;
  final String imagePath;
  int quantity; // Add quantity field if needed

  Coffee({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 0,
  });
}

class CoffeeShop extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _productsRef = FirebaseFirestore.instance.collection('products');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  List<Coffee> _shop = []; // Initialize as empty, will be fetched from Firestore

  CoffeeShop() {
    // Example: Load initial products from Firestore
    _fetchProducts();
  }

  List<Coffee> get coffeeShop => _shop;

  List<Coffee> _cart = [];
  List<Coffee> get cart => _cart;

  void addToCart(Coffee coffee, int quantity) {
    coffee.quantity = quantity;
    _cart.add(coffee);
    notifyListeners();
  }

  void removeFromCart(Coffee coffee) {
    _cart.remove(coffee);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // Fetch products from Firestore
  Future<void> _fetchProducts() async {
    try {
      QuerySnapshot snapshot = await _productsRef.get();
      _shop = snapshot.docs.map((doc) {
        return Coffee(
          id: doc.id,
          name: doc['name'],
          price: doc['price'],
          imagePath: doc['imageUrl'],
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  // Method to add new coffee to Firestore
  Future<void> addNewCoffee(Coffee coffee, File imageFile, String imagePath) async {
    try {
      // Upload image to Firebase Storage and get download URL
      String imageUrl = await _uploadImage(imageFile, imagePath);

      // Add coffee with image URL to Firestore
      DocumentReference docRef = await _productsRef.add({
        'name': coffee.name,
        'price': coffee.price,
        'imageUrl': imageUrl,
      });

      // Optionally update the local shop list with the newly added coffee
      coffee = Coffee(
        id: docRef.id,
        name: coffee.name,
        price: coffee.price,
        imagePath: imageUrl,
      );
      _shop.add(coffee);

      notifyListeners();
    } catch (e) {
      print('Error adding coffee: $e');
    }
  }

  Future<String> _uploadImage(File imageFile, String imageName) async {
    try {
      String fileName = path.basename(imageFile.path);
      String firebaseStoragePath = 'images/$imageName/$fileName';
      Reference ref = _storage.ref().child(firebaseStoragePath);
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadURL = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  // Upload image to Firebase Storage
  // Future<String> _uploadImage(File imageFile, String imagePath) async {
  //   // Example: Upload image to Firebase Storage and return download URL
  //   // Replace 'imagePath' with actual path to your image file
  //   // Example: 'images/coffee.jpg'
  //   // Make sure to handle file paths properly
  //   // Use Firebase Storage SDK to upload image
  //   // Example code is omitted for brevity
  //   return 'your_image_url_here'; // Replace with actual download URL
  // }
}
