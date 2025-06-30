import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:to_do/config/dependencies.dart';
import 'package:to_do/ui/home/home_viewmodel.dart';
import 'package:to_do/ui/home/widgets/create_bar_widget.dart';
import 'package:to_do/ui/home/widgets/todo_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final viewmodel = injector.get<HomeViewmodel>();

  @override
  void initState() {
    super.initState();
    viewmodel.loadCommand.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Text("CHORES")],
        actionsPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: CupertinoSwitch(
                value: viewmodel.theme,
                onChanged: (value) => viewmodel.changeTheme(),
              ),
            ),
          ],
        ),
      ),
      body: ListenableBuilder(
        listenable: Listenable.merge([viewmodel.loadCommand, viewmodel]),
        builder: (context, child) {
          if (viewmodel.loadCommand.value is RunningCommand) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 20)),
                CreateBarWidget(onPressed: viewmodel.create),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("TO DO"),
                  ),
                ),
                SliverList.builder(
                  itemCount: viewmodel.notCompletos.length,
                  itemBuilder: (context, index) {
                    final todo = viewmodel.notCompletos[index];
                    return TodoCardWidget(
                      todo: todo,
                      toggle: viewmodel.update,
                      remove: viewmodel.delete,
                    );
                  },
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("COMPLETED"),
                  ),
                ),
                SliverList.builder(
                  itemCount: viewmodel.completos.length,
                  itemBuilder: (context, index) {
                    final todo = viewmodel.completos[index];
                    return TodoCardWidget(
                      todo: todo,
                      toggle: viewmodel.update,
                      remove: viewmodel.delete,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
