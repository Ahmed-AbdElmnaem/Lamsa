import 'package:easy_localization/easy_localization.dart';
import 'package:lamsa/core/localization/locale_keys.dart';
import 'package:lamsa/core/utils/assets_manager.dart';
import 'package:lamsa/features/home/data/model/category_model.dart';

List<CategoryModel> kFakeCategories = [
  CategoryModel(
    id: 'makeup',
    iconPath: AssetsManager.makeup,
    label: LocaleKeys.makeup.tr(),
  ),
  CategoryModel(
    id: 'hair',
    iconPath: AssetsManager.haircut,
    label: LocaleKeys.hair.tr(),
  ),
  CategoryModel(
    id: 'skin',
    iconPath: AssetsManager.skincare,
    label: LocaleKeys.skin_care.tr(),
  ),
  CategoryModel(
    id: 'fashion',
    iconPath: AssetsManager.fashiondesign,
    label: LocaleKeys.fashion_design.tr(),
  ),
  CategoryModel(
    id: 'perfume',
    iconPath: AssetsManager.perfume,
    label: LocaleKeys.perfume.tr(),
  ),
  CategoryModel(
    id: 'accessories',
    iconPath: AssetsManager.accessories,
    label: LocaleKeys.accessories.tr(),
  ),

  CategoryModel(
    id: 'dress',
    iconPath: AssetsManager.weddingdress,
    label: LocaleKeys.dress.tr(),
  ),
];
