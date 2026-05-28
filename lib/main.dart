import 'package:taskmanager/core/routes/exports.dart';

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: appProviders,

      child: ScreenUtilInit(

        designSize:
            const Size(360, 800),

        minTextAdapt: true,

        splitScreenMode: true,

        builder: (context, child) {

          return MaterialApp(

            debugShowCheckedModeBanner:
                false,

            title: "TaskManager",

            theme: AppTheme.lightTheme,

            home: FutureBuilder(

              future:
                  Provider.of<AuthProvider>(
                context,
                listen: false,
              ).checkLogin(),

              builder: (
                context,
                snapshot,
              ) {

                final authProvider =
                    Provider.of<AuthProvider>(
                  context,
                );

                if (snapshot.connectionState ==
                    ConnectionState
                        .waiting) {

                  return const Scaffold(

                    body: Center(

                      child:
                          CircularProgressIndicator(),
                    ),
                  );
                }

                /// IF LOGGED IN
                if (authProvider
                    .isLoggedIn) {

                  return const BottomNavbar();
                }

                /// LOGIN SCREEN
                return const LoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}