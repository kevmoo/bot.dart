library test_shared;

import 'bot/_bot.dart' as bot;
import 'bot_async/_bot_async.dart' as bot_async;

void main() {
  bot.main();
  bot_async.main();
}
