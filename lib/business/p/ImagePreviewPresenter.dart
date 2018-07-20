import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/business/model/ImageBeanModel.dart';
import 'package:fun_subway/business/view/ImagePreviewView.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class ImagePreviewPresenter
    extends BasePresenter<ImagePreviewView, ImageBeanModel> {
  @override
  ImageBeanModel newInstance() {
    return new ImageBeanModel();
  }

  void fav(ImageBean imageBean) {
    model.collectImages(imageBean.id.toString()).then((responseBean){
      if(responseBean.isSuccess()){
        getView()?.collectSuccess();
        return;
      }
      getView()?.collectFail(responseBean.error_reason);
    });
  }
}
