// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelsModelAdapter extends TypeAdapter<ModelsModel> {
  @override
  final int typeId = 2;

  @override
  ModelsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelsModel(
      id: fields[0] as String,
      root: fields[2] as String,
      created: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ModelsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.root);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
