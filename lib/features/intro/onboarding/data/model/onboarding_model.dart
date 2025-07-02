import 'package:lamsa/core/utils/assets_manager.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;

  const OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });

  static List<OnboardingModel> onboardingList = [
    OnboardingModel(
      image: AssetsManager.onboarding1,
      title: 'فستان أحلامك في لمسة',
      description:
          'تصفّحي آلاف الفساتين من أكبر الأتيليهات واخترى أنسب ستايل لمناسبتك.',
    ),

    OnboardingModel(
      image: AssetsManager.onboarding2,
      title: 'احجزي القياس في دقيقة',
      description: 'جداول زيارات مرنة، تأكيد فوري، وإشعارات تذكير قبل المعاد.',
    ),

    OnboardingModel(
      image: AssetsManager.onboarding3,
      title: 'ميكب أرتيست في متناولك',
      description: 'خبيرات مكياج وتصفيف شعر بتقييمات حقيقية وأسعار شفافة.',
    ),

    OnboardingModel(
      image: AssetsManager.onboarding4,
      title: 'تأجير أو شراء؟ براحتك',
      description: 'خيارات تأجير قصيرة أو شراء نهائي مع دفع آمن داخل التطبيق.',
    ),
  ];
}
