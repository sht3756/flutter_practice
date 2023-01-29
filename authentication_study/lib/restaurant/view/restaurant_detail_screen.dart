import 'package:authentication_study/common/const/colors.dart';
import 'package:authentication_study/common/layout/default_layout.dart';
import 'package:authentication_study/common/model/cursor_pagination_model.dart';
import 'package:authentication_study/common/utils/pagination_utils.dart';
import 'package:authentication_study/product/component/product_card.dart';
import 'package:authentication_study/product/model/product_model.dart';
import 'package:authentication_study/rating/component/rating_card.dart';
import 'package:authentication_study/rating/model/rating_model.dart';
import 'package:authentication_study/restaurant/component/restaurant_card.dart';
import 'package:authentication_study/restaurant/model/restaurant_detail_model.dart';
import 'package:authentication_study/restaurant/model/restaurant_model.dart';
import 'package:authentication_study/restaurant/provider/restaurant_provider.dart';
import 'package:authentication_study/restaurant/provider/restaurant_rating_provider.dart';
import 'package:authentication_study/restaurant/view/basket_screen.dart';
import 'package:authentication_study/user/provider/basket_provider.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletons/skeletons.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'restaurantDetail';

  // 해당 디테일 id
  final String id;

  const RestaurantDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // 상세 정보를 가져오는 코드 : 디테일 페이지 올떄마다 새로운 디테일 정보 읽어올거다
    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);

    controller.addListener(listener);
  }

  void listener() {
    // 별점의 프로바이더를 읽는다.
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(
        restaurantRatingProvider(widget.id).notifier,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // restaurant
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingsState = ref.watch(restaurantRatingProvider(widget.id));
    final basket = ref.watch(basketProvider);

    if (state == null) {
      return DefaultLayout(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    }
    return DefaultLayout(
      title: '불타는 떡볶이',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // pushNamed() 를 하면 현재 라우트 위에 페이지를 올릴 수 있디. 그래서 라우트 스택이 쌓인다.
          // goNamed() 는 goRoute() 등록한 곳에 중첩으로 등록을 해야만 라우트 스택이 쌓인다.
          context.pushNamed(BasketScreen.routeName);
        },
        backgroundColor: PRIMARY_COLOR,
        child: Badge(
          // 뱃지 보여주기
          showBadge: basket.isNotEmpty,
          // 뱃지 내용
          badgeContent: Text(
            // 전부 다 더하기(<List<BasketItemModel>> 타입, 각각의 BasketItemModel 안의 int count 를 다 더하기, list.length 보다 정확하다.)
            basket
                .fold<int>(
                  0,
                  (previous, next) => previous + next.count,
                )
                .toString(),
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 10.0,
            ),
          ),
          child: Icon(
            Icons.shopping_basket_outlined,
          ),
          // 뱃지 배경 색
          badgeStyle: BadgeStyle(
            badgeColor: Colors.white,
          ),
          // 애니메이션
          badgeAnimation: BadgeAnimation.scale(
            animationDuration: Duration(seconds: 1),
            colorChangeAnimationDuration: Duration(seconds: 1),
            loopAnimation: false,
            curve: Curves.fastOutSlowIn,
            colorChangeAnimationCurve: Curves.easeInCubic,
          ),
        ),
      ),
      child: CustomScrollView(
        controller: controller,
        slivers: [
          renderTop(
            model: state!,
          ),
          // 로딩중일떄는
          if (state is! RestaurantDetailModel) renderLoading(),
          // RestaurantDetailModel  일떄
          if (state is RestaurantDetailModel) renderLabel(),
          if (state is RestaurantDetailModel)
            renderProducts(
              products: state!.products,
              restaurant: state,
            ),
          if (ratingsState is CursorPagination<RatingModel>)
            renderRatings(models: ratingsState.data),
        ],
      ),
    );
  }

  // 평점
  SliverPadding renderRatings({
    required List<RatingModel> models,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: RatingCard.fromModel(model: models[index]),
          ),
          childCount: models.length,
        ),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                style:
                    SkeletonParagraphStyle(lines: 5, padding: EdgeInsets.zero),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 맨 위
  SliverToBoxAdapter renderTop({
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  // 라벨
  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // 상품
  SliverPadding renderProducts({
    required List<RestaurantProductModel> products,
    // 추가 : ProductModel 에 매핑해주기 위함
    required RestaurantModel restaurant,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];

            // InkWell : 눌렀을때의 액션을 정의 할 수 있는 위젯, 누르고 나서 화면 안에 그대로 있는 경우 자주 쓴다. (화면 전환인 경우는 X )
            return InkWell(
              onTap: () {
                ref.read(basketProvider.notifier).addToBasket(
                        // 그냥 model 로 하면 되는데 오류가 난다.
                        // 오류 이유 : product model 에는 restaurant model 이 있고
                        // restaurant detail model 에는 restaurant model 이 없기 때문에 ProductModel 에 그냥 다시 매핑해주면된다.
                        product: ProductModel(
                      id: model.id,
                      name: model.name,
                      detail: model.detail,
                      imgUrl: model.imgUrl,
                      price: model.price,
                      restaurant: restaurant,
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ProductCard.fromRestaurantProductModel(
                  model: model,
                ),
              ),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
