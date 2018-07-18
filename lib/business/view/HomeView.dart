import 'package:fun_subway/framework/LoadMoreView.dart';
import 'package:fun_subway/utils/Pair.dart';
abstract class HomeView extends LoadMoreView{
  void callback(List<Pair> pairs);
}