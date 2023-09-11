import 'package:hive/hive.dart';
part 'models_model.g.dart';
@HiveType(typeId: 2)
class ModelsModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int created;
  @HiveField(2)
  final String root;

  ModelsModel({
    required this.id,
    required this.root,
    required this.created,
  });

  factory ModelsModel.fromJson(Map<String, dynamic> json) => ModelsModel(
        id: json["id"],
        root: json["root"],
        created: json["created"],
      );

  static List<ModelsModel> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((data) => ModelsModel.fromJson(data)).toList();
  }
}
