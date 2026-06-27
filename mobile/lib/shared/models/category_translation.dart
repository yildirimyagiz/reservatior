// lib/shared/models/category_translation.dart
class CategoryTranslation {
  final String id;
  final String categoryId;
  final String languageCode;
  final String name;
  final String? description;

  CategoryTranslation({
    required this.id,
    required this.categoryId,
    required this.languageCode,
    required this.name,
    this.description,
  });

  factory CategoryTranslation.fromJson(Map<String, dynamic> json) {
    return CategoryTranslation(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      languageCode: json['languageCode'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'languageCode': languageCode,
      'name': name,
      'description': description,
    };
  }
}
