import 'package:cofac_lv2/common/dio/dio.dart';
import 'package:cofac_lv2/common/model/cursor_pagination_model.dart';
import 'package:cofac_lv2/common/utils/pagination_utils.dart';
import 'package:cofac_lv2/rating/component/rating_card.dart';
import 'package:cofac_lv2/rating/model/rating_model.dart';
import 'package:cofac_lv2/restaurant/provider/restaurant_provider.dart';
import 'package:cofac_lv2/restaurant/provider/restaurant_rating_provider.dart';
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
import 'package:skeletons/skeletons.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  //final RestaurantModel model;
  final String id;

  const RestaurantDetailScreen({
    required this.id,
    super.key,
  });

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(restaurantProvider.notifier).getRestaurantDetail(id: widget.id);

    controller.addListener(() => PaginationUtils.scrollListener(
          controller: controller,
          provider: ref.read(restaurantRatingProvider(widget.id).notifier),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingsState = ref.watch(restaurantRatingProvider(widget.id));

    if (state == null) {
      return const DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        controller: controller,
        slivers: [
          renderRestaurantCard(model: state),
          if (state is! RestaurantDetailModel) renderSkeleton(),
          if (state is RestaurantDetailModel) renderLabel(),
          if (state is RestaurantDetailModel)
            renderProduct(model: state.products),
          if (ratingsState is CursorPagination<RatingModel>)
            renderRating(
              models: ratingsState.data,
              ratingState: ratingsState,
            ),

          // const RatingCard(
          //   avatarImage: AssetImage('asset/img/logo/codefactory_logo.png'),
          //   email: 'test@codefactory.ai',
          //   images: [],
          //   content:
          //       '존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱존맛탱',
          //   rating: 3,
          // ),
        ],
      ),
    );
  }

  SliverPadding renderRating({
    required List<RatingModel> models,
    required CursorPagination ratingState,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == models.length) {
              return Center(
                child: ratingState.meta.hasMore
                    ? const CircularProgressIndicator()
                    : const Text('End of Ratings'),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RatingCard.fromModel(model: models[index]),
            );
          },
          childCount: models.length + 1,
          // childCount: 1,
        ),
      ),
    );
  }

  SliverPadding renderSkeleton() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          SkeletonParagraph(
            style: const SkeletonParagraphStyle(
              lines: 4,
            ),
          ),
          SkeletonListTile(),
          SkeletonListTile(),
          SkeletonListTile(),
          SkeletonListTile(),
        ]),
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

  SliverToBoxAdapter renderRestaurantCard({required RestaurantModel model}) {
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
