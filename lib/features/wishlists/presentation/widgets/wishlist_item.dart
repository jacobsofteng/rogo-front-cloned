import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/configs/constants/app_images.dart';
import '../../../../core/presentation/blocs/app_theme_cubit/app_theme_cubit.dart';
import '../../../../core/presentation/pages/widgets/app_image.dart';
import '../../../../core/presentation/pages/widgets/app_text.dart';

class WishListItem extends StatelessWidget {
  final String image;

  const WishListItem({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 12),
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: context
            .read<AppThemeCubit>()
            .state
            .appColors()
            .productItemBackgroundColor(),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppImage.asset(
            image,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
            ),
            width: MediaQuery.of(context).size.width * 0.33, // overflow fix
            fit: BoxFit.cover,
            // width: double.infinity,
          ),
          SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText(
                      '\$50-\$1000',
                      style: context
                          .read<AppThemeCubit>()
                          .state
                          .textTheme()
                          .wishlistsProductItemPriceNumberTextStyle(),
                    ),
                    SizedBox(width: 4),
                    AppText(
                      'p/day',
                      style: context
                          .read<AppThemeCubit>()
                          .state
                          .textTheme()
                          .wishlistsProductItemPriceTextStyle(),
                    ),
                    context
                        .read<AppThemeCubit>()
                        .state
                        .appIcons()
                        .favoriteIcon(),
                  ],
                ),
                SizedBox(height: 5),
                Expanded(
                  child: AppText(
                    'Pioneer surfboards',
                    style: context
                        .read<AppThemeCubit>()
                        .state
                        .textTheme()
                        .wishlistsProductItemNameTextStyle(),
                  ),
                ),
                Row(
                  children: [
                    AppImage.asset(
                      AppImages.vector.location,
                      height: 8,
                    ),
                    SizedBox(width: 5),
                    AppText(
                      'Camas, WA',
                      style: context
                          .read<AppThemeCubit>()
                          .state
                          .textTheme()
                          .productItemLocationTextStyle(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
