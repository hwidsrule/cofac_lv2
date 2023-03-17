import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_delivery/common/const/data.dart';
import 'package:my_delivery/common/layout/default_layout.dart';
import 'package:my_delivery/product/component/product_card.dart';
import 'package:my_delivery/restaurant/component/restaurant_card.dart';
import 'package:my_delivery/restaurant/model/restaurant_detail_model.dart';
import 'package:my_delivery/restaurant/model/restaurant_model.dart';

class RestaurantDetailScreen extends StatelessWidget {
  //final RestaurantModel model;
  final String id;
  const RestaurantDetailScreen({
    required this.id,
    super.key,
  });

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get(
      'http://$ip/restaurant/${id}',
      options: Options(
        headers: {'authorization': 'Bearer $accessToken'},
      ),
    );

    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: FutureBuilder<Map<String, dynamic>>(
        future: getRestaurantDetail(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          // final restaurantDetailModel = RestaurantDetailModel.fromJson(snapshot.data);

          // print(snapshot.data);

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final item = RestaurantDetailModel.fromJson(jSon: snapshot.data!);

          return CustomScrollView(
            slivers: [
              renderRestaurantCard(model: item),
              renderLabel(),
              renderProduct(model: item.products),
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
