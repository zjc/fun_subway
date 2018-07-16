class BaseBean{

  static List<String> instanceStringList(List list) {
    List<String> newList;
    if (list != null && list.isNotEmpty) {
      newList = list.cast<String>();
    }
    return newList;
  }
}