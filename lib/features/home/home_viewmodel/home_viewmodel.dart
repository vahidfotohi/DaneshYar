import 'package:daneshyar/features/authentication/user/provider/user_provider.dart';
import 'package:daneshyar/features/home/category/provider/category_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../courses/provider/course_provider.dart';
import '../home_repository/home_repository.dart';
import '../home_state/home_state.dart';

class HomeViewmodel extends StateNotifier<HomeState> {
  final HomeRepository _homeRepository;
  final Ref ref;

  HomeViewmodel(this._homeRepository, this.ref) : super(HomeState.initial());

  Future<void> fetchHomeData() async {
    state = state.copyWith(isLoading: true);

    try {
      final cleanData = await _homeRepository.getHomeData();
      ref.read(userProvider.notifier).setUser(cleanData.user);

      ref.read(categoryProvider.notifier).initializeData(cleanData.categories);

      ref.read(courseProvider.notifier).initializeData(cleanData.courses);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }
}
