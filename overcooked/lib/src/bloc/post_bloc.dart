import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import './post_event.dart';
import './post_state.dart';
import '../services/api.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({@required this.httpClient});

  @override
  Stream<PostState> transform(
      Stream<PostEvent> events,
      Stream<PostState> Function(PostEvent event) next,
      ) {
    return super.transform(
      (events as Observable<PostEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialized) {
          final posts = await Api.getRecipeList(0);
          yield PostLoaded(
              posts: posts.recipes,
              hasReachedMax: false,
              currentIndex: 0,
          );
          return;
        }
        if (currentState is PostLoaded) {
          final newIndex = (currentState as PostLoaded).currentIndex + 1;
          final posts = await Api.getRecipeList(newIndex);
          yield PostLoaded(
            posts: (currentState as PostLoaded).posts + posts.recipes,
            hasReachedMax: posts.lastPage,
            currentIndex: newIndex,
          );
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  bool _hasReachedMax(PostState state) => state is PostLoaded && state.hasReachedMax;
}
