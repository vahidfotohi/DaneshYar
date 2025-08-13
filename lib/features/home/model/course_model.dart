enum Suggested{
  bestseller,
  suggested,
}
class CourseModel {
  final String id;
  final String imagePath;
  final String? star;
  final bool isMarked;
  final String title;
  final Suggested suggested ;
  final String mentorName;
  final String price;
  final String? offerPrice;

  CourseModel({
    required this.id,
    required this.imagePath,
    required this.isMarked,
    required this.title,
    required this.suggested,
    required this.mentorName,
    required this.price,
    this.star,
    this.offerPrice,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      imagePath: json['imagePath'],
      star: json['star'],
      isMarked: json['isMarked'],
      title: json['title'],
      suggested: json['suggested'],
      mentorName: json['mentorName'],
      price: json['price'],
      offerPrice: json['offerPrice'],
    );
  }
}
