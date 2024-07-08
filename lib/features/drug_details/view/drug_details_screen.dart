import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drug_registry/core/models/drug.dart';
import 'package:flutter_drug_registry/features/drug_details/cubit/drug_details_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class DrugDetailsScreen extends StatelessWidget {
  const DrugDetailsScreen({super.key, required this.drug});

  final Drug drug;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          drug.latinName!,
        ),
        actions: [
          if (drug.url != null)
            IconButton.outlined(
              onPressed: () => launchUrl(drug.url!),
              icon: const Icon(
                Icons.open_in_new,
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          context.watch<DrugDetailsCubit>().state.isSaved
              ? Icons.bookmark_remove
              : Icons.bookmark_add,
        ),
        label: Text(
          context.watch<DrugDetailsCubit>().state.isSaved ? "Тргни" : "Зачувај",
        ),
        onPressed: context.read<DrugDetailsCubit>().toggleIsSaved,
      ),
      body: Container(),
    );
  }
}
