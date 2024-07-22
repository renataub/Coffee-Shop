import 'package:coffee_shop/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import '../components/my_button.dart';
import '../model/coffee_shop.dart';

class PaymentPage extends StatefulWidget{
  // final VoidCallback onPaymentSuccess;
  // PaymentPage({required this.onPaymentSuccess});

  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String cardNumber = "";
  String expiryDate = "";
  String cvvCode = "";
  String cardHolderName = "";
  bool isCvvFocused = false;

  final GlobalKey<FormState> key = new GlobalKey<FormState>();

    void onCreditCardModelChange(CreditCardModel model){
    setState(() {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cvvCode = model.cvvCode;
      cardHolderName = model.cardHolderName;
      isCvvFocused = model.isCvvFocused;
    });
  }

  void onPaymentSuccess() {
    Provider.of<CoffeeShop>(context, listen: false).clearCart();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.brown,
        title: Text(
          "Successfully paid",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
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
                    SizedBox(height: 75),
                    // ElevatedButton(
                    //   onPressed: (){
                    //     if(key.currentState!.validate()) {
                    //       onPaymentSuccess();
                    //     } else {
                    //       key.currentState.showErrorMessages();
                    //     }
                    //   }, 
                    //   child: child
                    // ),
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