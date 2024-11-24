import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Password reset email sent! Please check your inbox.",
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: Colors.green,
      ));
      Navigator.pop(context); // Quay lại màn hình trước sau khi gửi thành công
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'invalid-email') {
        errorMessage = "Invalid email address.";
      } else if (e.code == 'user-not-found') {
        errorMessage = "No user found for this email.";
      } else {
        errorMessage = "An error occurred. Please try again.";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          errorMessage,
          style: const TextStyle(fontSize: 16.0),
        ),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Unexpected error: $e",
          style: const TextStyle(fontSize: 16.0),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80.0),
            const Text(
              "Forgot Password",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF273671),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Enter your email address below to receive a password reset link.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF707070),
              ),
            ),
            const SizedBox(height: 40.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Email Input
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFedf0f8),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      validator: _emailValidator,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Color(0xFFb2b7bf)),
                        border: InputBorder.none,
                        hintText: "Enter your email",
                        hintStyle: TextStyle(
                          color: Color(0xFFb2b7bf),
                          fontSize: 18.0,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 30.0),

                  // Send Reset Link Button
                  GestureDetector(
                    onTap: resetPassword,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF273671),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: const Center(
                        child: Text(
                          "Send Reset Link",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),

            // Go Back Link
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Back to Login",
                style: TextStyle(
                  color: Color(0xFF273671),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
