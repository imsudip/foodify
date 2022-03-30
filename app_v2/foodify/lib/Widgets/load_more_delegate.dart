import 'package:flutter/material.dart';
import 'package:foodify/Widgets/loader.dart';
import 'package:loadmore/loadmore.dart';

class ListLoading extends LoadMoreDelegate {
  @override
  Widget buildChild(LoadMoreStatus status,
      {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.english}) {
    // TODO: implement buildChild
    return status == LoadMoreStatus.loading
        ? LoadingWidget(
            height: 200,
          )
        : status == LoadMoreStatus.nomore
            ? const Center(
                child: const Text('No more Recipes'),
              )
            : Container();
  }
}
