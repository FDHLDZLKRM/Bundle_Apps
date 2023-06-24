
import 'package:flutter/material.dart';
import 'package:shrine/model/product.dart';


class ProductDetailsPage extends StatelessWidget {
  final Product product;


  ProductDetailsPage({required this.product,});

  @override
  Widget build(BuildContext context) {
    final imageWidget = Image.asset(
      product.assetName,
      package: product.assetPackage,
      fit: BoxFit.cover,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: imageWidget,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Price: RM ${product.price}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Category: ${product.category}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Size : ',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Description: \n${product.description}',
            ),
          ),
          SizedBox(
            height: 30,
          ),
         FloatingActionButton.extended(
             onPressed: ()  {/*...*/}, extendedPadding: const EdgeInsets.all(149),
    backgroundColor: Colors.indigo, label: const Text("Add to Cart"),)

          // Add more details or components as needed
        ],
      ),

    );
  }
}