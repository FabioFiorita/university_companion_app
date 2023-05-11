import 'package:c317_mobile/components/action_button.dart';
import 'package:c317_mobile/components/grades/average_card.dart';
import 'package:c317_mobile/components/grades/grade_bottom_sheet.dart';
import 'package:c317_mobile/components/grades/grade_card.dart';
import 'package:c317_mobile/models/grade.dart';
import 'package:c317_mobile/providers/grade_provider.dart';
import 'package:c317_mobile/providers/subject_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/error_handler.dart';
import '../../models/subject.dart';

class SubjectGradeScreen extends StatefulWidget {
  final String subject;

  const SubjectGradeScreen({Key? key, required this.subject}) : super(key: key);

  @override
  State<SubjectGradeScreen> createState() => _SubjectGradeScreenState();
}

class _SubjectGradeScreenState extends State<SubjectGradeScreen> {
  final TextEditingController gradeNameController = TextEditingController();
  final TextEditingController gradeValueController = TextEditingController();
  bool isSimulating = false;

  @override
  Widget build(BuildContext context) {
    final Subject subject = Provider.of<SubjectProvider>(context, listen: false)
        .subjects
        .firstWhere((element) => element.name == widget.subject);
    return Consumer<GradeProvider>(builder: (_, store, __) {
      final grades = store.grades
          .where((element) => element.subject.name == widget.subject)
          .toList();
      final simulatedGrades = store.simulatedGrades
          .where((element) => element.subject.name == widget.subject)
          .toList();
      return Scaffold(
        appBar: AppBar(title: Text(subject.name)),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AverageCard(
                    grade: (isSimulating)
                        ? getAverage(simulatedGrades)
                        : getAverage(grades)),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                  child: ActionButton(
                    text: (isSimulating) ? 'Parar de simular' : 'Simular',
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).canvasColor,
                    onPressed: () {
                      setState(
                        () {
                          isSimulating = !isSimulating;
                          store.toggleGradeSimulation();
                        },
                      );
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Text('Notas'),
              ),
              if (store.isLoading)
                const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
              if (store.error != null)
                SliverToBoxAdapter(
                  child: ErrorHandler(error: store.error!),
                ),
              (isSimulating) ? gradeList(simulatedGrades) : gradeList(grades),
            ],
          ),
        ),
        floatingActionButton: (isSimulating)
            ? FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      builder: (context) {
                        return GradeBottomSheet(
                            onPressed: () {
                              final bool result = store.addSimulatedGrade(
                                  gradeNameController.text,
                                  int.parse(gradeValueController.text),
                                  subject);
                              if (result == false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.error,
                                    content: Text(
                                      'Já existe uma avaliação com esse nome.',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              gradeNameController.clear();
                              gradeValueController.clear();
                              Navigator.pop(context);
                            },
                            gradeNameController: gradeNameController,
                            gradeValueController: gradeValueController);
                      });
                },
                child: const Icon(Icons.add),
              )
            : Container(),
      );
    });
  }

  int getAverage(List<Grade> grades) {
    if (grades.isEmpty) {
      return 0;
    }
    return grades.map((e) => e.grade).reduce((a, b) => a + b) ~/ grades.length;
  }

  Widget gradeList(List<Grade> grades) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: GradeCard(
              exam: grades[index].code,
              grade: grades[index].grade,
            ),
          );
        },
        childCount: grades.length,
      ),
    );
  }
}
