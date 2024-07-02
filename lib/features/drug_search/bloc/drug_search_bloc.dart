import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drug_search_event.dart';
part 'drug_search_state.dart';

class DrugSearchBloc extends Bloc<DrugSearchEvent, DrugSearchState> {
  DrugSearchBloc() : super(DrugSearchInitial()) {
    on<DrugSearchEvent>((event, emit) {
    });
  }
}
