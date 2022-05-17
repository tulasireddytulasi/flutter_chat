// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sections_model_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectionsModelDBAdapter extends TypeAdapter<SectionsModelDB> {
  @override
  final int typeId = 0;

  @override
  SectionsModelDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SectionsModelDB(
      sectionName: fields[0] as String,
      sectionKey: fields[1] as String,
      versionNumber: fields[2] as String,
      locale: fields[3] as String,
      questionnaires: (fields[4] as List).cast<QuestionnairesModelDB>(),
    );
  }

  @override
  void write(BinaryWriter writer, SectionsModelDB obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.sectionName)
      ..writeByte(1)
      ..write(obj.sectionKey)
      ..writeByte(2)
      ..write(obj.versionNumber)
      ..writeByte(3)
      ..write(obj.locale)
      ..writeByte(4)
      ..write(obj.questionnaires);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionsModelDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
