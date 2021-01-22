import 'dart:convert';
import 'dart:typed_data';

class ByteDecoder {
  int pointer = 0;
  Uint8List bytes;

  ByteDecoder(this.bytes);

  int readInt() {
    return bytes.sublist(pointer, pointer += 4).buffer.asByteData().getInt32(0, Endian.little);
  }

  int readInt8() {
    return bytes.sublist(pointer, pointer += 1).buffer.asByteData().getInt8(0);
  }

  bool readBool() {
    return readInt8() > 0;
  }

  int readInt16() {
    return bytes.sublist(pointer, pointer += 2).buffer.asByteData().getInt16(0, Endian.little);
  }

  String readString(int length) {
    //  String.fromCharCodes(bytes.sublist(pointer, pointer += length));
    return utf8.decode(bytes.sublist(pointer, pointer += length));
  }

  Uint8List readRaw(int length) {
    return bytes.sublist(pointer, pointer += length);
  }

  String readHex(int length) {
    return bytes.sublist(pointer, pointer += length).map((b) => '${b.toRadixString(16).padLeft(2, '0')}').join();
  }

  DateTime readDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(readInt() * 1000);
  }
}

class ByteEncoder {
  Uint8List bytes = Uint8List(0);

  writeString(String string, int length) {
    final code = string.codeUnits;
    final offset = length - code.length;
    final stringList = List.generate(length, (index) => index < offset ? 0 : code[index - offset]);
    writeRaw(Uint8List.fromList(stringList));
  }

  writeRaw(Uint8List value) {
    bytes = Uint8List.fromList(bytes + value);
  }

  writeInt(int number) {
    writeRaw(Uint8List(4)..buffer.asByteData().setInt32(0, number, Endian.little));
  }

  writeInt8(int number) {
    writeRaw(Uint8List.fromList([number]));
  }

  writeTimestamp([DateTime time]) {
    writeInt(((time ?? DateTime.now()).millisecondsSinceEpoch / 1000).round());
  }

  writeBool(bool value) {
    writeInt8(value ? 1 : 0);
  }

  writeSign() {
    writeString("", 64);
  }
}
