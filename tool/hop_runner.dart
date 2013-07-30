library hop_runner;

import 'dart:async';
import 'dart:io';
import 'package:bot/bot.dart';
import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';
import '../test/harness_console.dart' as test_console;

import 'package:hop/src/hop_tasks_experimental.dart' as dartdoc;

void main() {
  // Easy to enable hop-wide logging
  // enableScriptLogListener();

  addTask('test', createUnitTestTask(test_console.testCore));

  addTask('docs', createDartDocTask(_getLibs, linkApi: true, postBuild: dartdoc.createPostBuild(_cfg)));

  //
  // Analyzer
  //
  addTask('analyze_libs', createAnalyzerTask(_getLibs));

  addTask('analyze_test_libs', createAnalyzerTask(
      ['test/harness_browser.dart', 'test/harness_console.dart']));

  //
  // Dart2js
  //
  final paths = ['test/harness_browser.dart'];

  addTask('dart2js', createDartCompilerTask(paths,
      liveTypeAnalysis: true, rejectDeprecatedFeatures: true));

  runHop();
}

Future<List<String>> _getLibs() {
  return new Directory('lib').list()
      .where((FileSystemEntity fse) => fse is File)
      .map((File file) => file.path)
      .toList();
}

final _cfg = new dartdoc.DocsConfig('BOT', 'https://github.com/kevmoo/bot.dart',
    'logo.png', 333, 250, (String libName) => libName.startsWith('bot'));
