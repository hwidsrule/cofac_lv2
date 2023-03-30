import 'package:cofac_lv2/common/const/data.dart';

class DataUtils {
  static String strToUrl(String str) {
    return 'http://$ip$str';
  }

  static List<String> strToUrlList(List strList) {
    return strList.map((e) => strToUrl(e)).toList();
  }
}
