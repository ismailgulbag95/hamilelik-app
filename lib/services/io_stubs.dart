/// Web ortamında dart:io kütüphanesi derleme hatası vermesin diye oluşturulan stub.
class File {
  final String path;
  File(this.path);
  bool existsSync() => false;
  Future<bool> exists() async => false;
  Future<void> delete() async {}
  Future<File> copy(String path) async => this;
}

class Directory {
  final String path;
  Directory(this.path);
  Future<bool> exists() async => false;
  Future<void> create({bool recursive = false}) async {}
}

class Platform {
  static bool get isWindows => false;
  static bool get isLinux => false;
  static bool get isMacOS => false;
  static bool get isAndroid => false;
  static bool get isIOS => false;
}
