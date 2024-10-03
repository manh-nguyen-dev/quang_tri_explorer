import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../widgets/elevated_button_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundLogoSection(screenHeight),
          _buildContentSection(context, screenHeight, screenWidth),
        ],
      ),
    );
  }

  Widget _buildBackgroundLogoSection(double screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            color: Color.lerp(AppColors.deepBlue, Colors.white, 0.2),
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight / 6),
              child: Image.asset('assets/images/logo.png', height: 350),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection(
      BuildContext context, double screenHeight, double screenWidth) {
    return Positioned(
      left: 0,
      right: 0,
      top: screenHeight / 1.8,
      child: Container(
        height: screenHeight / 1.8,
        alignment: Alignment.topCenter,
        width: screenWidth,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const _WelcomeText(),
              const SizedBox(height: 14),
              const _DescriptionText(),
              const SizedBox(height: 16),
              _buildCreateAccountButton(context),
              const SizedBox(height: 16),
              _buildLoginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return ElevatedButtonWidget(
      text: 'Tạo tài khoản',
      onPressed: () {
        Navigator.pushNamed(context, '/signup');
      },
      backgroundColor: AppColors.deepBlue,
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButtonWidget(
      text: 'Đăng nhập',
      textColor: const Color(0xff1C1D1F),
      backgroundColor: const Color(0xffF6F8FA),
      onPressed: () {
        Navigator.pushNamed(context, '/login');
      },
    );
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Chào mừng bạn đến với khám phá, trải nghiệm du lịch Quảng Trị',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 28,
      ),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  const _DescriptionText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Chúng tôi phát triển ứng dụng này với mục đích quảng bá du lịch địa phương, giúp du khách khám phá và tìm hiểu về mảnh đất đầy lịch sử và dấu ấn của chiến tranh',
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }
}
