class Unit{
  String id;
  String name;
  Unit({required this.id,required this.name});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}