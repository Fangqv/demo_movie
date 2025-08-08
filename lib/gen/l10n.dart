// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `电影应用`
  String get appTitle {
    return Intl.message('电影应用', name: 'appTitle', desc: '', args: []);
  }

  /// `搜索电影`
  String get searchMovies {
    return Intl.message('搜索电影', name: 'searchMovies', desc: '', args: []);
  }

  /// `搜索电影`
  String get searchForMovies {
    return Intl.message('搜索电影', name: 'searchForMovies', desc: '', args: []);
  }

  /// `搜索电影...`
  String get searchForMoviesHint {
    return Intl.message(
      '搜索电影...',
      name: 'searchForMoviesHint',
      desc: '',
      args: [],
    );
  }

  /// `热门电影`
  String get trendingMovies {
    return Intl.message('热门电影', name: 'trendingMovies', desc: '', args: []);
  }

  /// `流行电影`
  String get popularMovies {
    return Intl.message('流行电影', name: 'popularMovies', desc: '', args: []);
  }

  /// `未找到电影`
  String get noMoviesFound {
    return Intl.message('未找到电影', name: 'noMoviesFound', desc: '', args: []);
  }

  /// `电影未找到`
  String get movieNotFound {
    return Intl.message('电影未找到', name: 'movieNotFound', desc: '', args: []);
  }

  /// `演员未找到`
  String get actorNotFound {
    return Intl.message('演员未找到', name: 'actorNotFound', desc: '', args: []);
  }

  /// `加载中...`
  String get loading {
    return Intl.message('加载中...', name: 'loading', desc: '', args: []);
  }

  /// `错误`
  String get error {
    return Intl.message('错误', name: 'error', desc: '', args: []);
  }

  /// `重试`
  String get retry {
    return Intl.message('重试', name: 'retry', desc: '', args: []);
  }

  /// `取消`
  String get cancel {
    return Intl.message('取消', name: 'cancel', desc: '', args: []);
  }

  /// `确定`
  String get ok {
    return Intl.message('确定', name: 'ok', desc: '', args: []);
  }

  /// `返回`
  String get back {
    return Intl.message('返回', name: 'back', desc: '', args: []);
  }

  /// `清除`
  String get clear {
    return Intl.message('清除', name: 'clear', desc: '', args: []);
  }

  /// `搜索`
  String get search {
    return Intl.message('搜索', name: 'search', desc: '', args: []);
  }

  /// `电影`
  String get movies {
    return Intl.message('电影', name: 'movies', desc: '', args: []);
  }

  /// `演员`
  String get actors {
    return Intl.message('演员', name: 'actors', desc: '', args: []);
  }

  /// `演员表`
  String get cast {
    return Intl.message('演员表', name: 'cast', desc: '', args: []);
  }

  /// `制作团队`
  String get crew {
    return Intl.message('制作团队', name: 'crew', desc: '', args: []);
  }

  /// `导演`
  String get director {
    return Intl.message('导演', name: 'director', desc: '', args: []);
  }

  /// `制片人`
  String get producer {
    return Intl.message('制片人', name: 'producer', desc: '', args: []);
  }

  /// `编剧`
  String get writer {
    return Intl.message('编剧', name: 'writer', desc: '', args: []);
  }

  /// `片长`
  String get runtime {
    return Intl.message('片长', name: 'runtime', desc: '', args: []);
  }

  /// `分钟`
  String get minutes {
    return Intl.message('分钟', name: 'minutes', desc: '', args: []);
  }

  /// `上映日期`
  String get releaseDate {
    return Intl.message('上映日期', name: 'releaseDate', desc: '', args: []);
  }

  /// `类型`
  String get genre {
    return Intl.message('类型', name: 'genre', desc: '', args: []);
  }

  /// `类型`
  String get genres {
    return Intl.message('类型', name: 'genres', desc: '', args: []);
  }

  /// `评分`
  String get rating {
    return Intl.message('评分', name: 'rating', desc: '', args: []);
  }

  /// `简介`
  String get overview {
    return Intl.message('简介', name: 'overview', desc: '', args: []);
  }

  /// `传记`
  String get biography {
    return Intl.message('传记', name: 'biography', desc: '', args: []);
  }

  /// `代表作`
  String get knownFor {
    return Intl.message('代表作', name: 'knownFor', desc: '', args: []);
  }

  /// `作品集`
  String get filmography {
    return Intl.message('作品集', name: 'filmography', desc: '', args: []);
  }

  /// `个人信息`
  String get personalInfo {
    return Intl.message('个人信息', name: 'personalInfo', desc: '', args: []);
  }

  /// `出生日期`
  String get birthDate {
    return Intl.message('出生日期', name: 'birthDate', desc: '', args: []);
  }

  /// `逝世日期`
  String get deathDate {
    return Intl.message('逝世日期', name: 'deathDate', desc: '', args: []);
  }

  /// `出生地`
  String get placeOfBirth {
    return Intl.message('出生地', name: 'placeOfBirth', desc: '', args: []);
  }

  /// `人气`
  String get popularity {
    return Intl.message('人气', name: 'popularity', desc: '', args: []);
  }

  /// `平均评分`
  String get voteAverage {
    return Intl.message('平均评分', name: 'voteAverage', desc: '', args: []);
  }

  /// `投票数`
  String get voteCount {
    return Intl.message('投票数', name: 'voteCount', desc: '', args: []);
  }

  /// `预算`
  String get budget {
    return Intl.message('预算', name: 'budget', desc: '', args: []);
  }

  /// `票房`
  String get revenue {
    return Intl.message('票房', name: 'revenue', desc: '', args: []);
  }

  /// `制作公司`
  String get productionCompanies {
    return Intl.message(
      '制作公司',
      name: 'productionCompanies',
      desc: '',
      args: [],
    );
  }

  /// `制作国家`
  String get productionCountries {
    return Intl.message(
      '制作国家',
      name: 'productionCountries',
      desc: '',
      args: [],
    );
  }

  /// `语言`
  String get spokenLanguages {
    return Intl.message('语言', name: 'spokenLanguages', desc: '', args: []);
  }

  /// `状态`
  String get status {
    return Intl.message('状态', name: 'status', desc: '', args: []);
  }

  /// `原名`
  String get originalTitle {
    return Intl.message('原名', name: 'originalTitle', desc: '', args: []);
  }

  /// `原语言`
  String get originalLanguage {
    return Intl.message('原语言', name: 'originalLanguage', desc: '', args: []);
  }

  /// `主页`
  String get homepage {
    return Intl.message('主页', name: 'homepage', desc: '', args: []);
  }

  /// `IMDB ID`
  String get imdbId {
    return Intl.message('IMDB ID', name: 'imdbId', desc: '', args: []);
  }

  /// `暂无传记信息`
  String get noBiography {
    return Intl.message('暂无传记信息', name: 'noBiography', desc: '', args: []);
  }

  /// `暂无简介`
  String get noOverview {
    return Intl.message('暂无简介', name: 'noOverview', desc: '', args: []);
  }

  /// `暂无数据`
  String get noDataAvailable {
    return Intl.message('暂无数据', name: 'noDataAvailable', desc: '', args: []);
  }

  /// `网络错误，请检查连接。`
  String get networkError {
    return Intl.message(
      '网络错误，请检查连接。',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `服务器错误，请稍后重试。`
  String get serverError {
    return Intl.message(
      '服务器错误，请稍后重试。',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `发生未知错误。`
  String get unknownError {
    return Intl.message('发生未知错误。', name: 'unknownError', desc: '', args: []);
  }

  /// `下拉刷新`
  String get pullToRefresh {
    return Intl.message('下拉刷新', name: 'pullToRefresh', desc: '', args: []);
  }

  /// `点击重试`
  String get tapToRetry {
    return Intl.message('点击重试', name: 'tapToRetry', desc: '', args: []);
  }

  /// `未找到结果`
  String get noResultsFound {
    return Intl.message('未找到结果', name: 'noResultsFound', desc: '', args: []);
  }

  /// `尝试不同的关键词`
  String get tryDifferentKeywords {
    return Intl.message(
      '尝试不同的关键词',
      name: 'tryDifferentKeywords',
      desc: '',
      args: [],
    );
  }

  /// `搜索历史`
  String get searchHistory {
    return Intl.message('搜索历史', name: 'searchHistory', desc: '', args: []);
  }

  /// `清除历史`
  String get clearHistory {
    return Intl.message('清除历史', name: 'clearHistory', desc: '', args: []);
  }

  /// `最近搜索`
  String get recentSearches {
    return Intl.message('最近搜索', name: 'recentSearches', desc: '', args: []);
  }

  /// `收藏`
  String get favorites {
    return Intl.message('收藏', name: 'favorites', desc: '', args: []);
  }

  /// `观看列表`
  String get watchlist {
    return Intl.message('观看列表', name: 'watchlist', desc: '', args: []);
  }

  /// `设置`
  String get settings {
    return Intl.message('设置', name: 'settings', desc: '', args: []);
  }

  /// `语言`
  String get language {
    return Intl.message('语言', name: 'language', desc: '', args: []);
  }

  /// `主题`
  String get theme {
    return Intl.message('主题', name: 'theme', desc: '', args: []);
  }

  /// `深色模式`
  String get darkMode {
    return Intl.message('深色模式', name: 'darkMode', desc: '', args: []);
  }

  /// `浅色模式`
  String get lightMode {
    return Intl.message('浅色模式', name: 'lightMode', desc: '', args: []);
  }

  /// `系统默认`
  String get systemDefault {
    return Intl.message('系统默认', name: 'systemDefault', desc: '', args: []);
  }

  /// `关于`
  String get about {
    return Intl.message('关于', name: 'about', desc: '', args: []);
  }

  /// `版本`
  String get version {
    return Intl.message('版本', name: 'version', desc: '', args: []);
  }

  /// `隐私政策`
  String get privacyPolicy {
    return Intl.message('隐私政策', name: 'privacyPolicy', desc: '', args: []);
  }

  /// `服务条款`
  String get termsOfService {
    return Intl.message('服务条款', name: 'termsOfService', desc: '', args: []);
  }

  /// `联系我们`
  String get contactUs {
    return Intl.message('联系我们', name: 'contactUs', desc: '', args: []);
  }

  /// `反馈`
  String get feedback {
    return Intl.message('反馈', name: 'feedback', desc: '', args: []);
  }

  /// `评价应用`
  String get rateApp {
    return Intl.message('评价应用', name: 'rateApp', desc: '', args: []);
  }

  /// `分享应用`
  String get shareApp {
    return Intl.message('分享应用', name: 'shareApp', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
