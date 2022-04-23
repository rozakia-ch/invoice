// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaxModelAdapter extends TypeAdapter<TaxModel> {
  @override
  final int typeId = 4;

  @override
  TaxModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaxModel(
      tax: fields[0] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TaxModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.tax);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaxModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
