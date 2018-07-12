import 'package:fun_subway/business/model/ImagePreviewModel.dart';
import 'package:fun_subway/business/view/ImagePreviewView.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class ImagePreviewPresenter
    extends BasePresenter<ImagePreviewView, ImagePreviewModel> {
  @override
  ImagePreviewModel newInstance() {
    return new ImagePreviewModel();
  }
}
