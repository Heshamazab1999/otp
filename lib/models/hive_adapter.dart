import 'package:hive/hive.dart';
import 'package:otp/models/hive_model.dart';

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      name: fields[0],
      key: fields[1]  ,
    );
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ProductAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..write(2)
      ..write(0)
      ..write(obj.name)
      ..write(1)
      ..write(obj.key);

    // TODO: implement write
  }
}
