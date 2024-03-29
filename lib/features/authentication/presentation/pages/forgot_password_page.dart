import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../core/configs/constants/app_colors.dart';
import '../../../../core/configs/constants/app_images.dart';
import '../../../../core/form_models/email_form_model.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/presentation/blocs/app_theme_cubit/app_theme_cubit.dart';
import '../../../../core/presentation/pages/widgets/app_app_bar.dart';
import '../../../../core/presentation/pages/widgets/app_image.dart';
import '../../../../core/presentation/pages/widgets/app_loader.dart';
import '../../../../core/presentation/pages/widgets/app_text.dart';
import '../../../../core/presentation/pages/widgets/app_text_form_field.dart';
import '../../../../core/presentation/pages/widgets/simple_button.dart';
import '../../../../core/services/navigation_service.dart';
import '../blocs/forgot_password_cubit/forgot_password_cubit.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
          child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state.errorMessage.length > 0) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: AppText(state.errorMessage),
                  ),
                );
              }
              if (state.status == FormzStatus.submissionSuccess) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: AppText('Please check your email'),
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Center(child: AppImage.asset(AppImages.raster.forgotPasswordScreenMain)),
                    SizedBox(height: 15),
                    AppText('authentication.forgotPasswordPage.forgotPassword', fontSize: 36),
                    SizedBox(height: 12),
                    AppText('authentication.loginPage.yourEmail', fontSize: 14, color: AppColors.regentGray),
                    AppTextFormField(
                      onChanged: context.read<ForgotPasswordCubit>().updateEmail,
                      initialValue: state.email.value,
                      isInvalid: state.email.invalid,
                    ),
                    if (state.email.invalid)
                      AppText(
                        state.email.error == EmailFormModelValidationError.empty
                            ? 'validators.thisFieldIsRequired'
                            : 'validators.invalidEmail',
                        style: context.read<AppThemeCubit>().state.textTheme.inputErrorTextStyle,
                      ),
                    SizedBox(height: 40),
                    state.status == FormzStatus.submissionInProgress
                        ? SimpleButton(
                            child: AppLoader(reverse: true),
                          )
                        : SimpleButton(
                            text: 'authentication.forgotPasswordPage.submit',
                            onTap: context.read<ForgotPasswordCubit>().send,
                          ),
                    SizedBox(height: 67),
                    Center(
                      child: GestureDetector(
                        onTap: () => sl<NavigatorService>().pop(),
                        child: AppText(
                          'authentication.forgotPasswordPage.backToLogin',
                          color: AppColors.hollywoodCerise,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 28),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
