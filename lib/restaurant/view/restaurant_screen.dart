import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_delivery/common/const/data.dart';
import 'package:my_delivery/restaurant/component/restaurant_card.dart';
import 'package:my_delivery/restaurant/model/restaurant_model.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    String? accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get('http://$ip/restaurant',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}));

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              // print(snapshot.error);
              // print(snapshot.data);
              if (!snapshot.hasData) {
                return Container();
              }

              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];

                  final pItem = RestaurantModel.fromJson(jSon: item);

                  return RestaurantCard.fromModel(rModel: pItem);

                  // final pItem = RestaurantModel(
                  //   id: item['id'],
                  //   name: item['name'],
                  //   thumbUrl: 'http://$ip${item['thumbUrl']}',
                  //   tags: List<String>.from(item['tags']),
                  //   priceRange: RestaurantPriceRange.values
                  //       .firstWhere((e) => e.name == item['priceRange']),
                  //   // priceRange: item['priceRange'],
                  //   ratings: item['ratings'],
                  //   ratingCount: item['ratingsCount'],
                  //   deliveryTime: item['deliveryTime'],
                  //   deliveryFee: item['deliveryFee'],
                  // );

                  // return RestaurantCard(
                  //   image: Image.network(
                  //     pItem.thumbUrl,
                  //     fit: BoxFit.cover,
                  //   ),
                  //   name: pItem.name,
                  //   tags: pItem.tags,
                  //   ratingsCount: pItem.ratingCount,
                  //   deliveryTime: pItem.deliveryTime,
                  //   deliveryFee: pItem.deliveryFee,
                  //   ratings: pItem.ratings,
                  // );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16.0);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
