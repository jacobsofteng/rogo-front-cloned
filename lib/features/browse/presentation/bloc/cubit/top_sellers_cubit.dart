import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/top_seller.dart';
import '../../../domain/usecases/get_top_sellers_usecase.dart';

part 'top_sellers_state.dart';

class TopSellersCubit extends Cubit<TopSellersState> {
  final GetTopSellersUsecase _getTopSellersUsecase;

  TopSellersCubit({required GetTopSellersUsecase getTopSellersUsecase})
      : _getTopSellersUsecase = getTopSellersUsecase,
        super(TopSellersState());

  void fetchTopSellers() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getTopSellersUsecase(TopSellersParams());
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (topSellers) => emit(state.copyWith(topSellers: topSellers.results)),
    );
  }
}
