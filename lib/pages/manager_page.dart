// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart'; // Import Provider package
// import '../model/coffee_shop.dart';

// class ManagerPage extends StatefulWidget {
//   @override
//   _CoffeeManagerScreenState createState() => _CoffeeManagerScreenState();
// }

// class _CoffeeManagerScreenState extends State<ManagerPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   File? _imageFile;
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _priceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Coffee Manager'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text('Add New Product:'),
//             SizedBox(height: 10.0),
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(
//                 labelText: 'Product Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10.0),
//             TextField(
//               controller: _priceController,
//               keyboardType: TextInputType.numberWithOptions(decimal: true),
//               decoration: InputDecoration(
//                 labelText: 'Price (\$)',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10.0),
//             _imageFile != null
//                 ? Image.file(
//                     _imageFile!,
//                     height: 100.0,
//                   )
//                 : ElevatedButton(
//                     onPressed: () {
//                       _pickImage();
//                     },
//                     child: Text('Pick Image'),
//                   ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 _addProductToShop(context);
//               },
//               child: Text('Add Product'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _imageFile = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   void _addProductToShop(BuildContext context) {
//     String name = _nameController.text.trim();
//     double price = double.tryParse(_priceController.text.trim()) ?? 0.0;

//     // Validate input
//     if (name.isEmpty || price <= 0 || _imageFile == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please enter valid product details and select an image.'),
//         ),
//       );
//       return;
//     }

//     // Create a new Coffee object
//     Coffee newCoffee = Coffee(
//       id: '',
//       name: name,
//       price: price,
//       imagePath: '', // Placeholder, will be updated after image upload
//     );

//     // Access the CoffeeShop model using Provider
//     Provider.of<CoffeeShop>(context, listen: false).addNewCoffee(newCoffee, _imageFile!.path);

//     // Clear text fields and image file after adding
//     _nameController.clear();
//     _priceController.clear();
//     setState(() {
//       _imageFile = null;
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Product added to shop successfully!'),
//       ),
//     );
//   }
// }
