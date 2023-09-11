// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_group_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatGroupModelAdapter extends TypeAdapter<ChatGroupModel> {
  @override
  final int typeId = 1;

  @override
  ChatGroupModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatGroupModel(
      id: fields[0] as String,
      chatList: (fields[1] as List).cast<ChatModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChatGroupModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.chatList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatGroupModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
