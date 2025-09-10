enum Suggested{
  none,
  bestseller,
  suggested,
}
class CourseModel {
  final String id;
  final String cover;
  final String? star;
  final bool isMarked;
  final String title;
  final Suggested suggested ;
  final String mentorName;
  final String price;
  final String? offerPrice;

  CourseModel({
    required this.id,
    required this.cover,
    required this.isMarked,
    required this.title,
    required this.suggested,
    required this.mentorName,
    required this.price,
    this.star,
    this.offerPrice,
  });
}
