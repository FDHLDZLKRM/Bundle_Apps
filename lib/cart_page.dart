import 'package:flutter/material.dart';
import 'package:shrine/checkout_page.dart';
import 'package:shrine/model/product.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartItems;


  CartPage({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int> quantities = []; // UTK TAMBAH AND TOLAK SECARA DYNAMICALLY
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    // Initialize quantities list with initial quantities from the cartItems
    quantities = List<int>.filled(widget.cartItems.length, 1);
    totalPrice = calculateTotalPrice();
  }

  void removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
      totalPrice = calculateTotalPrice();

    });
  }

  void increaseQuantity(int index) {
    setState(() {
      quantities[index]++;
      totalPrice += widget.cartItems[index].price; // Update the total price after increasing the quantity
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (quantities[index] > 1) {
        quantities[index]--;
        totalPrice -= widget.cartItems[index].price; // Update the total price after decreasing the quantity
      }
    });
  }

  int calculateTotalPrice() {
    for (int i = 0; i < widget.cartItems.length; i++) {
      final product = widget.cartItems[i];
      final quantity = quantities[i];
      totalPrice += product.price * quantity;
    }
    return totalPrice;

  }

  void checkout(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Checkout'),
          content: Text('Total Price: RM $totalPrice'),
          actions: [
            TextButton(
              onPressed: () {
                // TODO: Perform further checkout actions (e.g., payment processing, clearing the cart, etc.)
                Navigator.push(context,MaterialPageRoute(builder: (_) => CheckoutPage(totalPrice: totalPrice, cartItems: widget.cartItems, quantities: quantities,))); // Close the dialog
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Trolley', textAlign: TextAlign.center,),
        backgroundColor: const Color(0xff4626c5),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final product = widget.cartItems[index];
                final quantity = quantities[index];
                return ListTile(
                  leading: Image.asset(
                    product.assetName,
                    package: product.assetPackage,
                    width: 50,
                    height: 100,
                  ),
                  title: Text(product.name),
                  subtitle: Text('Price: RM ${product.price}'),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.orange,),
                        onPressed: () {
                          decreaseQuantity(index);
                        },
                      ),

                      Text(quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add_circle, color: Colors.orange,),
                        onPressed: () {
                          increaseQuantity(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_rounded,color: Colors.red,),
                        onPressed: () {
                          removeItem(index);
                        },
                      ),
                    ],
                  ),
                );

              }, separatorBuilder: (BuildContext context, int index) {
              return Divider(thickness: 1, color: Colors.black38,);
            },
            ),

          ),


          Text(
            'Total Price: RM $totalPrice',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          FloatingActionButton.extended(
            onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Checkout'),
                    content: Text('Total Price: RM $totalPrice'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // TODO: Perform further checkout actions (e.g., payment processing, clearing the cart, etc.)
                          Navigator.push(context,MaterialPageRoute(builder: (_) => CheckoutPage(totalPrice: totalPrice, cartItems:widget.cartItems , quantities: quantities,))); // Close the dialog
                        },
                        child: Text('Confirm'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            },
            extendedPadding: const EdgeInsets.all(150),
            backgroundColor: Color(0xff4626c5),
            label: const Text("Checkout"),
          ),
          SizedBox(height: 25,),
        ],
      ),
    );
  }
}
