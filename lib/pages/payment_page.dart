import 'package:coffee_shop/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import '../model/coffee_shop.dart';
import '../services/email_service.dart';

class PaymentPage extends StatefulWidget{
  final String userEmail;
  const PaymentPage({required this.userEmail});

  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String cardNumber = "";
  String expiryDate = "";
  String cvvCode = "";
  String cardHolderName = "";
  bool isCvvFocused = false;
  final GlobalKey<FormState> key = new GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  final EmailService _emailService = new EmailService();

    void onCreditCardModelChange(CreditCardModel model){
    setState(() {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cvvCode = model.cvvCode;
      cardHolderName = model.cardHolderName;
      isCvvFocused = model.isCvvFocused;
    });
  }

  void processPayment(){
    if(key.currentState!.validate()){
      var cartItem = Provider.of<CoffeeShop>(context, listen: false).userCart;
      String orderDetails = cartItem.map((item) => "${item.name} x${item.quantity}").join("\n");
      double totalprice = cartItem.fold(0, (sum, item) => sum + item.price * item.quantity);
      String total = totalprice.toStringAsFixed(2);
      String email = widget.userEmail.isEmpty ? _emailController.text.trim() : widget.userEmail;

      _emailService.sendOrderEmail(email, orderDetails, total);

      Provider.of<CoffeeShop>(context, listen: false).clearCart();

      showDialog(
        context: context, 
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Text("Success"),
            content: Text("Payment Successful"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        }
      );
    }
  }
 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text("Credit Card Payment"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: cardNumber, 
              expiryDate: expiryDate,  
              cvvCode: cvvCode,
              cardHolderName: cardHolderName, 
              showBackView: isCvvFocused, 
              onCreditCardWidgetChange: (CreditCardBrand){}
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CreditCardForm(
                      cardNumber: cardNumber, 
                      expiryDate: expiryDate, 
                      cvvCode: cvvCode,
                      cardHolderName: cardHolderName, 
                      onCreditCardModelChange: onCreditCardModelChange, 
                      formKey: key,
                      obscureCvv: true,
                      obscureNumber: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: processPayment,
                      child: Container(
                        margin: EdgeInsets.all(8),
                        child: Text('Pay Now',
                          style: TextStyle(color: Colors.black, fontSize: 18,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}