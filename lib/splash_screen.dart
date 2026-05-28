


import 'package:taskmanager/core/routes/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController
      _animationController;

  late Animation<double>
      _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(

      vsync: this,

      duration: const Duration(
        seconds: 2,
      ),
    );

    _scaleAnimation =
        Tween<double>(

      begin: 0.7,

      end: 1,
    ).animate(

      CurvedAnimation(

        parent: _animationController,

        curve: Curves.easeInOut,
      ),
    );

    _animationController.repeat(
      reverse: true,
    );

    /// CHECK LOGIN
    WidgetsBinding.instance
        .addPostFrameCallback((_) async {

      final authProvider =
          context.read<AuthProvider>();

      await authProvider.checkLogin();

      await Future.delayed(
        const Duration(seconds: 2),
      );

      if (!mounted) return;

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (context) =>

              authProvider.isLoggedIn
                  ? const BottomNavbar()
                  : const LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {

    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topLeft,

            end: Alignment.bottomRight,

            colors: [

              Color(0xff0F172A),

              Color(0xff1E3A8A),

              Color(0xff3B82F6),
            ],
          ),
        ),

        child: Center(

          child: Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              ScaleTransition(

                scale: _scaleAnimation,

                child: Container(

                  height: 120,

                  width: 120,

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      30,
                    ),

                    boxShadow: [

                      BoxShadow(

                        color: Colors.black
                            .withOpacity(
                          0.2,
                        ),

                        blurRadius: 20,

                        offset:
                            const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: const Icon(

                    Icons.task_alt_rounded,

                    size: 70,

                    color:
                        Color(0xff1E3A8A),
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              const Text(

                "Task Manager",

                style: TextStyle(

                  color: Colors.white,

                  fontSize: 32,

                  fontWeight:
                      FontWeight.bold,

                  letterSpacing: 1,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Text(

                "Manage your daily tasks easily",

                style: TextStyle(

                  color: Colors.white
                      .withOpacity(0.8),

                  fontSize: 16,
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              const SizedBox(

                height: 28,

                width: 28,

                child:
                    CircularProgressIndicator(

                  color: Colors.white,

                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}