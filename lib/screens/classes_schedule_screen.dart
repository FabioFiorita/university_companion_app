import 'package:c317_mobile/components/error_handler.dart';
import 'package:c317_mobile/providers/class_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/class_card.dart';

class ClassesScheduleScreen extends StatelessWidget {
  const ClassesScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horarios'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Minhas aulas',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Consumer<ClassProvider>(
              builder: (_, store, __) {
                if (store.isLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (store.error != null) {
                  print(store.error);
                  return Expanded(
                      child: Center(child: ErrorHandler(error: store.error!)));
                }
                final classes = store.classes;
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: classes.length,
                    itemBuilder: (context, index) {
                      return ClassCard(
                        subject: classes[index].subject.name,
                        date: classes[index].date,
                        location: classes[index].location,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
