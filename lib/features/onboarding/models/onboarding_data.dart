
class OnboardingData {
  final String title;
  final String subtitle;
  final String imagePath;

  const OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imagePath
  });
}

const List<OnboardingData> onboardingSlides = [
  OnboardingData(
    title: 'Get bus tickets from\nanywhere without hassle',
    subtitle: 'Just book through GOGOBUS and get tickets\nwithout the hassle of coming to our agents.',
    imagePath: 'assets/images/onboarding_1.png',
  ),
  OnboardingData(
    title: 'Get a bonus on every ticket\npurchase transaction',
    subtitle: 'Collect points earned from each ticket purchase\nand redeem them for reward vouchers.',
    imagePath: 'assets/images/onboarding_2.png',
  ),
  OnboardingData(
    title: 'Easily track your current\nlocation & trip statuses',
    subtitle: 'No need to worry about missing your destination.\nWe provide a Live Tracking feature.',
    imagePath: 'assets/images/onboarding_3.png',
  ),
];