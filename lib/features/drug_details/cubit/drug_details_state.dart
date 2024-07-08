part of 'drug_details_cubit.dart';

final class DrugDetailsState extends Equatable {
  const DrugDetailsState({required this.isSaved});

  final bool isSaved;

  @override
  List<Object> get props => [isSaved];
}
