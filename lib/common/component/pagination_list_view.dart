import 'dart:async';

import 'package:cofac_lv2/common/model/cursor_pagination_model.dart';
import 'package:cofac_lv2/common/model/model_with_id.dart';
import 'package:cofac_lv2/common/provider/pagination_provider.dart';
import 'package:cofac_lv2/common/repository/base_pagination_repository.dart';
import 'package:cofac_lv2/common/utils/pagination_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PaginationItemBuilder<T extends IModelWithId> = Widget Function(
    BuildContext context, int index, T model);

class PaginationListView<T extends IModelWithId>
    extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;

  final PaginationItemBuilder<T> builder;

  const PaginationListView({
    required this.provider,
    required this.builder,
    super.key,
  });

  @override
  ConsumerState<PaginationListView> createState() =>
      _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId>
    extends ConsumerState<PaginationListView> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(_listener);
  }

  void _listener() {
    PaginationUtils.scrollListener(
      controller: controller,
      provider: ref.read(widget.provider.notifier),
    );
  }

  @override
  void dispose() {
    controller.removeListener(_listener);
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    if (state is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is CursorPaginationError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(state.err),
          const SizedBox(height: 16.0),
          ElevatedButton(
            child: const Text('Retry'),
            onPressed: () {
              ref.read(widget.provider.notifier).paginate(forceRefetch: true);
            },
          ),
        ],
      );
    }

    final pState = state as CursorPagination<T>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: controller,
        itemCount: pState.data.length + 1,
        itemBuilder: (context, index) {
          if (index == pState.data.length) {
            return Center(
              child: pState.meta.hasMore
                  ? const CircularProgressIndicator()
                  : const Text('No More Data'),
            );
          }

          return widget.builder(context, index, pState.data[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
      ),
    );
  }
}
