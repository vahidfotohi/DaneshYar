class CategoryResponse {
  final bool status;
  final List<Data> data;
  final dynamic errorCode;
  final dynamic errorMessage;

  CategoryResponse({
    required this.status,
    required this.data,
     this.errorCode,
     this.errorMessage,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    var dataItems = <Data>[];
    if (json['data'] != null && json['data'] is List) {
    var dataList = json['data'] as List;
    dataItems = dataList.map((item) => Data.fromJson(item)).toList();
    }

    return CategoryResponse(
      status: json['status'] ?? false,
      data: dataItems,
      errorCode: json['error_code'],
      errorMessage: json['error_message'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((item) => item.toJson()).toList(),
      'error_code': errorCode,
      'error_message': errorMessage,
    };
  }

}

class Data {
  final String id;
  final String title;
  final String icon;

  Data({
    required this.id,
    required this.title,
    required this.icon,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
    };
  }
}