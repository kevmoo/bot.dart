library harness_console;

import 'package:unittest/unittest.dart';
import 'bot/_bot.dart' as bot;
import 'test_dump_render_tree.dart' as drt;

void main() {
  groupSep = ' - ';

  bot.main();
  drt.main();
}
