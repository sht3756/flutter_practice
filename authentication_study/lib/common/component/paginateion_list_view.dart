import 'package:authentication_study/common/model/cursor_pagination_model.dart';
import 'package:authentication_study/common/model/model_with_id.dart';
import 'package:authentication_study/common/provider/pagination_provider.dart';
import 'package:authentication_study/common/utils/pagination_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// typedef 정의 : 이 타입은 3개 파라미터 입력받고 IModelWithId 을 상속한 T 만 사용가능하다. model 는 페이지네이션 가능한 클래스 의미한다.
typedef PaginationWidgetBuilder<T extends IModelWithId> =
Widget Function(BuildContext context, int index, T model);

// 렌더링 처리 일반화 시킴
// stful 생성할때 지정한 <T> 타입이 state 클래스에서도 제너릭으로 사용할 수 있다.
// 아무 타입만 들어올 수 있는게 아니라, IModelWithId를 상속한 타입만 들어올 수 있다.
class PaginationListView<T extends IModelWithId> extends ConsumerStatefulWidget {
  // Provider 일반화 : 외부에서 받는 타입 정의
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;

  // itemBuilder 일반화 : 외부에서 받는 타입 정의
  final PaginationWidgetBuilder<T> itemBuilder;

  const PaginationListView({
    Key? key,
    required this.provider,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  ConsumerState<PaginationListView> createState() => _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId> extends ConsumerState<PaginationListView> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(scrollListener);
  }

  void scrollListener() {
    // provider 를 일반화(restaurantProvider 의 타입을 확인해보면된다.)
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(widget.provider.notifier),
    );
  }

  @override
  void dispose() {
    controller.removeListener(scrollListener);
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 외부에서 넣어준 provider qhrl
    final state = ref.watch(widget.provider);

    // 완전 처음 랜더링할때
    if (state is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러날 때
    if (state is CursorPaginationError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              ref.read(widget.provider.notifier).paginate(
                // 강제 새로고침
                forceRefetch: true,
              );
            },
            child: Text('다시시도'),
          ),
        ],
      );
    }
    // CursorPagination
    // CursorPaginationFetchingMore
    // CursorPaginationRefetching

    // 캐스팅
    final cp = state as CursorPagination<T>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: controller,
        // ListView 에서 한개의 위젯을 더 추가 (데이터 요청하는 부분을 끊기지 않게 여유를 둔다.)
        itemCount: cp.data.length + 1,
        itemBuilder: (_, index) {
          // index 가 마지막크기와 같을때 실행
          if (index == cp.data.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Center(
                // 클래스가 CursorPaginationFetchingMore 일때는 로딩 아니면 메세지
                child: cp is CursorPaginationFetchingMore
                    ? CircularProgressIndicator()
                    : Text('마지막 데이터입니다. :)'),
              ),
            );
          }
          final parseItem = cp.data[index];

          // 제일 중요한 부분!! (각 인덱스별로 어떤 값을 보여줘야할지!, typedef 를 이용해 외부에서 build 하는 함수를 제공해줄것이다.)
          return widget.itemBuilder(
            context,
            index,
            parseItem,
          );
        },
        separatorBuilder: (_, index) {
          return SizedBox(height: 16.0);
        },
      ),
    );
  }
}
