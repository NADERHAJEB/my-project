
part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const SETTINGS = _Paths.SETTINGS;
  static const ADD_MED = _Paths.ADD_MED;
  static const ABOUT = _Paths.ABOUT;
  static const LOGIN = _Paths.LOGIN;
  static const EDIT_MED = _Paths.EDIT_MED;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const SETTINGS = '/settings';
  static const ADD_MED = '/add-med';
  static const ABOUT = '/about';
  static const LOGIN = '/login';
  static const EDIT_MED = '/edit-med';
}