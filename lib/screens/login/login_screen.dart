import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../../constants/app_colors.dart';
import '../../services/auth_service.dart';
import '../../services/http_service.dart';
import '../../utils/regex.dart';
import '../../utils/snackbar_util.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/elevated_button_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      final authService = AuthService(HttpService());

      try {
        final response = await authService.loginUser(email, password);

        if (response.statusCode == 200) {
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (Route<dynamic> route) => false,
            );
          }
        }
      } catch (e) {
        if (!context.mounted) return;
        SnackBarUtil.showErrorSnackBar(context, 'Lỗi: $e');
      }
    }
  }

  Widget _buildFormFields() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        children: [
          CustomTextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'Email',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email không được để trống';
              } else if (!Regex.isEmail(value)) {
                return 'Sai định dạng email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _passwordController,
            hintText: 'Mật khẩu',
            obscureText: true,
            suffixIcon: Icons.visibility_off_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mật khẩu không được để trống';
              }
              if (!Regex.isPasswordAtLeast8Characters(value)) {
                return 'Mật khẩu ít nhất phải đạt 8 ký tự';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpText(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Bạn chưa có tài khoản?",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          children: <TextSpan>[
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/signup');
                },
              text: ' Đăng ký',
              style: TextStyle(
                color: AppColors.deepBlue,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppBar().preferredSize.height),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const SizedBox(
                  height: 40,
                  width: 40,
                  child: Icon(Icons.arrow_back),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Chào mừng quay trở lại',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  text: 'Nhập',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' email',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.deepBlue,
                      ),
                    ),
                    const TextSpan(text: ' &'),
                    TextSpan(
                      text: ' mật khẩu',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.deepBlue,
                      ),
                    ),
                    const TextSpan(text: ' của bạn để đăng nhập'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildFormFields(),
              ElevatedButtonWidget(
                text: 'Đăng nhập',
                onPressed: () => _login(context),
                backgroundColor: AppColors.deepBlue,
              ),
              const SizedBox(height: 16),
              _buildSignUpText(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
