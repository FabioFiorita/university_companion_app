import 'package:c317_mobile/components/action_button.dart';
import 'package:c317_mobile/components/grades/average_card.dart';
import 'package:c317_mobile/components/grades/grade_card.dart';
import 'package:flutter/material.dart';

class SubjectGradeScreen extends StatelessWidget {
  final String subject;

  SubjectGradeScreen({Key? key, required this.subject}) : super(key: key);

  final Map<String, int?> grades = {'NP1': 80, 'NP2': 50, 'NP3': 10, 'NPL': 90};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(subject),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AverageCard(grade: getAverage()),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                  child: ActionButton(
                      text: 'Simular',
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).canvasColor,
                      onPressed: () {}),
                ),
              ),
              const SliverToBoxAdapter(
                child: Text('Notas'),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: GradeCard(
                      exam: grades.keys.elementAt(index),
                      grade: grades.values.elementAt(index),
                    ),
                  );
                },
                childCount: grades.length,
              )),
            ],
          ),
        ));
  }

  int getAverage() {
    return grades.values.reduce((a, b) => a! + b!)! ~/ grades.length;
  }
}
