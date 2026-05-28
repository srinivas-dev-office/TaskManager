// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/task_provider.dart';
import 'package:taskmanager/widgets/task/TaskCardWidget .dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() =>
      _AllTaskScreenState();
}

class _AllTaskScreenState
    extends State<AllTaskScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  final TextEditingController
      searchController =
      TextEditingController();

  /// TAB DELAY CONTROL
  DateTime? lastTabChangeTime;

  /// COLORS
  final Color primaryColor =
      const Color(0xff050B2C);

  final Color secondaryColor =
      const Color(0xff24558F);

  final Color accentColor =
      const Color(0xff3986E2);

  @override
  void initState() {

    super.initState();

    _tabController = TabController(
      length: 3,
      vsync: this,
    );

    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {

    searchController.dispose();

    _tabController.dispose();

    super.dispose();
  }

  /// REFRESH
  Future<void> onRefresh() async {

    await Future.delayed(
      const Duration(milliseconds: 600),
    );

    setState(() {});
  }

  /// SEARCH FILTER
  List<dynamic> getFilteredTasks(
    List<dynamic> tasks,
  ) {

    return tasks.where((task) {

      final search =
          searchController.text
              .trim()
              .toLowerCase();

      return task.title
          .toString()
          .toLowerCase()
          .contains(search);

    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<TaskProvider>(

      builder: (
        context,
        provider,
        child,
      ) {

        final todoTasks =
            getFilteredTasks(
          provider.todoTasks,
        );

        final progressTasks =
            getFilteredTasks(
          provider.inProgressTasks,
        );

        final completedTasks =
            getFilteredTasks(
          provider.completedTasks,
        );

        return Scaffold(

          backgroundColor:
              const Color(
            0xffF5F7FB,
          ),

          /// APP BAR
          appBar: AppBar(

            elevation: 0,

            flexibleSpace: Container(

              decoration:
                  BoxDecoration(

                gradient:
                    LinearGradient(

                  colors: [

                    primaryColor,

                    secondaryColor,

                    accentColor,
                  ],
                ),
              ),
            ),

            centerTitle: true,

            title: const Text(

              "All Tasks",

              style: TextStyle(

                color:
                    Colors.white,

                fontWeight:
                    FontWeight.bold,

                fontSize: 22,
              ),
            ),
          ),

          body: Column(

            children: [

              /// TOP SECTION
              Container(

                padding:
                    const EdgeInsets.only(
                  bottom: 16,
                ),

                decoration:
                    BoxDecoration(

                  gradient:
                      LinearGradient(

                    colors: [

                      primaryColor,

                      secondaryColor,

                      accentColor,
                    ],
                  ),

                  borderRadius:
                      const BorderRadius.only(

                    bottomLeft:
                        Radius.circular(
                      24,
                    ),

                    bottomRight:
                        Radius.circular(
                      24,
                    ),
                  ),
                ),

                child: Column(

                  children: [

                    const SizedBox(
                      height: 10,
                    ),

                    /// SEARCH
                    Padding(

                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 16,
                      ),

                      child: Container(

                        height: 55,

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.white,

                          borderRadius:
                              BorderRadius
                                  .circular(
                            16,
                          ),
                        ),

                        child: TextField(

                          controller:
                              searchController,

                          decoration:
                              InputDecoration(

                            border:
                                InputBorder.none,

                            hintText:
                                "Search task...",

                            prefixIcon: Icon(

                              Icons.search,

                              color:
                                  accentColor,
                            ),

                            suffixIcon:
                                searchController
                                        .text
                                        .isNotEmpty

                                    ? IconButton(

                                        onPressed: () {

                                          searchController
                                              .clear();
                                        },

                                        icon:
                                            const Icon(
                                          Icons.close,
                                        ),
                                      )

                                    : null,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    /// TAB BAR
                    TabBar(
                      dividerHeight: 0,
                      

                      controller:
                          _tabController,

                      indicatorColor:
                          Colors.white,

                      indicatorWeight:
                          4,

                      labelColor:
                          Colors.white,

                      unselectedLabelColor:
                          Colors.white70,

                      labelStyle:
                          const TextStyle(

                        fontWeight:
                            FontWeight.bold,

                        fontSize: 16,
                      ),

                      tabs: const [

                        Tab(
                          text: "Todo",
                        ),

                        Tab(
                          text:
                              "In Progress",
                        ),

                        Tab(
                          text: "Done",
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// TAB VIEW
              Expanded(

                child: TabBarView(

                  controller:
                      _tabController,

                  physics:
                      const NeverScrollableScrollPhysics(),

                  children: [

                    buildTaskSection(
                      context,
                      "todo",
                      todoTasks,
                    ),

                    buildTaskSection(
                      context,
                      "inprogress",
                      progressTasks,
                    ),

                    buildTaskSection(
                      context,
                      "completed",
                      completedTasks,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// TASK SECTION
  Widget buildTaskSection(

    BuildContext context,

    String status,

    List currentTasks,

  ) {

    return RefreshIndicator(

      onRefresh: onRefresh,

      child: DragTarget<Map>(

        onAccept: (data) async {

          final provider =
              Provider.of<TaskProvider>(
            context,
            listen: false,
          );

          final draggedTask =
              data["task"];

          /// MOVE TASK
          await provider
              .moveTaskToStatus(

            id: draggedTask.id,

            newStatus: status,
          );

          setState(() {});
        },

        builder: (

          context,

          candidateData,

          rejectedData,

        ) {

          final isDragging =
              candidateData.isNotEmpty;

          return AnimatedContainer(

            duration:
                const Duration(
              milliseconds: 250,
            ),

            margin:
                const EdgeInsets.all(
              14,
            ),

            padding:
                const EdgeInsets.all(
              14,
            ),

            decoration:
                BoxDecoration(

              color: isDragging

                  ? accentColor
                      .withOpacity(
                    0.08,
                  )

                  : Colors.white,

              borderRadius:
                  BorderRadius.circular(
                24,
              ),

              border: Border.all(

                color: isDragging

                    ? accentColor

                    : Colors.grey
                        .shade300,

                width: 2,
              ),

              boxShadow: [

                BoxShadow(

                  color: Colors.black
                      .withOpacity(
                    0.05,
                  ),

                  blurRadius: 12,
                ),
              ],
            ),

            child: Column(

              children: [

                /// HEADER
                Row(

                  children: [

                    Container(

                      width: 14,

                      height: 14,

                      decoration:
                          BoxDecoration(

                        color: status ==
                                "todo"

                            ? Colors.orange

                            : status ==
                                    "inprogress"

                                ? Colors.blue

                                : Colors.green,

                        shape:
                            BoxShape.circle,
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(

                      child: Text(

                        status ==
                                "todo"

                            ? "Todo"

                            : status ==
                                    "inprogress"

                                ? "In Progress"

                                : "Completed",

                        style:
                            TextStyle(

                          fontSize: 20,

                          fontWeight:
                              FontWeight.bold,

                          color:
                              primaryColor,
                        ),
                      ),
                    ),

                    Container(

                      padding:
                          const EdgeInsets
                              .symmetric(

                        horizontal: 12,

                        vertical: 6,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            accentColor,

                        borderRadius:
                            BorderRadius
                                .circular(
                          30,
                        ),
                      ),

                      child: Text(

                        "${currentTasks.length}",

                        style:
                            const TextStyle(

                          color:
                              Colors.white,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                /// EMPTY
                if (currentTasks.isEmpty)

                  Expanded(

                    child: Center(

                      child: Text(

                        "Drop Tasks Here",

                        style: TextStyle(

                          color: Colors
                              .grey
                              .shade500,

                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                /// TASK LIST
                if (currentTasks.isNotEmpty)

                  Expanded(

                    child: ListView.builder(

                      physics:
                          const BouncingScrollPhysics(),

                      padding:
                          const EdgeInsets.only(
                        bottom: 120,
                      ),

                      itemCount:
                          currentTasks.length,

                      itemBuilder: (
                        context,
                        index,
                      ) {

                        final task =
                            currentTasks[index];

                        return TweenAnimationBuilder(

                          duration: Duration(

                            milliseconds:
                                400 +
                                    (index * 100),
                          ),

                          tween:
                              Tween<double>(

                            begin: 0,

                            end: 1,
                          ),

                          builder: (

                            context,

                            double value,

                            child,

                          ) {

                            return Transform.translate(

                              offset: Offset(

                                0,

                                50 *
                                    (1 -
                                        value),
                              ),

                              child: Opacity(

                                opacity:
                                    value,

                                child:
                                    child,
                              ),
                            );
                          },

                          child: Padding(

                            padding:
                                const EdgeInsets
                                    .only(
                              bottom: 14,
                            ),

                            child:
                                LongPressDraggable(

                              data: {
                                "task":
                                    task,
                              },

                              /// MOVE TAB ONE BY ONE
                              onDragUpdate:
                                  (details) {

                                final now =
                                    DateTime.now();

                                /// PREVENT FAST SWITCH
                                if (lastTabChangeTime !=
                                        null &&
                                    now
                                            .difference(
                                          lastTabChangeTime!,
                                        )
                                            .inMilliseconds <
                                        700) {
                                  return;
                                }

                                final screenWidth =
                                    MediaQuery.of(
                                  context,
                                ).size.width;

                                final dx =
                                    details
                                        .globalPosition
                                        .dx;

                                /// LEFT
                                if (dx < 60) {

                                  if (_tabController
                                          .index >
                                      0) {

                                    lastTabChangeTime =
                                        now;

                                    _tabController
                                        .animateTo(

                                      _tabController
                                              .index -
                                          1,
                                    );
                                  }
                                }

                                /// RIGHT
                                else if (dx >
                                    screenWidth -
                                        60) {

                                  if (_tabController
                                          .index <
                                      2) {

                                    lastTabChangeTime =
                                        now;

                                    _tabController
                                        .animateTo(

                                      _tabController
                                              .index +
                                          1,
                                    );
                                  }
                                }
                              },

                              /// DRAG UI
                              feedback:
                                  Material(

                                color: Colors
                                    .transparent,

                                child:
                                    SizedBox(

                                  width:
                                      MediaQuery.of(
                                    context,
                                  ).size.width -
                                          40,

                                  child:
                                      TaskCardWidget(

                                    task:
                                        task,

                                    onDelete:
                                        () {},
                                  ),
                                ),
                              ),

                              /// DRAGGING
                              childWhenDragging:
                                  Opacity(

                                opacity:
                                    0.35,

                                child:
                                    TaskCardWidget(

                                  task:
                                      task,

                                  onDelete:
                                      () {},
                                ),
                              ),

                              /// NORMAL CARD
                              child:
                                  TaskCardWidget(

                                task:
                                    task,

                                onDelete: () {

                                  Provider.of<
                                          TaskProvider>(
                                    context,
                                    listen:
                                        false,
                                  ).deleteTask(
                                    task.id,
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}