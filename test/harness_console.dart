library harness_console;

import 'package:unittest/unittest.dart';
import 'package:unittest/vm_config.dart';
import 'bot/_bot.dart' as bot;
import 'test_dump_render_tree.dart' as drt;

main() {
  testCore(new VMConfiguration());
}

void testCore(Configuration config) {
  unittestConfiguration = config;
  groupSep = ' - ';

  bot.main();
  drt.main();
}
