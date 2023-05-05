import 'package:c317_mobile/providers/class_provider.dart';
import 'package:c317_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/class_card.dart';

class ClassesScheduleScreen extends StatelessWidget {
  const ClassesScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClassProvider classProvider =
        Provider.of<ClassProvider>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
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
            Expanded(
              child: FutureBuilder<void>(
                future: classProvider.getClasses(userProvider.user),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Erro ao carregar as aulas'),
                      );
                    }
                    final classes = classProvider.classes;
                    return ListView.builder(
                      itemCount: classes.length,
                      itemBuilder: (context, index) {
                        return ClassCard(
                          subject: classes[index].subject.name,
                          date: classes[index].date,
                          location: classes[index].location,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
