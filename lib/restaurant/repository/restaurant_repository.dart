import 'package:cofac_lv2/common/const/data.dart';
import 'package:cofac_lv2/common/dio/dio.dart';
import 'package:cofac_lv2/common/model/cursor_pagination_model.dart';
import 'package:cofac_lv2/common/model/pagination_params.dart';
import 'package:cofac_lv2/restaurant/model/restaurant_detail_model.dart';
import 'package:cofac_lv2/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final restaurantRepository =
        RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

    return restaurantRepository;
  },
);

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
    // 'Authorization':
    //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNjc5MzA4OTk5LCJleHAiOjE2NzkzMDkyOTl9.PpCeHtc3AjDxJodmZHsPLfX4dWESorX5rMDUL1iXe3w',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
