import 'package:flutter/material.dart';

const lightSage = Color(0xFFF0F2F0);
const warmGray = Color(0xFFEAEAEA);
const lightGray = Color(0xFFD1D5DB);
const blueishGray = Color(0xFF6B7280);
const accentColor = Color(0xFFA78BFA);
const textPrimary = Color(0xFF1F2937);

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightSage,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, size: 64, color: accentColor),
              const SizedBox(height: 16),
              const Text('Stitch AI',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Shared expenses, simplified.',
                  style: TextStyle(color: blueishGray)),
              const SizedBox(height: 32),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: warmGray,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: lightGray),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: warmGray,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: lightGray),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  shape: const StadiumBorder(),
                  minimumSize: const Size.fromHeight(56),
                ),
                onPressed: () {},
                child: const Text('Log In',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: blueishGray),
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                            color: accentColor, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

