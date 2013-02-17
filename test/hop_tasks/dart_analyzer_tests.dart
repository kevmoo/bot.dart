// TODO(adam): test `--enable_type_checks`

part of test_hop_tasks;

class DartAnalyzerTests {

  static void register() {
    group('dart_analyzer', () {
      test('passing file', () {
        final fileTexts = {"main.dart": "void main() => print('hello bot');"};

        _testAnalyzerTask(fileTexts, RunResult.SUCCESS);
      });

      test('warning file', () {
        final fileTexts = {"main.dart": "void main() { String i = 42; }"};

        _testAnalyzerTask(fileTexts, RunResult.SUCCESS);
      });

      test('failed file', () {
        final fileTexts = {"main.dart": "void main() => asdf { XXXX i = 42; }"};

        _testAnalyzerTask(fileTexts, RunResult.FAIL);
      });

      test('multiple passing files', () {
        final fileTexts = {"main1.dart": "void main() => print('hello bot');",
                           "main2.dart": "void main() => print('hello bot');",
                           "main3.dart": "void main() => print('hello bot');" };

        _testAnalyzerTask(fileTexts, RunResult.SUCCESS);
      });

      test('multiple warning files', () {
        final fileTexts = {"main1.dart": "void main() { String i = 42; }",
                           "main2.dart": "void main() { String i = 42; }",
                           "main3.dart": "void main() { String i = 42; }" };

        _testAnalyzerTask(fileTexts, RunResult.SUCCESS);
      });

      test('multiple failed files', () {
        final fileTexts = {"main1.dart": "void main() asdf { String i = 42; }",
                           "main2.dart": "void main() asdf { String i = 42; }",
                           "main3.dart": "void main() asdf { String i = 42; }" };

        _testAnalyzerTask(fileTexts, RunResult.FAIL);

      });

      test('cache directory directory', () {
        final fileTexts = {"main.dart": "void main() => print('hello bot');"};

        _testAnalyzerTask(fileTexts, RunResult.SUCCESS, cacheDirectory: true);
      });

//    test('mixed multiple passing, warning, failed files', () {
//      expect(isTrue, isFalse);
//    });

    });
  }
}

void _testAnalyzerTask(Map<String, String> inputs, RunResult expectedResult, {bool cacheDirectory: false}) {
  TempDir codeDir;
  TempDir outDir;

  final future = TempDir.create()
      .then((TempDir value) {
        codeDir = value;
        final populater = new MapDirectoryPopulater(inputs);
        return codeDir.populate(populater);
      })
      .then((TempDir value) {
        assert(value == codeDir);

        if(cacheDirectory) {
          return TempDir.create();
        } else {
          return null;
        }
      })
      .then((TempDir value) {
        outDir = value;
        expect(outDir != null, cacheDirectory, reason: 'only exists if cachDir was requested');

        var fullPaths = inputs.keys
            .map((fileName) {
              new Path(codeDir.path).join(new Path(fileName)).toNativePath();
            })
            .toList();

        Task task;

        if (cacheDirectory) {
          task = createDartAnalyzerTask(fullPaths, cacheDirectory: outDir.dir.path);
        } else {
          task = createDartAnalyzerTask(fullPaths);
        }

        return _runTask(task);
      })
      .then((RunResult runResult) {
        expect(runResult, expectedResult);

        if(cacheDirectory) {
          return outDir.isEmpty();
        } else {
          return null;
        }
      })
      .then((bool isEmpty) {
        if(cacheDirectory) {
          expect(isEmpty, isFalse);
        } else {
          expect(isEmpty, isNull);
        }
      })
      .whenComplete(() {
        if(codeDir != null) {
          codeDir.dispose();
        }

        if(outDir != null) {
          outDir.dispose();
        }
      });

  expect(future, finishes);
}
