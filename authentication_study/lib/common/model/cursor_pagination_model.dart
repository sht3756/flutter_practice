import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

// 인스턴스로 못만들게 하겠다
abstract class CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

// 로딩할때 (처음 랜더링 할때)
class CursorPaginationLoading extends CursorPaginationBase {}

@JsonSerializable(
  // true : retrofit 으로 자동으로 CursorPagination<T> 만들때,  genericArgument 를 고려해서 만들겠다! 라는 의미
  genericArgumentFactories: true,
)
class CursorPagination<T> extends CursorPaginationBase {
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  // 특정값만 변경할수 있는 copyWith 생성
  CursorPagination copyWith({
    CursorPaginationMeta? meta,
    List<T>? data,
  }) {
    return CursorPagination<T>(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

  // CursorPagination 을 인스턴스로 만들 <T> 이 타입으로 List<T> 의 타입을 지정할수 있어진다.
  // List<T> 부분에서 <T> 타입이 빌드,런타임할때 지정이 안 되어있기 때문에, data 를 어떻게 Json 으로 부터 클래스의 인스턴스로 변화하게 될지 알려줘야한다. (외부에서 전환이 된다는 것을 정의)
  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  // 특정값만 변경할수 있는 copyWith 생성
  CursorPaginationMeta copyWith({
    int? count,
    bool? hasMore,
  }) {
    return CursorPaginationMeta(
      count: count ?? this.count,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}

// 새로고침할때(데이터가 있는 상태)
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required super.meta,
    required super.data,
  });
}

// 리스트의 맨 아래로 내려서 추가 데이터를 요청하는 중 (데이터가 있는 상태)
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data,
  });
}
