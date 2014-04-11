library test_bot;

import 'dart:async' as async;
import 'dart:math' as math;
import 'package:bot/bot.dart';
import 'package:bot_test/bot_test.dart';
import 'package:unittest/unittest.dart';

import 'test_expand_stream.dart' as expand_stream;
import 'test_get_delayed_result.dart' as get_delayed_result;
import 'test_throttled_stream.dart' as throttled_stream;
import 'graph/topo_sort_test.dart' as topological;
import 'graph/tarjan_test.dart' as tarjan;

import 'math/test_box.dart' as math_rect;

part 'test_cloneable.dart';
part 'test_tuple.dart';

part 'events/test_events.dart';

part 'collection/test_collection_util.dart';
part 'collection/test_enumerable.dart';
part 'collection/test_sequence.dart';
part 'collection/test_number_enumerable.dart';
part 'collection/test_array_2d.dart';

part 'test_util.dart';
part 'math/test_coordinate.dart';
part 'math/test_vector.dart';
part 'math/test_affine_transform.dart';

part 'color/test_rgb_color.dart';
part 'color/test_hsl_color.dart';

part 'attached/test_property_event_integration.dart';
part 'attached/test_properties.dart';

part 'attached/test_attached_events.dart';

void main() {
  group('bot', () {
    group('expandStream', expand_stream.main);
    group('getDelayedResult', get_delayed_result.main);
    group('ThrottledStream', throttled_stream.main);
    group('graph', () {
      group('topological', topological.main);
      group('tarjan', tarjan.main);
    });
    TestTuple.run();
    TestEnumerable.run();
    TestSequence.run();
    TestNumberEnumerable.run();
    TestCollectionUtil.run();
    TestArray2d.run();

    group('math', () {
      TestCoordinate.run();
      math_rect.main();
      TestVector.run();
      TestAffineTransform.run();
    });

    TestUtil.run();
    TestCloneable.run();
    TestEvents.run();

    TestRgbColor.run();
    TestHslColor.run();

    test('StringReader', _testStringReader);

    group('attached', () {
      TestAttachedEvents.run();
      TestProperties.run();
      TestPropertyEventIntegration.run();
    });
  });
}


void _testStringReader() {
  _verifyValues('', [''], null);
  _verifyValues('Shanna', ['Shanna'], null);
  _verifyValues('Shanna\n', ['Shanna', ''], null);
  _verifyValues('\nShanna\n', ['', 'Shanna', ''], null);
  _verifyValues('\r\nShanna\n', ['', 'Shanna', ''], null);
  _verifyValues('\r\nShanna\r\n', ['', 'Shanna', ''], null);
  _verifyValues('\rShanna\r\n', ['\rShanna', ''], null);

  // a bit crazy. \r not before \n is not counted as a newline
  _verifyValues('\r\n\r\n\r\r\n\n', ['', '', '\r', '', ''], null);

  _verifyValues('line1\nline2\n\nthis\nis\the\rest\n',
      ['line1','line2',''], 'this\nis\the\rest\n');

}

void _verifyValues(String input, List<String> output, String rest) {
  final sr = new StringLineReader(input);
  for (final value in output) {
    expect(sr.readNextLine(), value);
  }
  expect(sr.readToEnd(), rest, reason: 'rest did not match');
  expect(sr.readNextLine(), null, reason: 'future nextLines should be null');
  expect(sr.readToEnd(), null, reason: 'future readToEnd should be null');
}
