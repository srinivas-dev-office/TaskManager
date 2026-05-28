// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:taskmanager/core/routes/exports.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// ICON
              Container(
                height: 85,
                width: 85,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: kPrimaryColor,
                  size: 42,
                ),
              ),

              const SizedBox(height: 22),

              /// TITLE
              const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),

              const SizedBox(height: 10),

              /// MESSAGE
              Text(
                "Are you sure you want to logout from your account?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              /// BUTTONS
              Row(
                children: [

                  /// CANCEL
                  Expanded(
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(16),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(16),
                          border: Border.all(
                            color: kPrimaryColor
                                .withOpacity(0.2),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// LOGOUT
                  Expanded(
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(16),
                      onTap: () async {

                        /// LOGOUT FUNCTION
                        await context
                            .read<AuthProvider>()
                            .logout();

                        Navigator.pop(context);

                        /// NAVIGATE LOGIN SCREEN
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              color: kWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
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