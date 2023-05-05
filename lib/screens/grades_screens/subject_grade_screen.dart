import 'package:c317_mobile/components/action_button.dart';
import 'package:c317_mobile/components/grades/average_card.dart';
import 'package:c317_mobile/components/grades/grade_bottom_sheet.dart';
import 'package:c317_mobile/components/grades/grade_card.dart';
import 'package:c317_mobile/providers/grade_provider.dart';
import 'package:c317_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  Map<String, int> grades = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject),
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
                  text: (isSimulating == true) ? "Parar de simular" : 'Simular',
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).canvasColor,
                  onPressed: () {
                    setState(
                      () {
                        isSimulating = !isSimulating;
                        grades = mapGrades();
                      },
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Text('Notas'),
            ),
            FutureBuilder<void>(
              future: mapGrades(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Erro ao carregar as notas"),
                    );
                  }
                  return SliverList(
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
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: (isSimulating == true)
          ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: true,
                  builder: (context) {
                    return GradeBottomSheet(
                      onPressed: () {
                        setState(
                          () {
                            if (grades.containsKey(gradeNameController.text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  elevation: 0.0,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                  content: Text(
                                    'Já existe uma avaliação com esse nome',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.onError,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              grades.addEntries([
                                MapEntry(
                                  gradeNameController.text,
                                  int.parse(gradeValueController.text),
                                )
                              ]);
                            }
                            Navigator.pop(context);
                          },
                        );
                      },
                      gradeNameController: gradeNameController,
                      gradeValueController: gradeValueController,
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            )
          : Container(),
    );
  }

  int getAverage() {
    if (grades.isEmpty) {
      return 0;
    }
    return (grades.values.reduce((a, b) => a + b) / grades.length).round();
  }

  mapGrades() async {
    GradeProvider gradeProvider =
        Provider.of<GradeProvider>(context, listen: false);
    await gradeProvider
        .getGrades(Provider.of<UserProvider>(context, listen: false).user);
    for (var element in gradeProvider.grades) {
      if (element.subject.name == widget.subject) {
        grades.addEntries(
          [
            MapEntry(element.code, element.grade),
          ],
        );
      }
    }
  }
}
