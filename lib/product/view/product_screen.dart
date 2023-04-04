import 'package:cofac_lv2/common/component/pagination_list_view.dart';
import 'package:cofac_lv2/product/component/product_card.dart';
import 'package:cofac_lv2/product/model/product_model.dart';
import 'package:cofac_lv2/product/provider/product_provider.dart';
import 'package:cofac_lv2/product/repository/product_repository.dart';
import 'package:cofac_lv2/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      builder: <ProductModel>(context, index, model) {
        return GestureDetector(
          child: ProductCard.fromProductModel(model: model),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    RestaurantDetailScreen(id: model.restaurant.id)));
          },
        );
      },
    );
  }
}
