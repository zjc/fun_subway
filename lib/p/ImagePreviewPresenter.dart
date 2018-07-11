import 'package:fun_subway/model/ImagePreviewModel.dart';
import 'package:fun_subway/view/ImagePreviewView.dart';
import 'package:fun_subway/view/MyView.dart';
import 'package:fun_subway/model/MyModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class ImagePreviewPresenter
    extends BasePresenter<ImagePreviewView, ImagePreviewModel> {
  @override
  ImagePreviewModel newInstance() {
    return new ImagePreviewModel();
  }
}
