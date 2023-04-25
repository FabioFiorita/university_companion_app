import 'package:flutter/material.dart';

import '../../components/action_button.dart';
import '../../components/grades/average_card.dart';
import '../../components/grades/grade_card.dart';

class SimulateGradeScreen extends StatefulWidget {
  final Map<String, int> grades;

  const SimulateGradeScreen({Key? key, required this.grades}) : super(key: key);

  @override
  State<SimulateGradeScreen> createState() => _SimulateGradeScreenState();
}

class _SimulateGradeScreenState extends State<SimulateGradeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Simular notas'),
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
                      exam: widget.grades.keys.elementAt(index),
                      grade: widget.grades.values.elementAt(index),
                    ),
                  );
                },
                childCount: widget.grades.length,
              )),
            ],
          ),
        ));
    ;
  }

  getAverage() {}
}
