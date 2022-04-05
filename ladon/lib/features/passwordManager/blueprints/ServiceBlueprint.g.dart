// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ServiceBlueprint.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceBlueprintAdapter extends TypeAdapter<ServiceBlueprint> {
  @override
  final int typeId = 0;

  @override
  ServiceBlueprint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceBlueprint(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceBlueprint obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.password)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.twoFASecret)
      ..writeByte(4)
      ..write(obj.logoUrl)
      ..writeByte(5)
      ..write(obj.domain)
      ..writeByte(6)
      ..write(obj.app);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceBlueprintAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
