// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanned_product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScannedProductAdapter extends TypeAdapter<ScannedProduct> {
  @override
  final int typeId = 0;

  @override
  ScannedProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScannedProduct(
      name: fields[0] as String,
      expiryDate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ScannedProduct obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.expiryDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScannedProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
