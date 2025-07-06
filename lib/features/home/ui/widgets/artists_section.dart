import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamsa/core/helpers/extensions.dart';
import 'package:lamsa/features/home/data/model/artist_model.dart';
import 'package:lamsa/features/home/ui/widgets/artists_card.dart';
import 'package:lamsa/features/home/ui/widgets/section_header.dart';

class ArtistsSection extends StatelessWidget {
  const ArtistsSection({super.key, required this.artists});
  final List<ArtistModel> artists;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'الفنانون', onMorePressed: () {}),
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
