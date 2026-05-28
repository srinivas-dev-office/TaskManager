// ignore_for_file: deprecated_member_use



import 'package:intl/intl.dart';
import 'package:taskmanager/core/routes/exports.dart';

class TaskCardWidget extends StatelessWidget {
  final dynamic task;
  final VoidCallback onDelete;

  const TaskCardWidget({
    super.key,
    required this.task,
    required this.onDelete,
  });

  /// COLORS
  static const primaryColor =
      Color(0xff0F172A);

  static const secondaryColor =
      Color(0xff1E3A8A);

  static const accentColor =
      Color(0xff3B82F6);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 18),

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(24),

        color: Colors.white,

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              0.05,
            ),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius:
              BorderRadius.circular(24),

          onTap: () {
            showDialog(
              context: context,

              builder: (context) {
                return TaskDetailsPopup(
                  task: task,
                );
              },
            );
          },

          child: Padding(
            padding:
                const EdgeInsets.all(18),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                /// TOP ROW
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    /// TASK ICON
                    Container(
                      height: 58,
                      width: 58,

                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),

                        gradient:
                            const LinearGradient(
                          begin:
                              Alignment.topLeft,

                          end: Alignment
                              .bottomRight,

                          colors: [
                            primaryColor,
                            secondaryColor,
                            accentColor,
                          ],
                        ),
                      ),

                      child: const Icon(
                        Icons.task_alt_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 14),

                    /// TITLE + STATUS
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Text(
                            task.title,

                            maxLines: 1,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                const TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                              color:
                                  primaryColor,
                            ),
                          ),

                          const SizedBox(
                              height: 10),

                          Wrap(
                            spacing: 8,
                            runSpacing: 8,

                            children: [

                              buildStatus(
                                task.status,
                              ),

                              buildPriority(
                                task.priority ??
                                    "Medium",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// THREE DOTS MENU
                    PopupMenuButton<String>(
                      color: Colors.white,

                      elevation: 10,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),
                      ),

                      offset:
                          const Offset(0, 45),

                      icon: Container(
                        padding:
                            const EdgeInsets.all(
                          8,
                        ),

                        decoration:
                            BoxDecoration(
                          color: Colors
                              .grey.shade100,

                          borderRadius:
                              BorderRadius
                                  .circular(
                            12,
                          ),
                        ),

                        child: const Icon(
                          Icons.more_vert,
                          color:
                              primaryColor,
                        ),
                      ),

                      onSelected: (value) {

                        if (value ==
                            "delete") {

showDialog(
  context: context,

  barrierDismissible: true,

  builder: (context) {

    return Dialog(

      backgroundColor: Colors.transparent,

      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),

      child: Container(

        padding: const EdgeInsets.all(
          24,
        ),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
            30,
          ),

          boxShadow: [

            BoxShadow(

              color: Colors.black.withOpacity(
                0.08,
              ),

              blurRadius: 25,

              offset: const Offset(
                0,
                10,
              ),
            ),
          ],
        ),

        child: Column(

          mainAxisSize:
              MainAxisSize.min,

          children: [

            /// TOP ICON
            Container(

              height: 85,

              width: 85,

              decoration: BoxDecoration(

                shape: BoxShape.circle,

                gradient:
                    LinearGradient(

                  colors: [

                    Colors.red.shade400,

                    Colors.red.shade700,
                  ],
                ),
              ),

              child: const Icon(

                Icons.delete_rounded,

                color: Colors.white,

                size: 42,
              ),
            ),

            const SizedBox(
              height: 22,
            ),

            /// TITLE
            const Text(

              "Delete Task ?",

              style: TextStyle(

                fontSize: 24,

                fontWeight:
                    FontWeight.bold,

                color: Color(
                  0xff1E293B,
                ),
              ),
            ),

            const SizedBox(
              height: 14,
            ),

            /// MESSAGE
            Text(

              "Are you sure you want to delete\n'${task.title}' ?",

              textAlign:
                  TextAlign.center,

              style: TextStyle(

                fontSize: 15,

                color: Colors.grey.shade700,

                height: 1.5,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            /// BUTTONS
            Row(

              children: [

                /// CANCEL BUTTON
                Expanded(

                  child: InkWell(

                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),

                    onTap: () {

                      Navigator.pop(
                        context,
                      );
                    },

                    child: Container(

                      height: 52,

                      alignment:
                          Alignment.center,

                      decoration: BoxDecoration(

                        color: Colors.grey.shade100,

                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),
                      ),

                      child: const Text(

                        "Cancel",

                        style: TextStyle(

                          fontWeight:
                              FontWeight.w600,

                          fontSize: 16,

                          color: Color(
                            0xff475569,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 14,
                ),

                /// DELETE BUTTON
                Expanded(

                  child: InkWell(

                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),

                    onTap: () {

                      Navigator.pop(
                        context,
                      );

                      onDelete();
                    },

                    child: Container(

                      height: 52,

                      alignment:
                          Alignment.center,

                      decoration: BoxDecoration(

                        gradient:
                            LinearGradient(

                          colors: [

                            Colors.red.shade400,

                            Colors.red.shade700,
                          ],
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),
                      ),

                      child: const Row(

                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          Icon(

                            Icons.delete,

                            color: Colors.white,

                            size: 20,
                          ),

                          SizedBox(
                            width: 8,
                          ),

                          Text(

                            "Delete",

                            style: TextStyle(

                              color: Colors.white,

                              fontSize: 16,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  },
);
                        }
                      },

                      itemBuilder:
                          (context) => [

                        PopupMenuItem(
                          value: "delete",

                          child: Row(
                            children: [

                              Container(
                                padding:
                                    const EdgeInsets
                                        .all(
                                  8,
                                ),

                                decoration:
                                    BoxDecoration(

                                  color: Colors
                                      .red
                                      .withOpacity(
                                    0.1,
                                  ),

                                  borderRadius:
                                      BorderRadius.circular(
                                    10,
                                  ),
                                ),

                                child: const Icon(
                                  Icons.delete_outline,
                                  color:
                                      Colors.red,
                                  size: 20,
                                ),
                              ),

                              const SizedBox(
                                  width: 12),

                              const Text(
                                "Delete Task",

                                style:
                                    TextStyle(
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                /// DESCRIPTION
                Text(
                  task.description,

                  maxLines: 2,

                  overflow:
                      TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color:
                        Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 18),

                /// DATE CONTAINER
                Container(
                  padding:
                      const EdgeInsets.all(
                    14,
                  ),

                  decoration: BoxDecoration(
                    color:
                        Colors.grey.shade100,

                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),

                  child: Row(
                    children: [

                      Expanded(
                        child: buildDateItem(
                          icon:
                              Icons.play_circle,
                          title: "Start",
                          date:
                              task.startDate,
                          color:
                              Colors.green,
                        ),
                      ),

                      Container(
                        height: 40,
                        width: 1,
                        color:
                            Colors.grey.shade300,
                      ),

                      Expanded(
                        child: buildDateItem(
                          icon: Icons.flag,
                          title: "End",
                          date: task.endDate,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// STATUS
  Widget buildStatus(String status) {
    Color color;

    switch (status.toLowerCase()) {

      case "todo":
        color = Colors.orange;
        break;

      case "inprogress":
        color = Colors.blue;
        break;

      case "completed":
        color = Colors.green;
        break;

      default:
        color = Colors.grey;
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color:
            color.withOpacity(0.12),

        borderRadius:
            BorderRadius.circular(30),
      ),

      child: Text(
        status.toUpperCase(),

        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  /// PRIORITY
  Widget buildPriority(
    String priority,
  ) {
    Color color;

    switch (priority.toLowerCase()) {

      case "high":
        color = Colors.red;
        break;

      case "medium":
        color = Colors.orange;
        break;

      default:
        color = Colors.green;
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color:
            color.withOpacity(0.12),

        borderRadius:
            BorderRadius.circular(30),
      ),

      child: Text(
        priority,

        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }

  /// DATE ITEM
  Widget buildDateItem({
    required IconData icon,
    required String title,
    required String date,
    required Color color,
  }) {
    return Row(
      children: [

        Icon(
          icon,
          color: color,
          size: 22,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                title,

                style: TextStyle(
                  fontSize: 11,
                  color:
                      Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                formatDate(date),

                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// DATE FORMAT
  String formatDate(String date) {

    final parsed =
        DateFormat("d/M/yyyy")
            .parse(date);

    return DateFormat(
      "dd MMM yyyy",
    ).format(parsed);
  }
}