


enum newCategory {
  category1,
  category2,
  category3,
}

class Products {
  const Products({
    required this.categories,
    required this.newid,
    required this.newisFeatured,
    required this.newname,
    required this.newprice,
    required this.newdescription,
  });

  final newCategory categories;
  final String newdescription;
  final int newid;
  final bool newisFeatured;
  final String newname;
  final int newprice ;

  String get assetName => '$newid-0.jpg';
  String get assetPackage => 'shrine_images';

  @override
  String toString() => "$newname (id=$newid)";
}
