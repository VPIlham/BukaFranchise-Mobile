class Brand {
  final int? id;
  final String? name;
  final String? description;
  final int? totalEmployees;
  final String? startOperation;
  final String? category;
  final String? image;

  Brand({
    required this.id,
    required this.name,
    required this.description,
    this.totalEmployees,
    this.startOperation,
    this.category,
    this.image,
  });

  Brand copyWith({
    int? id,
    String? name,
    String? description,
    int? totalEmployees,
    String? startOperation,
    String? category,
    String? image,
  }) {
    return Brand(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      totalEmployees: totalEmployees ?? this.totalEmployees,
      startOperation: startOperation ?? this.startOperation,
      category: category ?? this.category,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'Brand(id: $id, name: $name, description: $description, totalEmployees: $totalEmployees, startOperation: $startOperation, category: $category, image: $image)';
  }
}
