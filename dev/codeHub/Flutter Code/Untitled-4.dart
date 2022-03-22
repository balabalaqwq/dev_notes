class Utils {
  static void calculateDaysBetweenDates(String begin, String end) {
    DateTime startDate = DateTime.parse(begin);
    DateTime endDate = DateTime.parse(end);
    Duration difference = endDate.difference(startDate);
    print(difference.inDays);
  }
  //计算两个日期间隔天数
  static void calculateDaysBetweenDate(String begin, String end) {
    DateTime startDate = DateTime.parse(begin);
    DateTime endDate = DateTime.parse(end);
    Duration difference = endDate.difference(startDate);
    print(difference.inDays);
  }
  
}
void main() {
  Utils.calculateDaysBetweenDate("2019-01-01", "2019-02-02");
}