// ignore_for_file: deprecated_member_use



import 'package:intl/intl.dart';

import '../../core/routes/exports.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  /// COLORS
  static const primary = Color(0xff050b2c);

  static const secondary = Color(0xff24558f);

  static const accent = Color(0xff3986E2);

  static const bgColor = Color(0xffF5F7FB);

  late AnimationController _animationController;

  DateTime selectedDay = DateTime.now();

  int selectedTab = 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 900,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  /// FILTER TASKS BY DATE
  List<TaskModel> getTasksByDate(
    List<TaskModel> tasks,
  ) {
    return tasks.where((task) {
      try {
        final startDate = DateFormat("d/M/yyyy").parse(
          task.startDate,
        );

        final endDate = DateFormat("d/M/yyyy").parse(
          task.endDate,
        );

        final currentDate = DateTime(
          selectedDay.year,
          selectedDay.month,
          selectedDay.day,
        );

        final start = DateTime(
          startDate.year,
          startDate.month,
          startDate.day,
        );

        final end = DateTime(
          endDate.year,
          endDate.month,
          endDate.day,
        );

        return currentDate.isAfter(
              start.subtract(
                const Duration(
                  days: 1,
                ),
              ),
            ) &&
            currentDate.isBefore(
              end.add(
                const Duration(
                  days: 1,
                ),
              ),
            );
      } catch (e) {
        return false;
      }
    }).toList();
  }

  /// DYNAMIC TITLE
  String getDynamicTitle() {
    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final selected = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
    );

    if (selected == today) {
      return "Today's Tasks";
    }

    if (selected ==
        today.add(
          const Duration(
            days: 1,
          ),
        )) {
      return "Tomorrow Tasks";
    }

    if (selected ==
        today.subtract(
          const Duration(
            days: 1,
          ),
        )) {
      return "Yesterday Tasks";
    }

    return DateFormat(
      "dd MMM yyyy",
    ).format(selectedDay);
  }

  /// AUTO CHANGE TAB
  void updateTabByDate(
    TaskProvider provider,
  ) {
    final todo = getTasksByDate(
      provider.todoTasks,
    );

    final progress = getTasksByDate(
      provider.inProgressTasks,
    );

    final done = getTasksByDate(
      provider.completedTasks,
    );

    if (todo.isNotEmpty) {
      selectedTab = 0;
    } else if (progress.isNotEmpty) {
      selectedTab = 1;
    } else if (done.isNotEmpty) {
      selectedTab = 2;
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final provider = Provider.of<TaskProvider>(
      context,
    );
  

    List<TaskModel> currentTasks = [];

    if (selectedTab == 0) {
      currentTasks = getTasksByDate(
        provider.todoTasks,
      );
    } else if (selectedTab == 1) {
      currentTasks = getTasksByDate(
        provider.inProgressTasks,
      );
    } else {
      currentTasks = getTasksByDate(
        provider.completedTasks,
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: accent,
        elevation: 10,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateTask(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _animationController,
          child: RefreshIndicator(
            color: accent,
            backgroundColor: Colors.white,
            strokeWidth: 3,
            displacement: 80,
            onRefresh: () async {
              await Future.delayed(
                const Duration(
                  seconds: 1,
                ),
              );

              setState(() {});
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// PROFILE
                        buildProfileCard(),

                        const SizedBox(
                          height: 22,
                        ),

                        /// STATS
                        Row(
                          children: [
                            Expanded(
                              child: buildStatCard(
                                title: "Todo",
                                count: provider.todoTasks.length,
                                icon: Icons.pending_actions,
                                color: kOrange,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: buildStatCard(
                                title: "Progress",
                                count: provider.inProgressTasks.length,
                                icon: Icons.autorenew,
                                color: accent,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: buildStatCard(
                                title: "Done",
                                count: provider.completedTasks.length,
                                icon: Icons.check_circle,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 25,
                        ),

                        /// CALENDAR
                        buildCalendar(),

                        const SizedBox(
                          height: 25,
                        ),

                        /// TABS
                        buildTabs(),

                        const SizedBox(
                          height: 25,
                        ),

                        /// TITLE
                        Text(
                          getDynamicTitle(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primary,
                          ),
                        ),

                        const SizedBox(
                          height: 18,
                        ),

                        /// TASKS
                        currentTasks.isEmpty
                            ? buildEmptyWidget()
                            : ListView.builder(
                                itemCount: currentTasks.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (
                                  context,
                                  index,
                                ) {
                                  final task = currentTasks[index];

                                  return TweenAnimationBuilder(
                                    duration: Duration(
                                      milliseconds: 400 + (index * 100),
                                    ),
                                    tween: Tween<double>(
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
                                          50 * (1 - value),
                                        ),
                                        child: Opacity(
                                          opacity: value,
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: TaskCardWidget(
                                      task: task,
                                      onDelete: () {
                                        Provider.of<TaskProvider>(context,
                                                listen: false)
                                            .deleteTask(
                                          task.id,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),

                        const SizedBox(
                          height: 120,
                        ),
                      ],
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

  /// PROFILE CARD
Widget buildProfileCard() {

  final authProvider =
      Provider.of<AuthProvider>(context);

  return Container(
    padding: const EdgeInsets.all(
      20,
    ),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          primary,
          secondary,
          accent,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(
        30,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withOpacity(
            0.25,
          ),
          blurRadius: 20,
          offset: const Offset(
            0,
            8,
          ),
        ),
      ],
    ),
    child: Row(
      children: [

        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(
              0.15,
            ),
            borderRadius: BorderRadius.circular(
              22,
            ),
          ),
          child: const Icon(
            Icons.person,
            color: Colors.white,
            size: 38,
          ),
        ),

        const SizedBox(
          width: 16,
        ),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(
                "Welcome Back 👋",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),

              const SizedBox(
                height: 6,
              ),

              Text(
                authProvider.userEmail,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  /// STAT CARD
  Widget buildStatCard({
    required String title,
    required int count,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(
        16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          26,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(
              0.12,
            ),
            blurRadius: 15,
            offset: const Offset(
              0,
              6,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(
              10,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(
                0.12,
              ),
              borderRadius: BorderRadius.circular(
                14,
              ),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: primary,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  /// CALENDAR
  Widget buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(
        16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          28,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.04,
            ),
            blurRadius: 10,
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2024),
        lastDay: DateTime.utc(2030),
        focusedDay: selectedDay,
        calendarFormat: CalendarFormat.week,
        availableCalendarFormats: const {
          CalendarFormat.week: 'Week',
        },
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primary,
          ),
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: primary,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: primary,
          ),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        selectedDayPredicate: (day) {
          return isSameDay(
            selectedDay,
            day,
          );
        },
        onDaySelected: (
          selected,
          focused,
        ) {
          setState(() {
            selectedDay = selected;

            updateTabByDate(
              Provider.of<TaskProvider>(
                context,
                listen: false,
              ),
            );
          });
        },
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          todayDecoration: BoxDecoration(
            color: accent.withOpacity(
              0.25,
            ),
            shape: BoxShape.circle,
          ),
          selectedDecoration: const BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
          ),
          weekendTextStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          defaultTextStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          todayTextStyle: const TextStyle(
            color: primary,
            fontWeight: FontWeight.bold,
          ),
          selectedTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// TABS
  Widget buildTabs() {
    final tabs = [
      "Todo",
      "Progress",
      "Done",
    ];

    return Container(
      padding: const EdgeInsets.all(
        6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) {
            final isSelected = selectedTab == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTab = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? accent : Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// EMPTY
  Widget buildEmptyWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        40,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.task_alt,
            size: 70,
            color: accent.withOpacity(
              0.4,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          const Text(
            "No Tasks Available",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
