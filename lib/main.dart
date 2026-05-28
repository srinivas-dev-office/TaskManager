import 'package:taskmanager/core/routes/exports.dart';
import 'package:taskmanager/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// INIT HIVE
  await Hive.initFlutter();

  /// REGISTER ADAPTERS
  Hive.registerAdapter(
    TaskModelAdapter(),
  );

  Hive.registerAdapter(
    AuthModelAdapter(),
  );

  /// OPEN BOXES
  await Hive.openBox<TaskModel>(
    "taskBox",
  );

  await Hive.openBox<AuthModel>(
    "authBox",
  );

  runApp(
    MultiProvider(
      providers: appProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<AuthProvider>().checkLogin();

      setState(() {
        isInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Consumer<AuthProvider>(
          builder: (
            context,
            authProvider,
            child,
          ) {
            /// LOADING
            if (!isInitialized) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                            gradient: const LinearGradient(
                              colors: [
                                Color(
                                  0xff0F172A,
                                ),
                                Color(
                                  0xff1E3A8A,
                                ),
                                Color(
                                  0xff3B82F6,
                                ),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.task_alt_rounded,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Task Manager",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(
                              0xff0F172A,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const CircularProgressIndicator(
                          color: Color(
                            0xff1E3A8A,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "TaskManager",
              theme: AppTheme.lightTheme,
              home: SplashScreen(),
            );
          },
        );
      },
    );
  }
}
