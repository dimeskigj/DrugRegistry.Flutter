import 'package:bloc/bloc.dart';
import 'package:rxdart/transformers.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
