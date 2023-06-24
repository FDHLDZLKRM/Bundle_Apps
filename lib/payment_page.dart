import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:shrine/db_handler.dart';
import 'package:shrine/home.dart';
import 'package:shrine/model/product.dart';


class PaymentPage extends StatefulWidget {

  //DATA INHERIT DRPD CHECKOUT PAGE
  final List<Product> cartItems; // ITEM YG ADA KAT CHECKOUT
  final int totalPrice;
  final List<int> quantities;
  final String name; // ISI FORM DH VALIDATA NGAN SAVE KITA BOLEH AMIK DATA DH
  final String phone;
  final String address;
  final String shippingMethod;

  PaymentPage({Key? key, required this.cartItems,
  required this.totalPrice,
  required this.quantities,
  required this.name,
  required this.phone,
  required this.address,
  required this.shippingMethod,}) : super(key: key);



  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> _paykey = GlobalKey<FormState>();

  //final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  var dbHelper;

  String cardNumber = '';
  String expiryDate = '';
  String cvv = '';


  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          title: const Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Payment Success'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(_)=> HomePage(username: widget.name,)), (Route<dynamic>route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int harga = widget.totalPrice;

    //RANDOM TRACKING NUM
    const _chars = '0123456789';
    Random _rnd = Random();
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    String tracknum = 'MY${getRandomString(12)}';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          centerTitle: true,
          title: const Text('\nPayment Process'),
          backgroundColor: Color(0xff4626c5),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text(
                'Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                '${widget.name}',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 10),
              Text(
                'Phone Number',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                '${widget.phone}',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 10),
              Text(
                'Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                '${widget.address}',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 10),
              Text(
                'Shipping Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                '${widget.shippingMethod}',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 10),
              Text(
                'Tracking Number',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                '${tracknum}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color : Colors.grey),
              ),
              SizedBox(height: 20),
              Center(
               child : Column(
                  children: <Widget>[
                    Container(

                      padding: EdgeInsets.all(19),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child : const Text(
                        'Items', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      width: 330.0,
                    ),
                  ],
                ),
              ),



              //DISPLAY BALIK ITEM DLM  final List<Product> cartItems
              SizedBox(height: 3),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final product = widget.cartItems[index];
                  final quantity = widget.quantities[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('Quantity: $quantity'),
                    trailing: Text('RM ${product.price * quantity}'),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.all(8),

                //PAYMENT DETAILS(CARD)
                child: Form(
                  key: _paykey,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Amount:                      RM $harga',
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16.0),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Card Number',
                          ),
                          onChanged: (value) {
                            setState(() {
                              cardNumber = value;
                            });
                          },
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Expiry Date',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    expiryDate = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              flex: 1,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'CVV',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    cvv = value;
                                  });
                                },
                              ),
                            ),
                          ],

                        ),
                        SizedBox(height: 80.0),
                      ],

                    ),
                  ),

                ),
              )
            ],
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding: EdgeInsets.all(165),
        backgroundColor: Color(0xff4626c5),
        onPressed: _showAlertDialog,
        label: const Text("Pay"),
      ),
    );
  }
}
