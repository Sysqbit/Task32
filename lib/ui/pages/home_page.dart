import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sysqbit_todo/config/styles/colors/app_colors.dart';
import 'package:sysqbit_todo/config/utils/app_utils.dart';
import 'package:sysqbit_todo/config/utils/size_manager.dart';

import '../../config/models/task.dart';
import '../widgets/adaptive/adaptive_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _handleChange(Task task) {
    setState(() {
      task.isDone = !task.isDone;
      Future.delayed(const Duration(seconds: 10));
      _taskList.remove(task);
    });
  }

  final titleController = TextEditingController();
  final categoryController = TextEditingController();

  final List<Task> _taskList = <Task>[
    Task(title: "Save Money", category: "Finance", isDone: true),
    Task(title: "Cook", category: "Food", isDone: true),
    Task(title: "Save Money", category: "Finance", isDone: true),
    Task(title: "Cook", category: "Food"),
    Task(title: "Save Money", category: "Finance"),
    Task(title: "Cook", category: "Food"),
    Task(title: "Save Money", category: "Finance"),
    Task(title: "Cook", category: "Food"),
    Task(title: "Save Money", category: "Finance"),
    Task(title: "Cook", category: "Food"),
    Task(title: "Save Money", category: "Finance"),
    Task(title: "Cook", category: "Food"),
    Task(title: "Save Money", category: "Finance"),
    Task(title: "Cook", category: "Food"),
    Task(title: "Save Money", category: "Finance"),
    Task(title: "Cook", category: "Food"),
    Task(title: "Save Money", category: "Finance"),
    Task(title: "Cook", category: "Food"),
    Task(title: "Save Money", category: "Finance"),
    Task(title: "Cook", category: "Food")
  ];

  bool? value = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(SizeMg.radius(10)),
                      topRight: Radius.circular(SizeMg.radius(10)))),
              context: context,
              builder: ((context) {
                return Container(
                  decoration: const BoxDecoration(),
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeMg.width(20),
                      vertical: SizeMg.height(20)),
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                            hintText: 'Title', labelText: 'Title'),
                      ),
                      TextField(
                        controller: categoryController,
                        decoration: const InputDecoration(
                            hintText: 'Category', labelText: 'Category'),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      AdaptiveButton(
                        onTap: () {
                          _taskList.add(Task(
                              title: titleController.text,
                              category: categoryController.text));
                          titleController.clear();
                          categoryController.clear();
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(SizeMg.radius(10)),
                            color: AppColors.primary100,
                          ),
                          height: height * 0.08,
                          width: width * 0.5,
                          child: Center(
                              child: Text("Add Todo",
                                  style: theme.headline5?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white))),
                        ),
                      )
                    ],
                  ),
                );
              }));
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            expandedHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppUtils.formattedDate,
                  style: theme.headline1?.copyWith(
                      fontSize: SizeMg.text(28), fontWeight: FontWeight.w700),
                ),
                const CircleAvatar(
                  backgroundColor: AppColors.gray500,
                  child: Icon(
                    Iconsax.user,
                    color: AppColors.primary100,
                  ),
                )
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 15),
              title: Text(
                '5 incomplete, 5 completed',
                style: theme.headline6?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: SizeMg.width(10)),
              child: Text(
                'Incomplete',
                style: theme.headline4?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.only(left: SizeMg.width(10)),
            child: const CustomPaint(
              size: Size(
                double.infinity,
                30,
              ),
              painter:
                  TextScrollPainter(label1: "complete", label2: "Complete"),
            ),
          )),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final reversedIndex = _taskList.length - index - 1;
                return TodoItem(
                    task: _taskList[reversedIndex], onChange: _handleChange);
              },
              childCount: _taskList.length,
            ),
          ),
        ],
      ),
    );
  }
}

//
class TodoItem extends StatelessWidget {
  final Task task;
  final void Function(Task) onChange;
  const TodoItem({Key? key, required this.task, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: task.isDone == true ? true : false,
      onChanged: (val) {
        onChange(task);
      },
      title: Text(task.title),
      subtitle: Text(task.category),
    );
  }
}

class TextScrollPainter extends CustomPainter {
  const TextScrollPainter(
      {required this.label1, required this.label2, this.scrollPosition = 0.0});
  final String label1;
  final String label2;
  final double scrollPosition;

  @override
  void paint(Canvas canvas, Size size) {
    final ParagraphBuilder paragraphBuilder = ParagraphBuilder(ParagraphStyle(
      textAlign: TextAlign.center,
      maxLines: 1,
    ))
      ..addText(label1);
    final Paragraph paragraph = paragraphBuilder.build()
      ..layout(ParagraphConstraints(width: size.width));

    canvas.drawParagraph(paragraph, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



// ! Challenges I faced.
// * While testing out slivers and how to map each checkbox of the list,
// * i tried these. I'd just keep them here.

// SliverList(
//             delegate: SliverChildListDelegate([
//           for (Task task in _taskList)
//             TodoItem(
//               task: task,
//               onChange: _handleChange,
//             )
//         ])),

// CheckboxListTile(
//   controlAffinity: ListTileControlAffinity.leading,
//   value: _taskList[index].isDone == true ? true : false,
//   onChanged: (val) {
//     setState(() {
//       _taskList[index].isDone = !_taskList[index].isDone;
//     });
//     print(val);
//   },
//   title: Text(_taskList[index].title),
//   subtitle: Text(_taskList[index].category),
// ),