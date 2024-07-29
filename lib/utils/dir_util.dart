import 'dart:io';

import 'package:glob/glob.dart';
import 'package:path/path.dart';

abstract class DirUtil {
  static List<String> getFileList({
    required List<String> pathList,
    List<String> ignoreList = const [],
    bool sort = false,
  }) {
    var ignore = ignoreList.map((e) => Glob(e)).toList();
    List<String> list = [];
    final current = Directory.current;
    for (var dir in pathList) {
      final assetsDir = Directory(join(current.path, dir));
      if (!assetsDir.existsSync()) {
        continue;
      }
      //  #  忽略文件和文件夹\
      bool shouldIgnore = ignore.any((e) => e.matches(dir));
      if (shouldIgnore) {
        continue;
      }
      final fileList = assetsDir.listSync(recursive: false, followLinks: false);
      for (final file in fileList) {
        if (file is! File) {
          continue;
        }
        bool shouldIgnore = ignore.any((e) => e.matches(dir));
        if (shouldIgnore) {
          continue;
        }
        final path =
            file.path.replaceAll("\\", "/").replaceAll("${current.path}/", "");
        list.add(path);
      }
    }
    if (sort) {
      list.sort((a, b) => a.compareTo(b));
    }
    return list;
  }
}
