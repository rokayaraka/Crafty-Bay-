import '../../../auth/data/models/user_model.dart';
import '../../../shared/presentation/widgets/product_model.dart';

class ReviewModel {
  final String id;
  final ProductModel product;
  final UserModel user;
  final double rating;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReviewModel({
    required this.id,
    required this.product,
    required this.user,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'] ,
      product:  ProductModel.fromJson(json['product']) ,
      user: UserModel.fromJson(json['user']),
      rating: json['rating'],
      comment: json['comment'] ,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}