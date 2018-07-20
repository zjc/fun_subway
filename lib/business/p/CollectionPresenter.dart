import 'package:fun_subway/business/beans/ImageListBean.dart';
import 'package:fun_subway/business/model/ImageBeanModel.dart';
import 'package:fun_subway/business/view/ImageBeanView.dart';
import 'package:fun_subway/framework/LoadMorePresenter.dart';

class CollectionPresenter
    extends LoadMorePresenter<ImageBeanView, ImageBeanModel> {
  @override
  void loadMore() {
    if (_imageListBean != null) {
      loadCollection(_imageListBean.page + 1);
    }
  }

  ImageListBean _imageListBean;

  int _pageSize = 30;

  void fetchData() {
    loadCollection(1);
  }

  void loadCollection(int pageNum) {
    model.fetchCollection(pageNum, _pageSize).then((responseBean) {
      if (responseBean.isSuccess()) {
        _imageListBean = responseBean.data;
        getView().updateList(_imageListBean?.rows);
      }
    });
  }

  @override
  ImageBeanModel newInstance() {
    return ImageBeanModel();
  }
}
