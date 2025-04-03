// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCharacterAdapter extends TypeAdapter<HiveCharacter> {
  @override
  final int typeId = 0;

  @override
  HiveCharacter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCharacter(
      id: fields[0] as int,
      name: fields[1] as String,
      gender: fields[2] as String,
      status: fields[3] as String,
      image: fields[4] as String,
      isFavorite: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCharacter obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
