import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_drug_registry/core/models/pharmacy.dart';
import 'package:flutter_drug_registry/core/services/pharmacy_service.dart';

part 'pharmacy_search_event.dart';
part 'pharmacy_search_state.dart';

class PharmacySearchBloc
    extends Bloc<PharmacySearchEvent, PharmacySearchState> {
  late final PharmacyService _pharmacyService;

  PharmacySearchBloc(
    PharmacyService? pharmacyService,
  ) : super(PharmacySearchInitial()) {
    _pharmacyService = pharmacyService ?? PharmacyService();

    on<PharmacySearchEvent>((event, emit) {});
  }
}
