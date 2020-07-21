class RateLimiter<KEY> {
  final Map<KEY, int> _timestamps = {};

  static final RateLimiter _instance = RateLimiter._internal();

  factory RateLimiter() => _instance;

  RateLimiter._internal();

  bool shouldFetch(KEY key, Duration timeout) {
    final lastFetched = _timestamps[key];
    final now = DateTime.now().millisecondsSinceEpoch;

    if (lastFetched == null) {
      _timestamps[key] = now;
      return true;
    }

    if (now - lastFetched > timeout.inMilliseconds) {
      _timestamps[key] = now;
      return true;
    }

    return false;
  }

  void reset(KEY key) => _timestamps.remove(key);

  void clear() => _timestamps.clear();
}
