// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DreamAdapter extends TypeAdapter<Dream> {
  @override
  final int typeId = 4;

  @override
  Dream read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dream(
      name: fields[0] as String,
      totalExpense: fields[1] as double,
      savings: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Dream obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.totalExpense)
      ..writeByte(2)
      ..write(obj.savings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DreamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
