class OnBoardingModel {
  String image, title, subTitle;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
  });
}

class OnBoardingController {
  int currentPage = 0;
  List<OnBoardingModel> model = [
    OnBoardingModel(
      title: "مرحبا بك في حصادك",
      image: "assets/images/on_boarding1.png",
      subTitle:
          "يسرنا ان نقدم لك مجموعه متنوعه من المنجات عالية الجودة التي تعمل على تحسين انتاجيه المحاصيل",
    ),
    OnBoardingModel(
      title: "عروض و خصومات",
      image: "assets/images/on_boarding2.png",
      subTitle: "يمكنك الاطلاع على العروض و الخصومات المختلفة على منتجاتنا",
    ),
    OnBoardingModel(
      title: "إبدأ بالتسوق الآن",
      image: "assets/images/on_boarding3.png",
      subTitle:
          "للبدأ في التسوق يمكنك الاطلاع على الفئات المختلفة او البحث , بمجرد اختيار المنتج الذي تريدة يمكنك طلبه فورا",
    ),
  ];
}
