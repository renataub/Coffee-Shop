import 'package:coffee_shop/model/coffee.dart';
import 'package:coffee_shop/model/coffee_shop.dart';
import 'package:coffee_shop/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ManagerPage extends StatefulWidget{
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage>{
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imagePathController = TextEditingController(text: "lib/images/");
  final ProductService _productService = ProductService(); 

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Manager Products"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Product Name"),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: "Product Price"),
            ),
            TextField(
              controller: _imagePathController,
              decoration: InputDecoration(labelText: "Image Path"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                _addProduct();
              },
              child: Text("Add Product"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _buildProductList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return StreamBuilder<List<Coffee>>(
      stream: _productService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Products Found'));
        }

        List<Coffee> products = snapshot.data!;

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            Coffee product = products[index];

            return ListTile(
              title: Text(product.name),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              leading: Image.asset(product.imagePath, height: 50),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red,),
                onPressed: () {
                  _deleteProduct(product.id);
                },
              ),
            );
          },
        );
      },
    );
  }

  void _addProduct(){
    final name = _nameController.text.trim();
    final price = double.parse(_priceController.text.trim());
    final imagePath = _imagePathController.text.trim();

    if(name.isNotEmpty && price > 0 && imagePath.isNotEmpty){
      Coffee newCoffee = Coffee(name: name, price: price, imagePath: imagePath);
      _productService.addProduct(newCoffee);
    } else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter valid products details"),
        backgroundColor: Colors.red,
      ));
    }
    
  }

  void _deleteProduct(String? productId) {
    if (productId != null) {
      _productService.deleteProduct(productId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Product ID is null, cannot delete product"),
        backgroundColor: Colors.red,
      ));
    }
  }

}