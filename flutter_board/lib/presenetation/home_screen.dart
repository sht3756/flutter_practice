import 'package:flutter/material.dart';
import 'package:flutter_board/domain/model/post.dart';
import 'package:flutter_board/presenetation/home_event.dart';
import 'package:flutter_board/presenetation/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;

    return Scaffold(
      body: ListView.builder(
          itemCount: state.posts.length,
          itemBuilder: (context, index) {
            final post = state.posts[index];
            return GestureDetector(
              onTap: () {
                _controller.text = post.content;
                showDialog(
                    context: context,
                    builder: (_) => _buildUpdateDeleteAlertDialog(
                        viewModel, post, context));
              },
              child: ListTile(
                title: Text('${post.id} : ${post.content}'),
                subtitle: Text(post.createTime),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => _buildInsertAlertDialog(viewModel, context));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  AlertDialog _buildInsertAlertDialog(
      HomeViewModel viewModel, BuildContext context) {
    _controller.text = '';
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            viewModel.onEvent(HomeEvent.insert(_controller.text));
            Navigator.pop(context);
          },
          child: Text('Insert'),
        ),
      ],
    );
  }

  AlertDialog _buildUpdateDeleteAlertDialog(
      HomeViewModel viewModel, Post post, BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            viewModel.onEvent(HomeEvent.delete(post.id));
            Navigator.pop(context);
          },
          child: Text('Delete'),
        ),
        TextButton(
          onPressed: () {
            viewModel.onEvent(HomeEvent.update(post.id, post.content));
            Navigator.pop(context);
          },
          child: Text('Update'),
        )
      ],
    );
  }
}
