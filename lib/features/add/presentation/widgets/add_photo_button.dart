import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/configs/constants/app_images.dart';
import '../../../../core/presentation/blocs/app_theme_cubit/app_theme_cubit.dart';
import '../../../../core/presentation/pages/widgets/app_image.dart';
import '../../../../core/presentation/pages/widgets/app_text.dart';
import '../../../../core/theme/app_color_scheme.dart';

class AddPhotoButton extends StatelessWidget {
  const AddPhotoButton({Key? key, required this.querySize}) : super(key: key);
  final Size querySize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: querySize.width * 0.41,
        height: querySize.width * 0.41,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColorScheme.remi,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImage.asset(AppImages.vector.cameraIcon),
            SizedBox(height: 14),
            AppText(
              'Add photo',
              style: context.read<AppThemeCubit>().state.textTheme.addPhotoTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
