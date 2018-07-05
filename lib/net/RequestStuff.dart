import 'dart:collection';

class RequestStuff {
  final Map<String, String> headerMap = new HashMap();

  void addHeader(String key, Object value) {
    headerMap[key] = value.toString();
  }

  Map<String, String> getHeaderMap() {
    return headerMap;
  }
}
