class NumberUtils {
  static const List<int> _arabianRomanNumbers = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];

  static const List<String> _romanNumbers = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];

  static String intToRoman(int input) {
    var num = input + 1;

    assert(num > 0);

    final builder = StringBuffer();
    for (var a = 0; a < _arabianRomanNumbers.length; a++) {
      final times = (num / _arabianRomanNumbers[a]).truncate(); // equals 1 only when arabianRomanNumbers[a] = num
      builder.write(_romanNumbers[a] * times);
      num -= times * _arabianRomanNumbers[a]; // subtract previous roman number value from num
    }
    return builder.toString();
  }
}
