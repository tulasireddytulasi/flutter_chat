// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnaires_model_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionnairesModelDBAdapter extends TypeAdapter<QuestionnairesModelDB> {
  @override
  final int typeId = 1;

  @override
  QuestionnairesModelDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionnairesModelDB(
      question_id: fields[0] as String,
      question: fields[1] as String,
      options: (fields[2] as List).cast<String>(),
      option_key: (fields[3] as List).cast<String>(),
      type: fields[4] as String,
      next_question_id: (fields[5] as List).cast<String>(),
      last_question: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionnairesModelDB obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.question_id)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.options)
      ..writeByte(3)
      ..write(obj.option_key)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.next_question_id)
      ..writeByte(6)
      ..write(obj.last_question);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionnairesModelDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
