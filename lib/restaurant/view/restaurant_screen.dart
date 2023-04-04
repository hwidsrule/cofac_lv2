import 'package:cofac_lv2/common/component/pagination_list_view.dart';
import 'package:cofac_lv2/restaurant/model/restaurant_model.dart';
import 'package:cofac_lv2/restaurant/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:cofac_lv2/restaurant/component/restaurant_card.dart';
import 'package:cofac_lv2/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<RestaurantModel>(
      provider: restaurantProvider,
      builder: <RestaurantModel>(context, index, model) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RestaurantDetailScreen(id: model.id),
              ),
            );
          },
          child: RestaurantCard.fromModel(model: model),
        );
      },
    );
  }
}
