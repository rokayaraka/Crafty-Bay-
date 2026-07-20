//  {
//               "_id": "67ae27f8149a96f2acf9acc9",
//               "title": "dfsd Category",
//               "slug": "newdddddd-cas",
//               "description": "cat description",
//               "icon": "https://hudaenu.xyz/wp-content/uploads/2024/07/Group-991.png",
//               "parent": null,
//               "createdAt": "2025-02-13T17:12:24.671Z",
//               "updatedAt": "2025-02-13T17:12:24.671Z",
//               "__v": 0
//           },

class CategoryModel {
  String id;
  String title;
  String icon;

  CategoryModel({required this.id, required this.title, required this.icon});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'],
      title: json['title'],
      icon: json['icon'],
    );
  }
}
