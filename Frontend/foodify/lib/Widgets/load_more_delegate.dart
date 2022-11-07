import 'package:flutter/material.dart';
import 'loader.dart';
import 'package:loadmore/loadmore.dart';

class ListLoading extends LoadMoreDelegate {
  @override
  Widget buildChild(LoadMoreStatus status, {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.english}) {
    return status == LoadMoreStatus.loading
        ? LoadingWidget(
            height: 200,
          )
        : status == LoadMoreStatus.nomore
            ? const Center(
                child: Text('No more Recipes'),
              )
            : Container();
  }
}
