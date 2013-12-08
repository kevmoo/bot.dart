library harness_browser;

import 'package:unittest/html_enhanced_config.dart';
import 'package:unittest/unittest.dart';
import 'bot/_bot.dart' as bot;

main() {
  groupSep = ' - ';
  useHtmlEnhancedConfiguration();

  bot.main();
}
