import 'package:daneshyar/features/home/model/category_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryViewmodel extends StateNotifier<List<CategoryModel>> {
  CategoryViewmodel() : super([]);

  Future<void> fetchCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));

    ///Todo Call api

    state = [
      CategoryModel(
        id: "1",
        title: "برنامه نویسی",
        imageUrl: "assets/images/home/categories/programing.svg",
      ),
      CategoryModel(
        id: "1",
        title: "گرافیک",
        imageUrl: "assets/images/home/categories/graphic.svg",
      ),
      CategoryModel(
        id: "1",
        title: "مارکتینگ",
        imageUrl: "assets/images/home/categories/marketing.svg",
      ),
      CategoryModel(
        id: "1",
        title: " کریپتو",
        imageUrl: "assets/images/home/categories/crypto.svg",
      ),
      CategoryModel(
        id: "1",
        title: "بازار مالی",
        imageUrl: "assets/images/home/categories/financial.svg",
      ),
      CategoryModel(
        id: "1",
        title: "نویسندگی",
        imageUrl: "assets/images/home/categories/writing.svg",
      ),
      CategoryModel(
        id: "1",
        title: "موسیقی",
        imageUrl: "assets/images/home/categories/musician.svg",
      ),
      CategoryModel(
        id: "1",
        title: "عکاسی",
        imageUrl: "assets/images/home/categories/photoGrapher.svg",
      ),
      CategoryModel(
        id: "1",
        title: "تدوین",
        imageUrl: "assets/images/home/categories/editing.svg",
      ),
      CategoryModel(
        id: "1",
        title: "فروش",
        imageUrl: "assets/images/home/categories/selling.svg",
      ),
      CategoryModel(
        id: "1",
        title: "طراحی لباس",
        imageUrl: "assets/images/home/categories/dressDesign.svg",
      ),
      CategoryModel(
        id: "1",
        title: "زبان",
        imageUrl: "assets/images/home/categories/trainLanguage.svg",
      ),
    ].toList();
  }
}
