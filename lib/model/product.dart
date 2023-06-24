

// enumarator mcm instance
enum Category {
  all,
  accessories,
  clothing,
  home,
}

// ni produk punya data declaration
class Product {
  const Product({
    required this.category,
    required this.id,
    required this.isFeatured,
    required this.name,
    required this.price,
    required this.description,

  });

  // data produk yg dh initialize

  final Category category;
  final String description;
  final int id;
  final bool isFeatured;
  final String name;
  final int price ;

  //package gmbr ikut id
  String get assetName => '$id-0.jpg';
  String get assetPackage => 'shrine_images';

  @override
  String toString() => "$name (id=$id)";
}
