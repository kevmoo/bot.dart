library hop_runner;

import 'dart:async';
import 'dart:io';
import 'package:bot/bot.dart';
import 'package:bot/bot_io.dart';
import 'package:bot/hop.dart';
import 'package:bot/hop_tasks.dart';
import '../test/harness_console.dart' as test_console;

import 'tasks/update_example_html.dart' as html_tasks;
import 'tasks/dartdoc_postbuild.dart' as dartdoc;
import 'tasks/unified_docs.dart' as unified_docs;

void main() {
  // Easy to enable hop-wide logging
  // enableScriptLogListener();

  addTask('test', createUnitTestTask(test_console.testCore));

  addTask('docs', createDartDocTask(_getLibs, linkApi: true, postBuild: dartdoc.postBuild));

  //
  // Analyzer
  //
  addTask('analyze_libs', createDartAnalyzerTask(_getLibs));

  addTask('analyze_test_libs', createDartAnalyzerTask(['test/harness_browser.dart',
                                                       'test/test_console.dart',
                                                       'test/harness_console.dart',
                                                       'test/test_dump_render_tree.dart',
                                                       'test/test_browser.dart',
                                                       'test/test_shared.dart']));

  //
  // Dart2js
  //
  final paths = ['click', 'drag', 'fract', 'frames', 'nav', 'spin']
      .map((d) => "example/bot_retained/$d/${d}_demo.dart")
      .toList();
  paths.add('test/harness_browser.dart');

  addTask('dart2js', createDart2JsTask(paths,
      liveTypeAnalysis: true, rejectDeprecatedFeatures: true));

  addTask('bench', createBenchTask());

  addTask('update-html', html_tasks.getUpdateExampleHtmlTask());

  addTask('x-git-docs', unified_docs.gitGitDocExperimentTask());

  runHop();
}

Future<List<String>> _getLibs() {
  return new Directory('lib').list()
      .where((FileSystemEntity fse) => fse is File)
      .map((File file) => file.path)
      .toList();
}
