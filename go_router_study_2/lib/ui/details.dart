import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_study_2/constants.dart';
import '../cart_holder.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  final String description;
  final Object? extra;

  const Details({Key? key, required this.description, this.extra}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Details',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(description),
            Text('extra- ${extra as String}'),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              onPressed: () {
                Provider.of<CartHolder>(context, listen: false)
                    .addItem(description);
                // TODO: Add Root Route
                context.goNamed(rootRouteName, params: {'tab': 'cart'});
              },
              child: const Text(
                'Add To Cart',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
