import 'package:flutter_tools/config/config.dart';
import 'package:flutter_tools/utils/dir_util.dart';

final nameReg = RegExp(r"[^\w_]");

class AssetsClassTemplate {
  AssetsClassTemplate({
    required this.config,
  });

  final Config config;

  String get className => config.className;

  List<String> get pathList => config.assetsDirs;

  String generateTemplate() {
    final list = DirUtil.getFileList(
      pathList: pathList,
      ignoreList: config.ignoreList,
      sort: config.sort,
    );
    return """
    
abstract class $className {
  $className._();

  ${list.map((e) => """
  ///[${_formatFileName(e)}]($e)
 static const String ${_formatFileName(e)} = "$e";
  """).join("\n")}

}

  """;
  }

  String _formatFileName(String fileName) {
    String name = fileName
        .replaceAll(nameReg, "_")
        .replaceAllMapped(RegExp(r"_([a-zA-Z])"), (match) {
      return match.group(1)!.toUpperCase();
    });

    return name;
  }
}
