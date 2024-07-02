import 'package:flutter/material.dart';

class DrugSearchScreen extends StatefulWidget {
  const DrugSearchScreen({Key? key}) : super(key: key);

  @override
  DrugSearchScreenState createState() => DrugSearchScreenState();
}

class DrugSearchScreenState extends State<DrugSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchAnchor(
                // ignore: avoid_print
                viewOnChanged: (value) => print("changed: $value"),
                // ignore: avoid_print
                viewOnSubmitted: (value) => print("submitted: $value"),
                builder: (
                  BuildContext context,
                  SearchController controller,
                ) {
                  return SearchBar(
                    hintText: "Пребарувај лекови",
                    elevation: WidgetStateProperty.all(1),
                    controller: controller,
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(Icons.search),
                    ),
                  );
                },
                suggestionsBuilder: (
                  BuildContext context,
                  SearchController controller,
                ) {
                  return List.generate(
                    5,
                    (int index) {
                      final String item = 'item $index';
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          setState(
                            () {
                              controller.closeView(item);
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
              const Expanded(
                child: Center(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
