import '../../../../core/configs/constants/api.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/services/api_service.dart';
import '../../domain/entities/paginated_wishlists_feed.dart';
import '../models/paginated_wishlists_feed_model.dart';

abstract class WishlistsFeedDataSource {
  Future<PaginatedWishlistsFeed> getWishlistsFeed({
    int? page,
    int? limit,
  });
}

class WishlistsFeedDataSourceImpl implements WishlistsFeedDataSource {
  final ApiService _client;

  WishlistsFeedDataSourceImpl({required ApiService client}) : _client = client;

  @override
  Future<PaginatedWishlistsFeed> getWishlistsFeed({int? page, int? limit}) async {
    // final jwt = sl<BoxService>().appSettings.get('jwt');
    try {
      final result = await _client.get(
        k_API_END_POINT_PUBLICATION,
      );
      print(result.data);
      return PaginatedWishlistsFeedModel.fromMap(result.data);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
