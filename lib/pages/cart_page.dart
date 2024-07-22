// // import 'package:coffee_shop/components/coffee_tile_cart.dart';
// // import 'package:coffee_shop/const.dart';
// // import 'package:coffee_shop/model/coffee.dart';
// // import 'package:coffee_shop/model/coffee_shop.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import '../components/my_button.dart';

// // class CartPage extends StatefulWidget {
// //   State<CartPage> createState() => _CartPageState();
// // }

// // class _CartPageState extends State<CartPage> {
// //   // List<Coffee> userCart = CoffeeShop().cart;
// //   final CoffeeShop coffeeShop = CoffeeShop();

// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: backgroundColor,
// //       appBar: AppBar(
// //         title: Text("Cart Page"),
// //         backgroundColor: backgroundColor,
// //       ),
// //       body: Consumer<CoffeeShop>(
// //               builder: (context, value, child){
// //                 return Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Expanded(
// //                       child: ListView.builder(
// //                         itemCount: value.,
// //                         itemBuilder: itemBuilder
// //                       ),
// //                     ),
// //                   ],
// //                 );
// //               }
// //           //     crossAxisAlignment: CrossAxisAlignment.start,
// //           //     children: [
// //           //       // Padding(
// //           //       //   padding: EdgeInsets.only(left: 25, top: 25),
// //           //       //   child: Text(
// //           //       //     "How do you like your coffee?",
// //           //       //     style: TextStyle(fontSize: 20),
// //           //       //   ),
// //           //       // ),
// //           //       // SizedBox(height: 25),
// //           //       Expanded(
// //           //         child: ListView.builder(
// //           //             itemCount: value.,
// //           //             itemBuilder: (context, index) {
// //           //               Coffee eachCoffee = value.coffeeShop[index];
// //           //               return CoffeeTileCart(
// //           //                 coffee: eachCoffee,
// //           //                 onPressed: () =>
// //           //                     coffeeShop.removeFromCart(eachCoffee),
// //           //               );
// //           //             }),
// //           //       ),
// //           //     ],
// //           //   ),
// //           // ),
// //           // // Row(
// //           // //   children: [
// //           // //     Text("total quantity:"),
// //           // //     Text('${userCart.length}'),
// //           // //   ],
// //           // // ),
// //           // SizedBox(height: 75),
// //           // MyButton(text: "Pay now", onTap: (){}),
// //       ),
// //     );
// //   }
// // }

import 'package:coffee_shop/pages/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../components/coffee_tile.dart';
import '../components/my_button.dart';
import '../const.dart';
import '../model/coffee_shop.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // List<Coffee> userCart = CoffeeShop().cart;

  void _removeFromCart(Coffee coffee) {
    setState(() {
      Provider.of<CoffeeShop>(context, listen: false).cart.remove(coffee);
    });
  }

  void _clearCart() {
    setState(() {
      Provider.of<CoffeeShop>(context, listen: false).cart.clear();
    });
  }

  double _calculateTotalPrice() {
    return Provider.of<CoffeeShop>(context, listen: false).cart.fold(
          0.0,
          (total, coffee) => total += (coffee.price * coffee.quantity),
        );
  }

  int _calculateTotalItems() {
    return Provider.of<CoffeeShop>(context, listen: false).cart.fold(
          0,
          (total, coffee) => total + coffee.quantity,
        );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Cart',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                itemCount:
                    Provider.of<CoffeeShop>(context, listen: false).cart.length,
                itemBuilder: (context, index) {
                  final coffee = Provider.of<CoffeeShop>(context, listen: false)
                      .cart[index];
                  return Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          coffee.imagePath,
                          height: 70,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              coffee.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Quantity: ${coffee.quantity}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Total: \$${(coffee.price * coffee.quantity).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.brown),
                          onPressed: () {
                            _removeFromCart(coffee);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  'Total Quantity:',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Text(
                  '${_calculateTotalItems().toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Total Price:',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Text(
                  '\$${_calculateTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            MyButton(text: 'Pay now', onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => PaymentPage()),
              );
            }),
          ],
        ),
      ),
    );
  }
}




// import 'package:coffee_shop/const.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';
// import '../components/My_button.dart';
// import '../components/coffee_tile_cart.dart';
// import '../model/coffee.dart';
// import '../model/coffee_shop.dart';
// import 'payment_page.dart';

// class CartPage extends StatefulWidget {
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {

//   void goToPaymentPage() {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => PaymentPage(
//                   onPaymentSuccess: () {},
//                 )));
//   }

//   double _calculateTotalPrice() {
//     return Provider.of<CoffeeShop>(context, listen: false).cart.fold(
//           0.0,
//           (total, coffee) => total += (coffee.price * coffee.quantity),
//         );
//   }

//   int _calculateTotalItems() {
//     return Provider.of<CoffeeShop>(context, listen: false).cart.fold(
//           0,
//           (total, coffee) => total + coffee.quantity,
//         );
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         title: Text("Your Cart"),
//         backgroundColor: backgroundColor,
//       ),
//       body: Center(
//           child: Consumer<CoffeeShop>(
//         builder: (context, value, child) => Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 25,
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: value.cart.length,
//                 itemBuilder: (context, index) {
//                   Coffee eachCoffee = value.cart[index];
//                   return CoffeeTileCart(
//                     coffee: eachCoffee,
//                     onPressed: () => Provider.of<CoffeeShop>(context, listen: false)
//                       .removeFromCart(eachCoffee)
//                   );
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             Row(
//               children: [
//               Text(
//                 '   Total Quantity:',
//                 style: TextStyle(
//                   fontSize: 18,
//                 ),
//               ),
//               Spacer(),
//               Text(
//                 '${_calculateTotalItems().toStringAsFixed(2)}   ',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ]),
//             Row(
//               children: [
//                 Text(
//                   '   Total Price:',
//                   style: TextStyle(
//                     fontSize: 18,
//                   ),
//                 ),
//                 Spacer(),
//                 Text(
//                   '\$${_calculateTotalPrice().toStringAsFixed(2)}   ',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             MyButton(onTap: () => goToPaymentPage(), text: 'Pay now'),
//           ],
//         ),
//       )),
//     );
//   }
// }