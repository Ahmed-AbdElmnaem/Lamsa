import 'package:easy_localization/easy_localization.dart';
import 'package:lamsa/core/localization/locale_keys.dart';
import 'package:lamsa/features/home/ui/data/model/artist_model.dart';

/// Fake seed data for demo & prototyping.
///
/// Replace these values with live data from your backend / Firestore later.
final List<ArtistModel> kFakeArtists = [
  ArtistModel(
    id: 'artist_makeup_1',
    name: 'إيلي صعب',
    specialty: 'مصمم أزياء',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMVru69CfZvq8sUBPhXDbPLhjKygs3daSfj07e4vGX-iK4lTNrHZCzq8R_eQ25pkzQjto&usqp=CAU',
    rating: 4.9,
  ),
  ArtistModel(
    id: 'artist_hair_1',
    name: 'بسام فتوح ',
    specialty: 'خبير التجميل',
    imageUrl:
        'https://kulalusra.ae/uploads/imported_images/media/e2c9acf3f48d4b8cb59fd1d55f1a3e97.ashx',
    rating: 4.7,
  ),
  ArtistModel(
    id: 'artist_skin_1',
    name: 'نور أحمد',
    specialty: LocaleKeys.skin_care.tr(),
    imageUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=256&q=80',
    rating: 4.6,
  ),
  ArtistModel(
    id: 'artist_fashion_1',
    name: 'حنان النجادة',
    specialty: LocaleKeys.makeup.tr(),
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlRUW1Xee9kXwIxzbQTZ7hhErJcDfXFxJ3iw&s',
    rating: 4.8,
  ),
  ArtistModel(
    id: 'artist_perfume_1',
    name: 'ليلى خالد',
    specialty: LocaleKeys.perfume_and_accessories.tr(),
    imageUrl:
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=256&q=80',
    rating: 4.5,
  ),
  ArtistModel(
    id: 'artist_makeup_2',
    name: 'جنى علي',
    specialty: LocaleKeys.makeup.tr(),
    imageUrl:
        'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?auto=format&fit=crop&w=256&q=80',
    rating: 4.4,
  ),
];
