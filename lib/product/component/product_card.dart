import 'package:flutter/material.dart';
import 'package:cofac_lv2/common/const/colors.dart';
import 'package:cofac_lv2/restaurant/model/restaurant_detail_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel model;

  const ProductCard({
    required this.model,
    super.key,
  });

  // factory ProductCard.fromModel({required ProductModel model}) {
  //   return ProductCard(
  //     model: model,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // if (model == null) return Container();
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              model.imgUrl,
              // Image.asset(
              //   'asset/img/logo/codefactory_logo.png',
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
                  model.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  model.detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: BODY_TEXT_COLOR,
                  ),
                ),
                Text(
                  '₩${model.price}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
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
