import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/models/task/task_model.dart';
import '/features/home/bloc/home_bloc.dart';
import '/features/home/ui/widgets/home_app_bar.dart';
import '/features/widgets/fade_in_container.dart';

/// Screen with all tasks
@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = BlocProvider.of<HomeBloc>(context);
    bloc.add(const InitEvent());

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: HomeAppBar(
            userName: state.user.userName,
            onPressed: () {
              bloc.add(const SignOutEvent());
            },
          ),
          body: RefreshIndicator(
            color: Colors.deepPurple.shade300,
            onRefresh: () async {
              bloc.add(const InitEvent());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.tasks.length,
                itemBuilder: (_, int index) {
                  final TaskModel task = state.tasks[index];

                  if (state.tasks.isNotEmpty) {
                    return FadeInContainer(
                      margin: const EdgeInsets.only(
                        right: 20,
                        left: 20,
                        top: 20,
                      ),
                      child: ListTile(
                        title: Text(task.taskName),
                        subtitle: Text(task.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: !task.isCompleted
                                  ? () {
                                      bloc.add(
                                        UpdateTaskEvent(
                                          task: task,
                                        ),
                                      );
                                    }
                                  : null,
                              icon: Icon(
                                Icons.check,
                                color: task.isCompleted
                                    ? Colors.green
                                    : Colors.grey,
                                size: 25,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                bloc.add(
                                  DeleteTaskEvent(
                                    taskId: task.id,
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.red,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: Colors.green,
            onPressed: () {
              // bloc.add(
              //   AddTaskEvent(
              //     task: TaskModel(
              //       id: '1',
              //       taskName: 'get back',
              //       description: 'niice',
              //       startTime: DateTime.now(),
              //       lastUpdate: DateTime.now(),
              //       endTime: DateTime.now().subtract(Duration(days: 2)),
              //       isCompleted: false,
              //     ),
              //   ),
              // );
              bloc.add(const NavigateToAddEvent());
            },
            tooltip: 'Add Task',
            child: const Icon(
              Icons.add_rounded,
              size: 25,
            ),
          ),
        );
      },
    );
  }
}
