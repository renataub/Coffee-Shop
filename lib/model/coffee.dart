import 'package:cloud_firestore/cloud_firestore.dart';

class Coffee{
  final String? id;
  final String name;
  final double price;
  final String imagePath;
  int quantity;

  Coffee({
    this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });

  factory Coffee.fromFireStore(DocumentSnapshot doc){
    Map data = doc.data() as Map;
    return Coffee(
      id: doc.id,
      name: data["name"] ?? "",
      price: data["price"]?? 0.0,
      imagePath: data["imagePath"]?? "",
    );
  }

  Map<String, dynamic> toMap(){
    return{
      "id": id,
      "name": name,
      "price": price,
      "imagePath": imagePath,
      "quantity": quantity,  
    };
  }

}