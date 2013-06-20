part of bot_test;

void pending() {
  fail('Not implemented');
}

final Matcher throwsInvalidOperationError =
  const Throws(const _InvalidOperationError());

final Matcher throwsNullArgumentError =
  const Throws(const _NullArgumentError());

final Matcher throwsAssertionError =
  const Throws(const _AssertionErrorMatcher());

void expectFutureFail(Future future, [void onException(error)]) {
  assert(future != null);

  final testWait = expectAsync2((bool isError, result) {
    assert(isError != null);

    if(!isError) {
      fail('Expected future to throw an exception');
    }
    if(onException != null) {
      onException(result);
    }
  });
  future.then((value) => testWait(false, value), onError: (error) => testWait(true, error));
}

void expectFutureComplete(Future future, [Action1 onComplete]) {
  assert(future != null);

  final testWait = expectAsync2((bool isError, result) {
    assert(isError != null);

    if(isError) {
      final err = result;
      registerException(err, getAttachedStackTrace(err));
    }

    if(onComplete != null) {
      onComplete(result);
    }
  });
  future.then((value) => testWait(false, value), onError: (error) => testWait(true, error));
}

/**
 * Matches a [Future] that completes successfully with a value. Note that this
 * creates an asynchronous expectation. The call to `expect()` that includes
 * this will return immediately and execution will continue. Later, when the
 * future completes, the actual expectation will run.
 *
 * To test that a Future completes with an exception, you can use [throws] and
 * [throwsA].
 *
 * Unlike [completes] in `unittest`, exceptions are registered directly with
 * the test framework. They are not wrapped.
 */
Matcher finishes = const _Finishes(null);

/**
 * Matches a [Future] that completes succesfully with a value that matches
 * [matcher]. Note that this creates an asynchronous expectation. The call to
 * `expect()` that includes this will return immediately and execution will
 * continue. Later, when the future completes, the actual expectation will run.
 *
 * To test that a Future completes with an exception, you can use [throws] and
 * [throwsA].
 *
 * Unlike [completion] in `unittest`, exceptions are registered directly with
 * the test framework. They are not wrapped.
 */
Matcher finishesWith(matcher) => new _Finishes(wrapMatcher(matcher));

class _Finishes extends BaseMatcher {
  final Matcher _matcher;

  const _Finishes(this._matcher);

  @override
  bool matches(item, Map matchState) {
    if (item is! Future) return false;
    var done = wrapAsync((fn) => fn());

    item.then((value) {
      done(() { if (_matcher != null) expect(value, _matcher); });
    }, onError: (error) {
      done(() => registerException(error, getAttachedStackTrace(error)));
    });

    return true;
  }

  @override
  Description describe(Description description) {
    if (_matcher == null) {
      description.add('completes successfully');
    } else {
      description.add('completes to a value that ').addDescriptionOf(_matcher);
    }
    return description;
  }
}

class _AssertionErrorMatcher extends TypeMatcher {
  const _AssertionErrorMatcher() : super("AssertMatcher");

  @override
  bool matches(item, Map matchState) => item is AssertionError;
}

class _StateErrorMatcher extends TypeMatcher {
  const _StateErrorMatcher() : super("StateErrorMatcher");

  @override
  bool matches(item, Map matchState) => item is StateError;
}

class _InvalidOperationError extends TypeMatcher {
  const _InvalidOperationError() : super("InvalidOperationException");

  @override
  bool matches(item, Map matchState) => item is InvalidOperationError;
}

class _NullArgumentError extends TypeMatcher {
  const _NullArgumentError() : super("NullArgumentException");

  @override
  bool matches(item, Map matchState) => item is NullArgumentError;
}
