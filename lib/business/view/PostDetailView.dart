import 'package:fun_subway/framework/LoadMoreView.dart';
import 'package:fun_subway/utils/Pair.dart';

abstract class PostDetailView extends LoadMoreView{
  void fetchCallback(List<Pair> pairs);
}