import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_wave_round_one/presentation/movie/movie_item_view.dart';

import 'bloc/movie_bloc.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(MovieLoadMorePageEvent());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !PreventLoadOverlapFlag.isLoading) {
      context.read<MovieBloc>().add(MovieLoadMorePageEvent());
      PreventLoadOverlapFlag.turnOn();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.95);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: const [
                Icon(Icons.arrow_back),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'Back',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Popular list',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  }
                  if (state.status.isFailure) {
                    return Center(
                        child: Text(state.error ?? 'Unexpected error!!!'));
                  }

                  if (state.status.isSuccess) {
                    if (state.items != null) {
                      if (state.items!.isEmpty) {
                        return const Center(child: Text('Movie not found!!!'));
                      } else {
                        return GridView.builder(
                          controller: _scrollController,
                          addAutomaticKeepAlives: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 7 / 9,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 16,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) =>
                              MovieItemView(model: state.items![index]),
                          shrinkWrap: true,
                          itemCount: state.items!.length,
                        );
                      }
                    }
                  }
                  return Container();
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}

class PreventLoadOverlapFlag {
  static bool isLoading = false;
  static void turnOn() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;
  }
}
