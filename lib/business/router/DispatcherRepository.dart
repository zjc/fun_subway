import 'dart:collection';

import 'package:fun_subway/business/router/FunAction.dart';
import 'package:fun_subway/business/router/FunScheme.dart';
import 'package:fun_subway/business/router/dispatchers/Dispatcher.dart';
import 'package:fun_subway/business/router/dispatchers/HttpDispatcher.dart';
import 'package:fun_subway/business/router/dispatchers/LoginInterceptDispatcher.dart';
import 'package:fun_subway/business/router/dispatchers/PostDetailDispatcher.dart';
import 'package:fun_subway/business/router/dispatchers/SearchDispatcher.dart';
import 'package:fun_subway/business/router/dispatchers/TemplateMakerDispatcher.dart';

class DispatcherRepository {
  static final DispatcherRepository _singleton =
      new DispatcherRepository._internal();

  factory DispatcherRepository() {
    return _singleton;
  }

  DispatcherRepository._internal() {
    init();
  }

  void init() {
    dispatcherHashMap = {};
    actionDispatcherHashMap = {};
    initDispatchers();
  }

  Map<String, Dispatcher> dispatcherHashMap;

  Map<String, Dispatcher> actionDispatcherHashMap;

  Dispatcher querySchemeDispatcher(String key) {
    return dispatcherHashMap[key];
  }

  Dispatcher queryActionDispatcher(String key) {
    return actionDispatcherHashMap[key];
  }

  void initDispatchers() {
    //add dispatcher
    dispatcherHashMap[FunScheme.POST_DETAIL] = new PostDetailDispatcher();

    dispatcherHashMap[FunScheme.HTTP] = new HttpDispatcher();
    dispatcherHashMap[FunScheme.SEARCH_LIST] = new SearchDispatcher();
    dispatcherHashMap[FunScheme.TEMPLATE_MAKER] = new TemplateMakerDispatcher();
    //TODO add other dispatcher router

    //add action
    actionDispatcherHashMap[FunAction.LOGIN_INTERCEPT] =
        new LoginInterceptDispatcher();
  }
}
