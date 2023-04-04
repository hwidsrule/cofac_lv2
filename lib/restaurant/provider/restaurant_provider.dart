import 'package:cofac_lv2/common/model/cursor_pagination_model.dart';
import 'package:cofac_lv2/common/model/pagination_params.dart';
import 'package:cofac_lv2/common/provider/pagination_provider.dart';
import 'package:cofac_lv2/restaurant/model/restaurant_model.dart';
import 'package:cofac_lv2/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final restaurantDetailProvider = StateProvider.family<RestaurantModel?, String>(
  (ref, id) {
    final state = ref.watch(restaurantProvider);

    if (state is! CursorPagination) {
      return null;
    } else {
      return state.data.firstWhereOrNull((element) => element.id == id);
    }
  },
);

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final restaurantStateNotifier =
        RestaurantStateNotifier(repository: repository);

    return restaurantStateNotifier;
  },
);

class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  RestaurantStateNotifier({
    required super.repository,
  });

  void getRestaurantDetail({
    required String id,
  }) async {
    if (state is! CursorPagination) {
      await paginate();
    }
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;

    final detail = await repository.getRestaurantDetail(id: id);

    if (pState.data.where((element) => element.id == id).isEmpty) {
      state = pState.copyWith(
        data: <RestaurantModel>[
          ...pState.data,
          detail,
        ],
      );
    } else {
      state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>((e) => e.id == id ? detail : e)
            .toList(),
      );
    }
  }
}
