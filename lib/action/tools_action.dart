import 'package:flutter_tools/config/config.dart';

export 'package:yaml/src/yaml_node.dart';

abstract class ToolsAction {
  Future<void> run(Config config);
}
