//18500 -> 18,500
String formatNaira(int amount) {
  final str = amount.toString();
  final buffer = StringBuffer();

  for (int i = 0; i < str.length; i++) {
    final position = str.length - i;
    buffer.write(str[i]);
    //insert comma every 3 digits from the right
    if (position > 1 && position % 3 == 1) {
      buffer.write(',');
    }
  }

  return 'NGN ${buffer.toString()}';
}

String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}