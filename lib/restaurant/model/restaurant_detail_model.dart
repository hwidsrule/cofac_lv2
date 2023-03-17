import 'package:my_delivery/common/const/data.dart';
import 'package:my_delivery/restaurant/model/restaurant_model.dart';

class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<ProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson({required Map<String, dynamic> jSon}) {
    return RestaurantDetailModel(
      id: jSon['id'],
      name: jSon['name'],
      thumbUrl: 'http://$ip${jSon['thumbUrl']}',
      tags: List<String>.from(jSon['tags']),
      priceRange: RestaurantPriceRange.values
          .firstWhere((e) => e.name == jSon['priceRange']),
      // priceRange: item['priceRange'],
      ratings: jSon['ratings'],
      ratingCount: jSon['ratingsCount'],
      deliveryTime: jSon['deliveryTime'],
      deliveryFee: jSon['deliveryFee'],
      detail: jSon['detail'],
      products: jSon['products']
          .map<ProductModel>((x) => ProductModel.fromJson(jSon: x))
          .toList(),
      // products: makeProductList(jSon['product']),
    );
  }
}

// List<ProductModel> makeProductList(Map<String, dynamic> jSon) {
//   final List<ProductModel> result = [];

//   for (int i = 0; i < jSon.length; i++) {
//     result[i] = ProductModel.fromJson(jSon: jSon[i]);
//   }
//   return result;
// }

class ProductModel {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  ProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory ProductModel.fromJson({required Map<String, dynamic> jSon}) {
    return ProductModel(
      id: jSon['id'],
      name: jSon['name'],
      imgUrl: 'http://$ip${jSon['imgUrl']}',
      detail: jSon['detail'],
      price: jSon['price'],
    );
  }
}
