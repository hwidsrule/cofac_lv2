import 'package:cofac_lv2/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:cofac_lv2/common/const/colors.dart';
import 'package:cofac_lv2/restaurant/model/restaurant_detail_model.dart';

class ProductCard extends StatelessWidget {
  // final RestaurantProductModel model;
  final String imgUrl;
  final String name;
  final String detail;
  final int price;

  const ProductCard({
    required this.imgUrl,
    required this.name,
    required this.detail,
    required this.price,
    super.key,
  });

  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel model,
  }) {
    return ProductCard(
      imgUrl: model.imgUrl,
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  factory ProductCard.fromProductModel({
    required ProductModel model,
  }) {
    return ProductCard(
      imgUrl: model.imgUrl,
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imgUrl,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: BODY_TEXT_COLOR,
                  ),
                ),
                Text(
                  '₩$price',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
