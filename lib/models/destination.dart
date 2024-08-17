//destination
class Destination{
  String id;
  String name;
  Destination({required this.id,required this.name});

  static Destination fromJson(Map<String,dynamic> data) {
    return Destination(
      id: data['id'],
      name: data['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}