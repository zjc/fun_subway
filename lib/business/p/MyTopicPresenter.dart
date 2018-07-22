import 'package:fun_subway/business/model/TopicModel.dart';
import 'package:fun_subway/business/view/MyTopicView.dart';
import 'package:fun_subway/framework/BasePresenter.dart';
import 'package:fun_subway/framework/LoadMorePresenter.dart';

class MyTopicPresenter extends LoadMorePresenter<MyTopicView, TopicModel> {
  @override
  TopicModel newInstance() {
    return new TopicModel();
  }

  int pageNum = 1;

  int pageSize = 10;


  void fetchData(){
    pageNum = 1;
    fetchMyTopic(pageNum);
  }

  void fetchMyTopic(int page) {
    model.fetchMyFollowTopics(page, pageSize).then((responseBean) {
      if (responseBean.isSuccess()) {
        getView()?.getMyTopics(responseBean.data.topics);
      }
    });
  }

  @override
  void loadMore() {
    pageNum++;
    fetchMyTopic(pageNum);
  }
}
