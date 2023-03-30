import 'package:cofac_lv2/common/model/cursor_pagination_model.dart';
import 'package:cofac_lv2/common/utils/pagination_utils.dart';
import 'package:cofac_lv2/restaurant/provider/restaurant_provider.dart';
import 'package:cofac_lv2/restaurant/provider/restaurant_rating_provider.dart';
import 'package:cofac_lv2/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:cofac_lv2/restaurant/component/restaurant_card.dart';
import 'package:cofac_lv2/restaurant/model/restaurant_model.dart';
import 'package:cofac_lv2/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // controller.addListener(scrollListener);
    controller.addListener(() => PaginationUtils.scrollListener(
          controller: controller,
          provider: ref.read(restaurantProvider.notifier),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();

    super.dispose();
  }

  // void scrollListener() {
  //   if (controller.offset > controller.position.maxScrollExtent - 300) {
  //     ref.read(restaurantProvider.notifier).paginate(fetchMore: true);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    if (data is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.err),
      );
    }

    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: controller,
        itemCount: cp.data.length + 1,
        itemBuilder: (context, index) {
          if (index == cp.data.length) {
            return Center(
              child: cp.meta.hasMore
                  ? const CircularProgressIndicator()
                  : const Text('No More Data'),
            );
          }

          final item = cp.data[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RestaurantDetailScreen(id: item.id),
                ),
              );
            },
            child: RestaurantCard.fromModel(model: item),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
