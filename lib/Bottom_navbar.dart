// ignore_for_file: deprecated_member_use



import 'package:taskmanager/core/routes/exports.dart';

class BottomNavbar extends StatefulWidget {

  const BottomNavbar({
    super.key,
  });

  @override
  State<BottomNavbar> createState() =>
      _BottomNavbarState();
}

class _BottomNavbarState
    extends State<BottomNavbar> {

  int currentIndex = 0;

  /// COLORS


  static const bgColor =
      Color(0xffF5F5F5);

  late final List<Widget> pages;

  @override
  void initState() {

    super.initState();

    pages = [

      const DashboardScreen(),

      const AllTaskScreen(),

      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: bgColor,

      body: IndexedStack(

        index: currentIndex,

        children: pages,
      ),

      bottomNavigationBar: Container(

        margin:
            const EdgeInsets.only(

          left: 16,

          right: 16,

          bottom: 16,
        ),

        padding:
            const EdgeInsets.symmetric(

          horizontal: 10,

          vertical: 12,
        ),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
            24,
          ),

          boxShadow: [

            BoxShadow(

              color:
                  Colors.black.withOpacity(
                0.08,
              ),

              blurRadius: 20,

              offset:
                  const Offset(
                0,
                8,
              ),
            ),
          ],
        ),

        child: Row(

          mainAxisAlignment:
              MainAxisAlignment
                  .spaceAround,

          children: [

            buildNavItem(

              index: 0,

              icon:
                  Icons.home_rounded,

              label: "Home",
            ),

            buildNavItem(

              index: 1,

              icon: Icons
                  .task_alt_rounded,

              label:
                  "All Task",
            ),

            buildNavItem(

              index: 2,

              icon: Icons
                  .person_rounded,

              label:
                  "Profile",
            ),
          ],
        ),
      ),
    );
  }

  /// NAV ITEM
  Widget buildNavItem({

    required int index,

    required IconData icon,

    required String label,

  }) {

    final isSelected =
        currentIndex == index;

    return InkWell(

      borderRadius:
          BorderRadius.circular(
        20,
      ),

      onTap: () {

        setState(() {

          currentIndex = index;
        });
      },

      child: AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 250,
        ),

        curve:
            Curves.easeInOut,

        padding:
            const EdgeInsets.symmetric(

          horizontal: 16,

          vertical: 8,
        ),

        child: Column(

          mainAxisSize:
              MainAxisSize.min,

          children: [

            AnimatedContainer(

              duration:
                  const Duration(
                milliseconds: 250,
              ),

              height: 38,

              width: 38,

              decoration: BoxDecoration(

                color: isSelected

                    ? AppTheme.lightTheme.primaryColorDark


                    : Colors
                        .transparent,

                shape:
                    BoxShape.circle,
              ),

              child: Icon(

                icon,

                size: 22,

                color: isSelected

                    ? Colors.white

                    : Colors.grey,
              ),
            ),

            const SizedBox(
              height: 6,
            ),

            Text(

              label,

              style: TextStyle(

                fontSize: 12,

                fontWeight:
                    FontWeight.w600,

                color: isSelected

                    ? AppTheme.lightTheme.primaryColorDark

                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

