import 'package:coffee_shop/pages/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/my_button.dart';
import '../const.dart';
import '../model/coffee.dart';
import '../model/coffee_shop.dart';

class CartPage extends StatefulWidget {
  final String userEmail;
  const CartPage({required this.userEmail});

  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // List<Coffee> userCart = CoffeeShop().cart;

  void _removeFromCart(Coffee coffee) {
    setState(() {
      Provider.of<CoffeeShop>(context, listen: false).userCart.remove(coffee);
    });
  }

  void _clearCart() {
    setState(() {
      Provider.of<CoffeeShop>(context, listen: false).userCart.clear();
    });
  }

  double _calculateTotalPrice() {
    return Provider.of<CoffeeShop>(context, listen: false).userCart.fold(
          0.0,
          (total, coffee) => total += (coffee.price * coffee.quantity),
        );
  }

  int _calculateTotalItems() {
    return Provider.of<CoffeeShop>(context, listen: false).userCart.fold(
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
                    Provider.of<CoffeeShop>(context, listen: false).userCart.length,
                itemBuilder: (context, index) {
                  final coffee = Provider.of<CoffeeShop>(context, listen: false)
                      .userCart[index];
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
                MaterialPageRoute(builder: (context) => PaymentPage(userEmail: widget.userEmail,)),
              );
            }),
          ],
        ),
      ),
    );
  }
}