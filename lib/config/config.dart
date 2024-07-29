import 'dart:convert';

import 'package:yaml/yaml.dart';

class Config {
  final String assetDir;
  final String className;
  final String classPath;
  final List<String> assetsDirs;
  final List<String> ignoreList;
  final bool sort;

  Config({
    required this.assetDir,
    required this.className,
    required this.classPath,
    required this.assetsDirs,
    required this.ignoreList,
    this.sort = false,
  })  : assert(assetsDirs.isNotEmpty, "pubspec.yaml assets can not be empty"),
        assert(className.isNotEmpty, "className can not be empty"),
        assert(classPath.isNotEmpty, "classPath can not be empty");

  factory Config.fromYaml({
    required YamlMap yamlConfig,
    List<String> assetsDirs = const [],
  }) {
    final config = yamlConfig["flutter_tools"] as YamlMap?;
    final assetDir = config?['assets_dir'] as String?;
    final className = config?["class_name"] as String?;
    final classPath = config?["class_path"] as String?;
    final sort = config?["sort"] as bool?;
    final ignoreList = config?["ignore"] as YamlList?;
    return Config(
      assetDir: assetDir ?? "assets",
      className: className ?? "R",
      classPath: classPath ?? "lib/resource/assets.dart",
      assetsDirs: assetsDirs,
      sort: sort ?? false,
      ignoreList: ignoreList?.value.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map toJson() {
    return {
      "assetDir": assetDir,
      "className": className,
      "classPath": classPath,
      "assetsDirs": assetsDirs,
      "ignoreList": ignoreList,
      "sort": sort,
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
