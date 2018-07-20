import 'package:fun_subway/framework/BaseView.dart';
abstract class ImagePreviewView extends BaseView{
    void collectSuccess();

    void collectFail(String reason);
}