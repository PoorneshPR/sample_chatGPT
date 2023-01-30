import 'package:samplechat_gpt/constants/Constants.dart';

abstract class ProviderHelperClass{
  LoaderState loaderState = LoaderState.initial;
  updateLoaderState(LoaderState loaderState);
}