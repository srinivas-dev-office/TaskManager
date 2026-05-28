// ignore_for_file: deprecated_member_use



import 'package:intl/intl.dart';
import 'package:taskmanager/core/routes/exports.dart';


class TaskDetailsPopup extends StatelessWidget {
  final dynamic task;

  const TaskDetailsPopup({
    super.key,
    required this.task,
  });

  static const primary = Color(0xff1E293B);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TOP
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xff2563EB),
                    child: Icon(
                      Icons.task_alt,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Text(
                      "Task Details",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// TITLE
              const Text(
                "Task Title",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                task.title ?? "",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),

              const SizedBox(height: 20),

              /// DESCRIPTION
              const Text(
                "Description",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  task.description ?? "",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// STATUS
              Row(
                children: [

                  /// STATUS
                  Expanded(
                    child: buildColorCard(
                      title: "Status",
                      value: task.status ?? "",
                      color: Colors.blue,
                      icon: Icons.sync,
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// PRIORITY
                  Expanded(
                    child: buildColorCard(
                      title: "Priority",
                      value: "High",
                      color: Colors.red,
                      icon: Icons.flag,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              /// DATES
              Row(
                children: [

                  /// START DATE
                  Expanded(
                    child: buildColorCard(
                      title: "Start Date",
                      value: formatDate(task.startDate ?? ""),
                      color: Colors.green,
                      icon: Icons.calendar_month,
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// END DATE
                  Expanded(
                    child: buildColorCard(
                      title: "End Date",
                      value: formatDate(task.endDate ?? ""),
                      color: Colors.orange,
                      icon: Icons.event,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// BUTTONS
              Row(
                children: [

                  /// EDIT BUTTON
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {

                        Navigator.pop(context);

                        /// OPEN EDIT PAGE
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditTaskPage(
                              task: task,
                            ),
                          ),
                        );
                      },

                      icon: const Icon(Icons.edit),

                      label: const Text("Edit"),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// CLOSE BUTTON
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(Icons.close),

                      label: const Text("Close"),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// COLOR CARD
  Widget buildColorCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 18,
              ),

              const SizedBox(width: 6),

              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: primary,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  /// DATE FORMAT
  String formatDate(String date) {
    try {
      final parsedDate =
          DateFormat("d/M/yyyy").parse(date);

      return DateFormat(
        "dd MMM yyyy",
      ).format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}

