import 'category_translation.dart';

class Category {
  final String id;
  final String? parentId;
  final String slug;
  final String? icon;
  final String? imageUrl;
  final bool isActive;
  final int order;
  final List<CategoryTranslation> translations;
  final List<Category>? children;

  Category({
    required this.id,
    this.parentId,
    required this.slug,
    this.icon,
    this.imageUrl,
    this.isActive = true,
    this.order = 0,
    required this.translations,
    this.children,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      parentId: json['parentId'] as String?,
      slug: json['slug'] as String,
      icon: json['icon'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      order: json['order'] as int? ?? 0,
      translations: (json['translations'] as List<dynamic>?)
              ?.map((e) => CategoryTranslation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentId': parentId,
      'slug': slug,
      'icon': icon,
      'imageUrl': imageUrl,
      'isActive': isActive,
      'order': order,
      'translations': translations.map((e) => e.toJson()).toList(),
      'children': children?.map((e) => e.toJson()).toList(),
    };
  }
}
