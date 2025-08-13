class Pair<TFirst, TSecond> {
  final TFirst _first;
  final TSecond _second;

  Pair({required TFirst first, required TSecond second}) : _first = first, _second = second;

  TFirst get first => _first;
  TSecond get second => _second;
}
