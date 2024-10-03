import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../services/auth_service.dart';
import '../../services/http_service.dart';
import '../../utils/regex.dart';
import '../../utils/snackbar_util.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/elevated_button_widget.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _signup(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      final authService = AuthService(
        HttpService(onUnauthorized: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/login',
            (Route<dynamic> route) => false,
          );
        }),
      );

      try {
        final response = await authService.registerUser(email, password);

        if (response.statusCode == 201) {
          if (context.mounted) {
            SnackBarUtil.showSuccessSnackBar(context, 'Đăng ký thành công');
            Navigator.pushNamed(context, '/login');
          }
        } else {
          final errorMessage = 'Đăng ký thất bại: ${response.body}';
          throw Exception(errorMessage);
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
          const SizedBox(height: 16),
          CustomTextField(
            controller: _confirmPasswordController,
            hintText: 'Xác nhận mật khẩu',
            obscureText: true,
            suffixIcon: Icons.visibility_off_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Xác nhận mật khẩu không được để trống';
              }
              if (value != _passwordController.text) {
                return 'Mật khẩu xác nhận không khớp';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoginText(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Bạn đã có tài khoản?",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          children: <TextSpan>[
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/login');
                },
              text: ' Đăng nhập',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: AppColors.deepBlue,
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
                'Tạo tài khoản',
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
                    const TextSpan(text: ' của bạn để đăng ký'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildFormFields(),
              ElevatedButtonWidget(
                text: 'Đăng ký',
                onPressed: () => _signup(context),
                backgroundColor: AppColors.deepBlue,
              ),
              const SizedBox(height: 16),
              _buildLoginText(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
