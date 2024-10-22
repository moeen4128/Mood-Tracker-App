// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_emoji.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodEmojiAdapter extends TypeAdapter<MoodEmoji> {
  @override
  final int typeId = 0;

  @override
  MoodEmoji read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoodEmoji(
      moodEmoji: fields[1] as String,
      moodTitle: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MoodEmoji obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.moodTitle)
      ..writeByte(1)
      ..write(obj.moodEmoji);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodEmojiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
