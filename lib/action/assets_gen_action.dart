import 'dart:io';

import 'package:flutter_tools/action/tools_action.dart';
import 'package:flutter_tools/config/config.dart';
import 'package:flutter_tools/template/assets_class_template.dart';
import 'package:path/path.dart';

class AssetsGenAction extends ToolsAction {
  @override
  Future<void> run(Config config) async {
    createClassFile(config);
  }

  void createClassFile(Config config) {
    final classFile = File(join(
      Directory.current.path,
      config.classPath,
    ));
    if (!classFile.existsSync()) {
      classFile.createSync(recursive: true);
    }
    final template = AssetsClassTemplate(config: config);
    classFile.writeAsString(template.generateTemplate());
  }
}
