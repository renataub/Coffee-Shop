import 'package:coffee_shop/components/bottom_nav_bar.dart';
// import 'package:coffee_shop/components/coffee_tile.dart';
import 'package:coffee_shop/const.dart';
import 'package:coffee_shop/pages/cart_page.dart';
import 'package:coffee_shop/pages/shop_page.dart';
import 'package:flutter/material.dart';

import 'about_page.dart';
import 'manager_page.dart';

class HomePage extends StatefulWidget{
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages =[
    ShopPage(),
    CartPage(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: MyBottomNavBar(onTapChange: navigateBottomBar,),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(builder: (context) => IconButton( 
          icon: Padding(
            padding: EdgeInsets.all(14),
            child: Icon(Icons.menu, color: Colors.black),
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        )),
      ),
      drawer: Drawer(
        backgroundColor: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 80),
                Image.asset("lib/images/espresso.png", height: 160),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Divider(color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.home),
                      title: Text("Home"),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: ListTile(
                      leading: Icon(Icons.info),
                      title: Text("About"),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    _showManagerVerificationDialog(context);
                    // Navigator.pop(context);
                    // Navigator.push(
                    //   context, 
                    //   MaterialPageRoute(builder: (context) => ManagerPage()),
                    // );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: ListTile(
                      leading: Icon(Icons.manage_accounts),
                      title: Text("Manage Products"),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 25, bottom: 25),
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                ),
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

    Future<void> _showManagerVerificationDialog(BuildContext context) async {
    String enteredEmail = '';
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Manager Verification'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please enter your email to verify your identity as a manager:'),
                TextField(
                  onChanged: (value) {
                    enteredEmail = value.trim();
                  },
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     child: Text('Verify'),
          //     onPressed: () async{
          //       final String managerEmail = 'g0548457103@gmail.com'; // Replace with your manager's email
          //       if (enteredEmail == managerEmail) {
          //         Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute(builder: (context) => ManagerPage()),
          //         );
          //       } else {
          //         Navigator.pop(context); // Close the dialog
          //         Navigator.push(
          //           context, 
          //           MaterialPageRoute(builder: (context) => HomePage()),
          //         );
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(
          //             content: Text('Invalid manager email.'),
          //           ),
          //         );
          //       }
          //     },
          //   ),
          // ],
        );
      },
    );
  }
}