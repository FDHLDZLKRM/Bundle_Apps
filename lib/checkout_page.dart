import 'package:flutter/material.dart';
import 'package:shrine/model/product.dart';
import 'package:shrine/payment_page.dart';

class CheckoutPage extends StatefulWidget {
  final List<Product> cartItems; // LIST YG ADA DALAM CART
  final int totalPrice;   // TOTAL YG RETRUN DARI CART PAGE
  final List<int> quantities; //

  CheckoutPage({
    required this.cartItems,
    required this.totalPrice,
    required this.quantities,
  });

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();

  //RADIO BUTTON PUNYA VALUE DEFAULT
  String _selectedShippingMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        backgroundColor: const Color(0xff4626c5),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10,),
              Container(

                padding: EdgeInsets.all(19),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child : const Text(
                  'Cart Summary', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final product = widget.cartItems[index];
                  final quantity = widget.quantities[index];
                  return ListTile(
                    leading: Image.asset(
                      product.assetName,
                      package: product.assetPackage,
                      width: 50,
                      height: 100,
                    ),
                    title: Text(product.name),
                    subtitle: Text('Price: RM ${product.price}'),
                    trailing: Text('Quantity: $quantity'),
                  );
                },
              ),
              Divider(
                thickness: 2, indent: 5, endIndent: 5, color: Colors.black38,
              ),
              const SizedBox(height: 9),
              Text(
                'Total Price:' + '                                     RM ${widget.totalPrice}.00',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Divider(
                thickness: 2, indent: 5, endIndent: 5, color: Colors.black38,
              ),
              const SizedBox(height: 20),
              Container(

                padding: EdgeInsets.all(19),
                decoration: BoxDecoration(
                    color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
                child : const Text(
                  'Customer Information', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              const SizedBox(height: 10),
              // FORM UTK ISI DETAIL PEMBELI
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller : _name,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),

                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller : _phone,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'phone',
                      ),


                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _address,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                      ),

                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(

                padding: EdgeInsets.all(19),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child : const Text(
                  'Shipping Method', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              const SizedBox(height: 10),
              //RADIO BUTTON UTK SHIPPING METHOD
              Column(
                children: [
                  ListTile(
                    title: const Text('Standard Shipping'),
                    leading: Radio(
                      value: 'Standard Shipping',
                      groupValue: _selectedShippingMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedShippingMethod = value.toString();
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Express Shipping'),
                    leading: Radio(
                      value: 'Express Shipping',
                      groupValue: _selectedShippingMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedShippingMethod = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(

                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          cartItems: widget.cartItems,
                          totalPrice: widget.totalPrice,
                          quantities: widget.quantities,
                          name: _name.text,
                          phone: _phone.text,
                          address: _address.text,
                          shippingMethod: _selectedShippingMethod,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff4626c5), // Background color
                ),
                child: const Text('Place Order'),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
