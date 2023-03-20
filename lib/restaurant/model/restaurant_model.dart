import 'package:cofac_lv2/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';
// import 'package:cofac_lv2/common/const/data.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  @JsonKey(fromJson: DataUtils.strToUrl)
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  // @JsonKey(fromJson: strToInt)
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  // static int strToInt(String value) {
  //   return int.parse(value);
  // }

  // factory RestaurantModel.fromJson({required Map<String, dynamic> jSon}) {
  //   return RestaurantModel(
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
  //   );
  // }
}
