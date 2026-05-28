// ignore_for_file: use_build_context_synchronously

import 'package:taskmanager/core/routes/exports.dart';

class EditTaskPage extends StatefulWidget {

  final TaskModel task;

  const EditTaskPage({
    super.key,
    required this.task,
  });

  @override
  State<EditTaskPage> createState() =>
      _EditTaskPageState();
}

class _EditTaskPageState
    extends State<EditTaskPage> {

  final formKey =
      GlobalKey<FormState>();

  /// CONTROLLERS
  late TextEditingController
      titleController;

  late TextEditingController
      descriptionController;

  late TextEditingController
      startDateController;

  late TextEditingController
      endDateController;

  /// DROPDOWN
  late String selectedStatus;

  late String selectedPriority;

  /// HIVE BOX
  final Box<TaskModel> taskBox =
      Hive.box<TaskModel>(
    "taskBox",
  );

  /// COLORS
 

  final Color backgroundColor =
      const Color(0xffF5F7FB);

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(
      text: widget.task.title,
    );

    descriptionController =
        TextEditingController(
      text:
          widget.task.description,
    );

    startDateController =
        TextEditingController(
      text:
          widget.task.startDate,
    );

    endDateController =
        TextEditingController(
      text:
          widget.task.endDate,
    );

    /// STATUS
    if (widget.task.status ==
        "inprogress") {

      selectedStatus =
          "In Progress";
    } else if (widget.task.status ==
        "completed") {

      selectedStatus =
          "Completed";
    } else {

      selectedStatus = "Todo";
    }

    /// PRIORITY
    selectedPriority =
        widget.task.priority;
  }

  @override
  void dispose() {

    titleController.dispose();

    descriptionController
        .dispose();

    startDateController.dispose();

    endDateController.dispose();

    super.dispose();
  }

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

  /// UPDATE TASK
  Future<void> updateTask() async {

    widget.task.title =
        titleController.text;

    widget.task.description =
        descriptionController.text;

    widget.task.startDate =
        startDateController.text;

    widget.task.endDate =
        endDateController.text;

    widget.task.status =
        selectedStatus
            .toLowerCase()
            .replaceAll(" ", "");

    widget.task.priority =
        selectedPriority;

    await widget.task.save();

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        backgroundColor:
            kThirdColor,

        content: Text(
          "Task Updated Successfully",
        ),
      ),
    );

    Navigator.pop(context);
  }

  /// TEXTFIELD
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
            BorderRadius.circular(
          14,
        ),

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

          border:
              InputBorder.none,

          contentPadding:
              const EdgeInsets
                  .symmetric(

            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  /// DROPDOWN
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
            BorderRadius.circular(
          14,
        ),

        border: Border.all(
          color:
              Colors.grey.shade300,
        ),
      ),

      child:
          DropdownButtonHideUnderline(

        child:
            DropdownButton<String>(

          value: value,

          isExpanded: true,

          icon: const Icon(
            Icons
                .keyboard_arrow_down,
            color: kThirdColor,
          ),

          items: items.map((e) {

            return DropdownMenuItem(

              value: e,

              child: Text(

                e,

                style:
                    const TextStyle(

                  fontWeight:
                      FontWeight
                          .w600,
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

        flexibleSpace: Container(

          decoration:
              const BoxDecoration(

            gradient:
                LinearGradient(

              colors: [

                 kThirdColor,

                kThirdColor,
              ],
            ),
          ),
        ),

        title: const Text(

          "Edit Task",

          style: TextStyle(

            color: Colors.white,

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(

        child:
            SingleChildScrollView(

          padding:
              const EdgeInsets.all(
            20,
          ),

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
                      "Enter title",

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

                            icon:
                                Icons.event,

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

                    onPressed: () {

                      if (formKey
                          .currentState!
                          .validate()) {

                        updateTask();
                      }
                    },

                    child: const Text(

                      "Update Task",

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