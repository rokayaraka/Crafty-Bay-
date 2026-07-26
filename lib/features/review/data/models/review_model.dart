import '../../../products/data/models/product_model.dart';

class ReviewModel {
  final String id;

  final ProductModel product;

  final String userName;
  final String comment;

  ReviewModel({
    required this.id,

    required this.userName,
    required this.comment,
    required this.product,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    final user = (json['user'] as Map<String, dynamic>?);

    final firstName = (user?['first_name']).toString();
    final lastName = (user?['last_name']).toString();
    final fullName = '$firstName $lastName'.trim();

    return ReviewModel(
      id: (json['_id']).toString(),
      userName: fullName,
      comment: json['comment'],
      product: ProductModel.fromJson(json['product']),
    );
  }
}
