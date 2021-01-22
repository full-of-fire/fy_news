import 'dart:typed_data';

import 'package:dart_des/dart_des.dart';

class Crypto {
  static List<int> encrypt(List<int> message, List<int> key) {
    message = fillBlank(message);
    return DES3(key: key, mode: DESMode.ECB).encrypt(message.reversedByChunk()).reversedByChunk();
  }

  static List<int> decrypt(List<int> message, List<int> key) {
    return DES3(key: key, mode: DESMode.ECB).decrypt(message.reversedByChunk()).reversedByChunk();
  }

  static int crc(List<int> data) => data.reduce((value, element) => value + element) % 0x100;

  static bool crcCheck(List<int> data, int check) => crc(data) == check;

  static List<int> fillBlank(Uint8List data, [int size = 8]) {
    final length = ((data.length + 1) / size).ceil() * size;
    return [data.length] + data.toList() + List.filled(length - data.length - 1, 0);
  }
}

extension ListFunctionalExt<T> on List<T> {
  /// 按 size 分组
  Iterable<List<T>> chunk(int size) {
    List<List<T>> chunks = [];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  /// 硬件端解密时读取数据采用 int64 小端格式，要求客户端发送的数据按每8字节反序
  List<T> reversedByChunk([int size = 8]) => chunk(size).map((e) => e.reversed).expand((e) => e).toList();
}
