import 'package:flutter/material.dart';
import 'package:kode_kraken/features/teacher_view/ui/subject_assignment.dart';

import '../../../services/database.dart';

class AssignmentBatchSubject extends StatelessWidget {
  const AssignmentBatchSubject({super.key, required this.batch});

  final String batch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(batch),
      ),
      body: FutureBuilder(
        future: Database.getAllSubjects(batch),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.5,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => SubjectAssignment(
                            batch: batch,
                            subject: snapshot.data!.keys.toList()[index],
                            subjectAssignments: snapshot
                                .data![snapshot.data!.keys.toList()[index]]!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Center(
                        child: Text(
                          snapshot.data!.keys.toList()[index],
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("No batches found."),
              );
            }
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
