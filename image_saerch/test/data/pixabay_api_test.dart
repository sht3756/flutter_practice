import 'package:flutter_test/flutter_test.dart';
import 'package:image_saerch/data/pixabay_api.dart';

void main() {
  test('Pixabay 데이터를 잘 가져와야 한다.', () async {
    final api = PixabayApi();

    final res = await api.fetch('iphone');

    expect(res.length, 20);

  });
}