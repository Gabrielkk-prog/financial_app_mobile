import 'package:flutter/material.dart';

class Sizes{ //singleton.
//private constructor.
  Sizes._();
           //*if I don't call any value, the values by default will be ever 0.0.*
  double _width = 0;
  double _height = 0;
//initial value based on the design size of the app, which is 414x896
static const Size _designSize = Size(414.0, 896.0);

static final Sizes _instance = Sizes._();
//singleton constructor.
factory Sizes() => _instance;

  double get width => _width;
  double get height => _height;

//method to set the size based on the current context.
static void init(
    BuildContext context,
  {
    Size designSize = _designSize,
  }) {
//verify if existing instance is already initialized.   
//if don't have any information in the device, he incialize null values istead. 
final deviceData = MediaQuery.maybeOf(context);

//if deviceData is null, it means that the context is not available yet, so we use the design size as default values.
final deviceSize = deviceData?.size ?? _designSize;

//update the instance with the current device size.
_instance._width = deviceSize.width;
_instance._height = deviceSize.height;
  }
}

extension SizeExt on num {
//calculate the width based on the design size 
//of the app and the current device size.
  double get w {
    return (this * Sizes._instance._width)/ Sizes._designSize.width;
  }
}