// ignore_for_file: use_build_context_synchronously, deprecated_member_use





import 'package:taskmanager/core/routes/exports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

  /// COLORS
  static const primaryColor = Color(0xff0F172A);

  static const secondaryColor = Color(0xff1E3A8A);

  static const accentColor = Color(0xff3B82F6);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),

          child: Form(
            key: formKey,

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 40),

                /// LOGO + APP NAME
                Center(
                  child: Column(
                    children: [

                      

                      const SizedBox(height: 30),

                      /// APP NAME
                      ShaderMask(
                        shaderCallback:
                            (bounds) =>
                                const LinearGradient(
                          colors: [
                            primaryColor,
                            accentColor,
                          ],
                        ).createShader(bounds),

                        child: const Text(
                          "TaskManager",

                          style: TextStyle(
                            fontSize: 34,
                            fontWeight:
                                FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Manage your daily tasks easily",
                        style: TextStyle(
                          fontSize: 15,
                          color:
                              Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                /// LOGIN CARD
                Container(
                  padding: const EdgeInsets.all(
                    22,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(24),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(
                          0,
                          6,
                        ),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(
                        "Welcome Back 👋",

                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Login to continue",
                        style: TextStyle(
                          fontSize: 15,
                          color:
                              Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// EMAIL
                      const Text(
                        "Email",
                        style: TextStyle(
                          fontWeight:
                              FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller:
                            emailController,

                        hintText:
                            "Enter email",

                        prefixIcon:
                            Icons.email_outlined,

                        keyboardType:
                            TextInputType
                                .emailAddress,

                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return "Please enter email";
                          }

                          if (!RegExp(
                            r'^[^@]+@[^@]+\.[^@]+',
                          ).hasMatch(value)) {
                            return "Enter valid email";
                          }

                          return null;
                        },

                        maxLines: 1,
                      ),

                      const SizedBox(height: 24),

                      /// PASSWORD
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontWeight:
                              FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller:
                            passwordController,

                        hintText:
                            "Enter password",

                        prefixIcon:
                            Icons.lock_outline,

                        obscureText:
                            obscurePassword,

                        suffixIcon:
                            IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword =
                                  !obscurePassword;
                            });
                          },

                          icon: Icon(
                            obscurePassword
                                ? Icons
                                    .visibility_off
                                : Icons
                                    .visibility,

                            color:
                                secondaryColor,
                          ),
                        ),

                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return "Please enter password";
                          }

                          if (value.length < 6) {
                            return "Password must be 6 characters";
                          }

                          return null;
                        },

                        maxLines: 1,
                      ),

                      const SizedBox(height: 35),

                      /// LOGIN BUTTON
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            16,
                          ),

                          gradient:
                              const LinearGradient(
                            colors: [
                              primaryColor,
                              secondaryColor,
                              accentColor,
                            ],
                          ),
                        ),

                        child: CustomButton(
                          title: "Login",

                          isLoading:
                              provider.isLoading,

                          onTap: () async {

                            if (!formKey
                                .currentState!
                                .validate()) {
                              return;
                            }

                            bool success =
                                await provider
                                    .login(
                              email:
                                  emailController
                                      .text
                                      .trim(),

                              password:
                                  passwordController
                                      .text
                                      .trim(),
                            );

                            if (success) {

                              Navigator
                                  .pushReplacement(
                                context,

                                MaterialPageRoute(
                                  builder: (_) =>
                                      const BottomNavbar(),
                                ),
                              );

                            } else {

                              ScaffoldMessenger
                                      .of(context)
                                  .showSnackBar(

                                SnackBar(
                                  backgroundColor:
                                      Colors.red,

                                  content:
                                      const Text(
                                    "Invalid Credentials",
                                  ),

                                  behavior:
                                      SnackBarBehavior
                                          .floating,

                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      14,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
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
}