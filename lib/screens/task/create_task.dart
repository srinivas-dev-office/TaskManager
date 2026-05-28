// ignore_for_file: use_build_context_synchronously

import 'package:taskmanager/core/routes/exports.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() =>
      _CreateTaskState();
}

class _CreateTaskState
    extends State<CreateTask> {

  final formKey = GlobalKey<FormState>();

  /// CONTROLLERS
  final TextEditingController
      titleController =
      TextEditingController();

  final TextEditingController
      descriptionController =
      TextEditingController();

  final TextEditingController
      startDateController =
      TextEditingController();

  final TextEditingController
      endDateController =
      TextEditingController();

  /// DROPDOWN VALUES
  String selectedStatus = "Todo";

  String selectedPriority = "Medium";

  /// COLORS
  final Color backgroundColor =
      const Color(0xffF5F7FB);

  /// DATE PICKER
  Future<void> pickDate(
    TextEditingController controller,
  ) async {

    DateTime? pickedDate =
        await showDatePicker(

      context: context,

      initialDate: DateTime.now(),

      firstDate: DateTime(2024),

      lastDate: DateTime(2035),
    );

    if (pickedDate != null) {

      controller.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  /// SAVE TASK
  Future<void> saveTask() async {

    await Provider.of<TaskProvider>(
      context,
      listen: false,
    ).addTask(

      title:
          titleController.text,

      description:
          descriptionController.text,

      startDate:
          startDateController.text,

      endDate:
          endDateController.text,

      status:
          selectedStatus,

      priority:
          selectedPriority,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        backgroundColor:
            kThirdColor,

        behavior:
            SnackBarBehavior.floating,

        content: const Text(
          "Task Created Successfully",
        ),
      ),
    );

    Navigator.pop(context);
  }

  /// SIMPLE TEXTFIELD
  Widget customTextField({

    required TextEditingController
        controller,

    required String hintText,

    required IconData icon,

    required int maxLines,

    required String? Function(
      String?,
    )
        validator,
  }) {

    return Container(

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border: Border.all(
          color:
              Colors.grey.shade300,
        ),
      ),

      child: TextFormField(

        controller: controller,

        maxLines: maxLines,

        validator: validator,

        decoration: InputDecoration(

          hintText: hintText,

          prefixIcon: Icon(
            icon,
            color: kThirdColor,
          ),

          border: InputBorder.none,

          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  /// SIMPLE DROPDOWN
  Widget customDropdown({

    required String value,

    required List<String> items,

    required Function(String?)
        onChanged,
  }) {

    return Container(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border: Border.all(
          color:
              Colors.grey.shade300,
        ),
      ),

      child: DropdownButtonHideUnderline(

        child: DropdownButton<String>(

          value: value,

          isExpanded: true,

          icon: Icon(
            Icons.keyboard_arrow_down,
            color: kThirdColor,
          ),

          dropdownColor: Colors.white,

          borderRadius:
              BorderRadius.circular(14),

          menuMaxHeight: 250,

          items: items.map((e) {

            Color bgColor =
                Colors.grey.shade100;

            Color textColor =
                Colors.black;

            IconData icon =
                Icons.circle;

            /// PRIORITY
            if (e == "Low") {

              bgColor =
                  const Color(
                      0xffE8F5E9);

              textColor =
                  const Color(
                      0xff2E7D32);

              icon = Icons
                  .arrow_downward_rounded;
            }

            if (e == "Medium") {

              bgColor =
                  const Color(
                      0xffFFF3E0);

              textColor =
                  const Color(
                      0xffEF6C00);

              icon =
                  Icons.remove_rounded;
            }

            if (e == "High") {

              bgColor =
                  const Color(
                      0xffFFEBEE);

              textColor =
                  const Color(
                      0xffD32F2F);

              icon = Icons
                  .priority_high_rounded;
            }

            /// STATUS
            if (e == "Todo") {

              bgColor =
                  const Color(
                      0xffE3F2FD);

              textColor =
                  const Color(
                      0xff1565C0);

              icon = Icons
                  .pending_actions_rounded;
            }

            if (e == "In Progress") {

              bgColor =
                  const Color(
                      0xffF3E5F5);

              textColor =
                  const Color(
                      0xff7B1FA2);

              icon = Icons
                  .timelapse_rounded;
            }

            if (e == "Completed") {

              bgColor =
                  const Color(
                      0xffE8F5E9);

              textColor =
                  const Color(
                      0xff2E7D32);

              icon = Icons
                  .check_circle_rounded;
            }

            return DropdownMenuItem(

              value: e,

              child: Container(

                width: double.infinity,

                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),

                margin:
                    const EdgeInsets
                        .symmetric(
                  vertical: 4,
                ),

                decoration:
                    BoxDecoration(

                  color: bgColor,

                  borderRadius:
                      BorderRadius
                          .circular(
                    10,
                  ),
                ),

                child: Row(
                  children: [

                    Icon(
                      icon,
                      color:
                          textColor,
                      size: 18,
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Text(
                      e,

                      style:
                          TextStyle(
                        color:
                            textColor,
                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),

          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          backgroundColor,

      appBar: AppBar(

        elevation: 0,

        centerTitle: true,

        backgroundColor:
            kThirdColor,

        title: const Text(

          "Create Task",

          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(20),

          child: Form(

            key: formKey,

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                /// TITLE
                const Text(

                  "Task Title",

                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                customTextField(

                  controller:
                      titleController,

                  hintText:
                      "Enter task title",

                  icon:
                      Icons.title,

                  maxLines: 1,

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return "Enter title";
                    }

                    return null;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                /// DESCRIPTION
                const Text(

                  "Description",

                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                customTextField(

                  controller:
                      descriptionController,

                  hintText:
                      "Enter description",

                  icon:
                      Icons.notes,

                  maxLines: 4,

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return "Enter description";
                    }

                    return null;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                /// DATES
                Row(
                  children: [

                    Expanded(
                      child:
                          GestureDetector(

                        onTap: () {

                          pickDate(
                            startDateController,
                          );
                        },

                        child:
                            AbsorbPointer(

                          child:
                              customTextField(

                            controller:
                                startDateController,

                            hintText:
                                "Start Date",

                            icon: Icons
                                .calendar_today,

                            maxLines: 1,

                            validator:
                                (value) {

                              if (value ==
                                      null ||
                                  value
                                      .isEmpty) {

                                return "Select";
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 14,
                    ),

                    Expanded(
                      child:
                          GestureDetector(

                        onTap: () {

                          pickDate(
                            endDateController,
                          );
                        },

                        child:
                            AbsorbPointer(

                          child:
                              customTextField(

                            controller:
                                endDateController,

                            hintText:
                                "End Date",

                            icon: Icons
                                .event,

                            maxLines: 1,

                            validator:
                                (value) {

                              if (value ==
                                      null ||
                                  value
                                      .isEmpty) {

                                return "Select";
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                /// STATUS
                const Text(

                  "Status",

                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                customDropdown(

                  value:
                      selectedStatus,

                  items: const [
                    "Todo",
                    "In Progress",
                    "Completed",
                  ],

                  onChanged: (value) {

                    setState(() {

                      selectedStatus =
                          value!;
                    });
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                /// PRIORITY
                const Text(

                  "Priority",

                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                customDropdown(

                  value:
                      selectedPriority,

                  items: const [
                    "Low",
                    "Medium",
                    "High",
                  ],

                  onChanged: (value) {

                    setState(() {

                      selectedPriority =
                          value!;
                    });
                  },
                ),

                const SizedBox(
                  height: 40,
                ),

                /// BUTTON
                SizedBox(

                  width: double.infinity,

                  height: 55,

                  child: ElevatedButton(

                    style:
                        ElevatedButton
                            .styleFrom(

                      elevation: 0,

                      backgroundColor:
                          kThirdColor,

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius
                                .circular(
                          14,
                        ),
                      ),
                    ),

                    onPressed: () async {

                      if (formKey
                          .currentState!
                          .validate()) {

                        await saveTask();
                      }
                    },

                    child: const Text(

                      "Create Task",

                      style: TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}