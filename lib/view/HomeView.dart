import 'package:fun_subway/framework/BaseView.dart';
import 'package:fun_subway/utils/Pair.dart';
abstract class HomeView extends BaseView{
  void callback(List<Pair> pairs);
}