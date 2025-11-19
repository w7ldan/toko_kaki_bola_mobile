// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
    String name;
    String description;
    int price;
    String category;
    String thumbnail;
    DateTime createdAt;
    bool isFeatured;
    String username;

    ProductEntry({
        required this.name,
        required this.description,
        required this.price,
        required this.category,
        required this.thumbnail,
        required this.createdAt,
        required this.isFeatured,
        required this.username,
    });

    factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        name: json["name"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        createdAt: DateTime.parse(json["created_at"]),
        isFeatured: json["is_featured"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "price": price,
        "category": category,
        "thumbnail": thumbnail,
        "created_at": createdAt.toIso8601String(),
        "is_featured": isFeatured,
        "username": username,
    };
}
