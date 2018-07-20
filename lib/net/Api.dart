class Api{
  static const BASE_URL = "http://inner.51biaoqing.com/";

  static const COMMON_CONFIG = "common/config";

  static const HOME_FEED = "post/feed";

  static const LOGIN = "user/login";//手机/密码登录

  static const String LOGIN_BY_VERIFY_CODE = "user/codeLogin";//验证码登录

  static const String VERIFY_CODE = "shortMessage/code";

  static const String MAKE_MENU = "make/menu";//相册制图配置

  static const String HOT_SEARCH = "tag/search";//热门搜索

  static const String TOPIC_LIST = "topic/data";//热门话题

  static const String SEARCH_ASSOCIATION = "tag/similar";//联想词

  static const String SEARCH_RESULT_LIST = "image/list";//搜索结果列表

  static const String POST_DETAIL = "post/info";//帖子详情

  static const String COMMENT = "comment/info";//帖子评论

  static const String COLLECTION_LIST = "collection/list";//收藏列表

  static const String MY_WORKS = "user/image";//作品列表

  static String DELETE_COLLECTION = "collection/collect";//批量删除我的收藏
}