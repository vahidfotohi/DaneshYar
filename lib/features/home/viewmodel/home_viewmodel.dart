import 'package:daneshyar/features/authentication/user/provider/user_provider.dart';
import 'package:daneshyar/features/mentor/provider/mentor_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../category/provider/category_provider.dart';
import '../../courses/provider/course_provider.dart';
import '../home/home_state.dart';
import '../repository/home_repository.dart';

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

      ref.read(mentorProvider.notifier).initializeData(cleanData.mentors);

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
