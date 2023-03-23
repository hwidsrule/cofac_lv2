import 'package:cofac_lv2/common/dio/dio.dart';
import 'package:cofac_lv2/restaurant/repository/restaurant_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cofac_lv2/common/const/data.dart';
import 'package:cofac_lv2/common/layout/default_layout.dart';
import 'package:cofac_lv2/product/component/product_card.dart';
import 'package:cofac_lv2/restaurant/component/restaurant_card.dart';
import 'package:cofac_lv2/restaurant/model/restaurant_detail_model.dart';
import 'package:cofac_lv2/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  //final RestaurantModel model;
  final String id;

  const RestaurantDetailScreen({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: FutureBuilder<RestaurantDetailModel>(
        future:
            ref.watch(restaurantRepositoryProvider).getRestaurantDetail(id: id),
        builder: (context, AsyncSnapshot<RestaurantDetailModel> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return CustomScrollView(
            slivers: [
              // renderRestaurantCard(model: item),
              renderRestaurantCard(model: snapshot.data!),
              renderLabel(),
              renderProduct(model: snapshot.data!.products),
            ],
          );
        },
      ),
    );
  }

  SliverToBoxAdapter renderLabel() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverPadding renderProduct({required List<ProductModel> model}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard(model: model[index]),
            );
          },
          childCount: model.length,
        ),
      ),
    );
  }

  SliverToBoxAdapter renderRestaurantCard(
      {required RestaurantDetailModel model}) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          RestaurantCard.fromModel(
            model: model,
            isDetail: true,
            //detail: model.detail,
          ),
        ],
      ),
    );
  }
}
