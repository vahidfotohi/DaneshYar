import 'package:daneshyar/features/authentication/user/provider/user_provider.dart';
import 'package:daneshyar/features/home/category/provider/category_provider.dart';
import 'package:daneshyar/features/home/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../courses/provider/course_provider.dart';
import '../state/home_state.dart';

class HomeViewmodel extends StateNotifier<HomeState> {
  final HomeRepository _homeRepository;
  final Ref ref;

  HomeViewmodel(this._homeRepository, this.ref) : super(HomeState.initial());

  Future<void> fetchHomeData() async {
    state = state.copyWith(isLoading: true);

    try {
      final cleanData = await _homeRepository.getHomeData();
      ref.read(userProvider.notifier).setUser(cleanData.user);

      ref.read(categoryProvider.notifier).state = ref
          .read(categoryProvider)
          .copyWith(categories: cleanData.categories, isLoading: false);

      ref.read(courseProvider.notifier).state = ref
          .read(courseProvider)
          .copyWith(courses: cleanData.courses, isLoading: false);

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
