import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/blocs/app_theme_cubit/app_theme_cubit.dart';
import '../../../../core/presentation/pages/widgets/app_image.dart';
import '../../../../core/presentation/pages/widgets/app_text.dart';

class CategoryItem extends StatelessWidget {
  final String text;
  final String icon;
  const CategoryItem({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: context.read<AppThemeCubit>().state.appColors.categoryItemBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          AppImage.network(
            icon,
            height: 24,
          ),
          SizedBox(width: 16),
          AppText(
            text,
            style: context.read<AppThemeCubit>().state.textTheme.browseCategoryTextStyle,
          )
        ],
      ),
    );
  }
}
