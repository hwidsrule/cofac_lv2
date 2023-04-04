import 'package:cofac_lv2/common/model/model_with_id.dart';
import 'package:cofac_lv2/common/utils/data_utils.dart';
import 'package:cofac_lv2/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId {
  @override
  final String id;
  final RestaurantModel restaurant;
  final String name;
  @JsonKey(fromJson: DataUtils.strToUrl)
  final String imgUrl;
  final String detail;
  final int price;

  ProductModel({
    required this.id,
    required this.restaurant,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
