import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/coffee.dart';

class ProductService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Coffee>> getProducts() {
    CollectionReference products = _firestore.collection("products");

    return products.snapshots().map((snapshot){
      return snapshot.docs.map((doc) => Coffee(
        id: doc.id,
        name: doc["name"], 
        price: doc["price"], 
        imagePath: doc["imagePath"],
      )).toList();
    });
  }

  Future<void> addProduct(Coffee coffee){
    CollectionReference products = _firestore.collection("products");
    return products
      .add(coffee.toMap())
      .then((value) => print("Product Added"))
      .catchError((error) => print("Failed to add product: $error"));
  }

  Future<void> deleteProduct(String productId) async{
    CollectionReference products = _firestore.collection("products");
    await products
     .doc(productId)
     .delete()
     .then((value) => print("Product Deleted"))
     .catchError((error) => print("Failed to delete product: $error"));
  }


} 