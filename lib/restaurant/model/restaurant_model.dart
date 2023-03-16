import 'package:my_delivery/common/const/data.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

class RestaurantModel {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestaurantModel.fromJson({required Map<String, dynamic> jSon}) {
    return RestaurantModel(
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
    );
  }
}
