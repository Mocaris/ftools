import 'dart:io';

import 'package:args/args.dart';
import 'package:flutter_tools/action/assets_gen_action.dart';
import 'package:flutter_tools/config/config.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

const flagInit = "init";
const flagGen = "gen";

void main(List<String> args) async {
  var argParser = ArgParser();
  argParser.addFlag(
    flagGen,
    abbr: "g",
    negatable: true,
    help: "generate assets",
  );

  argParser.addFlag(
    'help',
    abbr: "h",
    negatable: true,
    help: "",
  );

  final argResults = argParser.parse(args);
  if (argResults.wasParsed("help")) {
    print(argParser.usage);
    return;
  }
  if (argResults.wasParsed("help")) {
    print(argParser.usage);
    return;
  }
  try {
    var config = await _initConfig();
    AssetsGenAction().run(config);
    exit(0);
  } catch (e) {
    print(e.toString());
    exit(-1);
  }
}

Future<Config> _initConfig() async {
  var pubspec = File(join(Directory.current.path, 'pubspec.yaml'));
  if (!pubspec.existsSync()) {
    throw 'pubspec.yaml not found, please run flutter create .';
  }
  var file = File(join(Directory.current.path, 'ftools.yaml'));
  if (!file.existsSync()) {
    file.createSync();
  }
  var pubYaml = loadYaml(pubspec.readAsStringSync()) as YamlMap;
  var flutterMap = pubYaml['flutter'] as YamlMap?;
  if (null == flutterMap) {
    throw 'flutter not found in pubspec.yaml';
  }
  var assetsList = ['assets'] as YamlList?;
  if (assetsList == null) {
    throw 'assets not found in pubspec.yaml';
  }
  var yamlContent = await file.readAsString();
  var yamlMap = (loadYaml(yamlContent) as YamlMap?) ?? YamlMap();
  return Config.fromYaml(
    yamlConfig: yamlMap,
    assetsDirs: assetsList.value.map((e) => e.toString()).toList(),
  );
}
