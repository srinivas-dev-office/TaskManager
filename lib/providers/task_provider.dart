// ignore_for_file: avoid_print

import 'package:uuid/uuid.dart';

import '../core/routes/exports.dart';

class TaskProvider extends ChangeNotifier {

  /// HIVE BOX
  final Box<TaskModel> taskBox =
      Hive.box<TaskModel>(
    'taskBox',
  );

  /// ALL TASKS
  List<TaskModel> get tasks {

    return taskBox.values.toList();
  }

  /// TODO TASKS
  List<TaskModel> get todoTasks {

    return taskBox.values.where((e) {

      final status = e.status
          .toLowerCase()
          .replaceAll(" ", "");

      return status == "todo";

    }).toList();
  }

  /// IN PROGRESS TASKS
  List<TaskModel> get inProgressTasks {

    return taskBox.values.where((e) {

      final status = e.status
          .toLowerCase()
          .replaceAll(" ", "");

      return status ==
          "inprogress";

    }).toList();
  }

  /// COMPLETED TASKS
  List<TaskModel> get completedTasks {

    return taskBox.values.where((e) {

      final status = e.status
          .toLowerCase()
          .replaceAll(" ", "");

      return status ==
          "completed";

    }).toList();
  }

  /// ADD TASK
  Future<void> addTask({

    required String title,

    required String description,

    required String startDate,

    required String endDate,

    required String status,

    required String priority,

  }) async {

    try {

      final formattedStatus =
          status
              .toLowerCase()
              .replaceAll(" ", "");

      final task = TaskModel(

        id: const Uuid().v4(),

        title: title,

        description:
            description,

        startDate:
            startDate,

        endDate:
            endDate,

        status:
            formattedStatus,

        priority:
            priority,
      );

      /// SAVE TO HIVE
      await taskBox.put(
        task.id,
        task,
      );

      /// UPDATE UI
      notifyListeners();

    } catch (e) {

      print(
        "ADD TASK ERROR : $e",
      );
    }
  }

  /// DELETE TASK
  Future<void> deleteTask(
    String id,
  ) async {

    try {

      await taskBox.delete(id);

      notifyListeners();

    } catch (e) {

      print(
        "DELETE TASK ERROR : $e",
      );
    }
  }

  /// UPDATE FULL TASK
  Future<void> updateTask({

    required String id,

    required String title,

    required String description,

    required String startDate,

    required String endDate,

    required String status,

    required String priority,

  }) async {

    try {

      final updatedTask =
          TaskModel(

        id: id,

        title: title,

        description:
            description,

        startDate:
            startDate,

        endDate:
            endDate,

        status: status
            .toLowerCase()
            .replaceAll(" ", ""),

        priority:
            priority,
      );

      /// UPDATE IN HIVE
      await taskBox.put(
        id,
        updatedTask,
      );

      notifyListeners();

    } catch (e) {

      print(
        "UPDATE TASK ERROR : $e",
      );
    }
  }

  /// UPDATE TASK STATUS
  Future<void> updateTaskStatus({

    required String id,

    required String status,

  }) async {

    try {

      final task = taskBox.get(id);

      if (task != null) {

        final updatedTask =
            TaskModel(

          id: task.id,

          title: task.title,

          description:
              task.description,

          startDate:
              task.startDate,

          endDate:
              task.endDate,

          status: status
              .toLowerCase()
              .replaceAll(" ", ""),

          priority:
              task.priority,
        );

        await taskBox.put(
          id,
          updatedTask,
        );

        notifyListeners();
      }

    } catch (e) {

      print(
        "STATUS UPDATE ERROR : $e",
      );
    }
  }

  /// MOVE TASK BETWEEN SECTIONS
  Future<void> moveTaskToStatus({

    required String id,

    required String newStatus,

  }) async {

    try {

      final task = taskBox.get(id);

      if (task != null) {

        final updatedTask =
            TaskModel(

          id: task.id,

          title: task.title,

          description:
              task.description,

          startDate:
              task.startDate,

          endDate:
              task.endDate,

          status: newStatus
              .toLowerCase()
              .replaceAll(" ", ""),

          priority:
              task.priority,
        );

        /// UPDATE IN HIVE
        await taskBox.put(
          id,
          updatedTask,
        );

        notifyListeners();
      }

    } catch (e) {

      print(
        "MOVE TASK ERROR : $e",
      );
    }
  }

  /// CLEAR ALL TASKS
  Future<void> clearTasks() async {

    try {

      await taskBox.clear();

      notifyListeners();

    } catch (e) {

      print(
        "CLEAR TASK ERROR : $e",
      );
    }
  }
}