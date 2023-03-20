import 'package:cofac_lv2/common/const/data.dart';
import 'package:cofac_lv2/common/utils/data_utils.dart';
import 'package:cofac_lv2/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_detail_model.g.dart';

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<ProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    //@JsonKey(fromJson: DataUtils.strToUrl)
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailModelFromJson(json);

  // factory RestaurantDetailModel.fromJson({required Map<String, dynamic> jSon}) {
  //   return RestaurantDetailModel(
  //     id: jSon['id'],
  //     name: jSon['name'],
  //     thumbUrl: 'http://$ip${jSon['thumbUrl']}',
  //     tags: List<String>.from(jSon['tags']),
  //     priceRange: RestaurantPriceRange.values
  //         .firstWhere((e) => e.name == jSon['priceRange']),
  //     // priceRange: item['priceRange'],
  //     ratings: jSon['ratings'],
  //     ratingCount: jSon['ratingsCount'],
  //     deliveryTime: jSon['deliveryTime'],
  //     deliveryFee: jSon['deliveryFee'],
  //     detail: jSon['detail'],
  //     products: jSon['products']
  //         .map<ProductModel>((x) => ProductModel.fromJson(jSon: x))
  //         .toList(),
  //     // products: makeProductList(jSon['product']),
  //   );
  // }
}

// List<ProductModel> makeProductList(Map<String, dynamic> jSon) {
//   final List<ProductModel> result = [];

//   for (int i = 0; i < jSon.length; i++) {
//     result[i] = ProductModel.fromJson(jSon: jSon[i]);
//   }
//   return result;
// }

@JsonSerializable()
class ProductModel {
  final String id;
  final String name;
  @JsonKey(fromJson: DataUtils.strToUrl)
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

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  // factory ProductModel.fromJson({required Map<String, dynamic> jSon}) {
  //   return ProductModel(
  //     id: jSon['id'],
  //     name: jSon['name'],
  //     imgUrl: 'http://$ip${jSon['imgUrl']}',
  //     detail: jSon['detail'],
  //     price: jSon['price'],
  //   );
  // }
}
