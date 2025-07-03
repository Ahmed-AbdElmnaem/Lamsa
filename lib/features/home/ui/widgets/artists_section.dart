import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/core/theming/color_manager.dart';
import 'package:lamsa/core/theming/styles.dart';
import 'package:lamsa/features/home/ui/data/model/artist_model.dart';
import 'package:lamsa/features/home/ui/widgets/artists_card.dart';

class ArtistsSection extends StatelessWidget {
  const ArtistsSection({super.key, required this.artists});
  final List<ArtistModel> artists;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Text(
                'الفنانون',
                style: Styles.font18W600.copyWith(
                  color: ColorManager.mainColor,
                ),
              ),
              const Spacer(),
              TextButton(
                style: TextButton.styleFrom(
                  overlayColor: ColorManager.mainColor,
                ),
                onPressed: () {},
                child: Text(
                  'المزيد ..',
                  style: Styles.font16W500.copyWith(
                    color: ColorManager.mainColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        10.0.height,
        SizedBox(
          height: 140.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            separatorBuilder: (_, __) => 10.0.width,

            itemBuilder: (context, index) {
              final artist = artists[index];
              return ArtistCard(
                image: artist.imageUrl,
                rating: artist.rating ?? 0.0,
                specialty: artist.specialty,
                name: artist.name,
              );
            },
          ),
        ),
      ],
    );
  }
}
