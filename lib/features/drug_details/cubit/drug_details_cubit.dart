import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drug_details_state.dart';

class DrugDetailsCubit extends Cubit<DrugDetailsState> {
  DrugDetailsCubit() : super(const DrugDetailsState(isSaved: false));

  Future toggleIsSaved() async {
    emit(DrugDetailsState(isSaved: !state.isSaved));
  }
}
