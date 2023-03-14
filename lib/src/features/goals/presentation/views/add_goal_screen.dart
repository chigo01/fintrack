import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/utils/cam.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/core/widgets/textfield.dart';
import 'package:fintrack/src/features/goals/data/repository/notifiers/provider.dart';
import 'package:fintrack/src/features/goals/models/goal.dat.dart';
import 'package:fintrack/src/features/goals/models/goal_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddGoalScreen extends StatefulHookConsumerWidget {
  const AddGoalScreen({required this.goals, super.key});
  final GoalsList goals;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends ConsumerState<AddGoalScreen> {
  void pickedImage() {
    getImage(ref);
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final themeModeChecker = ref.watch(themeProvider) == ThemeMode.dark;
    final Color color = themeModeChecker ? Colors.white : Colors.black;
    final imageUrl = ref.watch(imagePath);
    DateTime setOn = DateTime.now();
    final nameController = useTextEditingController();
    final amountController = useTextEditingController();
    final savedAmountController = useTextEditingController();
    final descriptionController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Goal',
          style: TextStyle(
            color: color,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(PhosphorIcons.xLight, color: color),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(goalsNotifierProvider.notifier).addGoals(
                    GoalsCollection(
                      name: nameController.text,
                      imageUrl: imageUrl,
                      savedAmount: savedAmountController.text.toDouble,
                      amount: amountController.text.toDouble,
                      setOn: setOn,
                      desiredDate: selectedDate,
                      category: widget.goals.name,
                    ),
                  );
            },
            icon: Icon(PhosphorIcons.checkLight, color: color),
          ),
        ],
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: widget.goals.color.withOpacity(.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        widget.goals.imageUrl,
                        height: 70,
                        width: 100,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(widget.goals.name),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: context.height * 0.6,
              width: MediaQuery.of(context).size.width,
              color: null, // Theme.of(context).primaryColor.withOpacity(.1),
              child: Column(
                children: [
                  Expanded(
                    child: GoalFormField(
                      hintText: 'Name',
                      controller: nameController,
                    ),
                  ),
                  Expanded(
                    child: GoalFormField(
                      hintText: 'Target Amount',
                      controller: amountController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    height: context.height * 0.08,
                    width: MediaQuery.of(context).size.width,

                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    //  color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Desired Date',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontSize: 12, color: Colors.grey)),
                        const SizedBox(height: 5),
                        Text(DateFormat.yMMMMd().format(selectedDate)),
                        Container(
                          height: .4,
                          width: double.infinity,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ).onTap(() {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: themeModeChecker
                              ? ThemeData.dark().copyWith(
                                  colorScheme: ColorScheme.dark(
                                    primary: Theme.of(context).primaryColor,
                                  ),
                                )
                              : ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Theme.of(context).primaryColor,
                                  ),
                                ),
                          child: child!,
                        );
                      },
                    ).then((DateTime? newDate) {
                      if (newDate != null) {
                        setState(() {
                          selectedDate = newDate;
                        });
                      }
                    });
                  }),
                  Expanded(
                    child: Container(
                      height: context.height * 0.08,
                      width: context.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 50.0),
                            child: Text(
                              'I have already saved',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: context.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.3,
                            //   color: Colors.blue,

                            //color: Colors.red,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextInput(
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontSize: 15,
                                        ),
                                    hintText: '',
                                    filled: false,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    controller: savedAmountController,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Container(
                                  height: .4,
                                  width: double.infinity,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: context.height * 0.08,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      //  color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Container(
                              height: 40,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                PhosphorIcons.imageSquare,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ).onTap(pickedImage),
                          SizedBox(
                            height: context.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.7,
                            //         color: Colors.blue,

                            //color: Colors.red,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextInput(
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontSize: 15,
                                        ),
                                    hintText: 'Description',
                                    filled: false,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    controller: descriptionController,
                                  ),
                                ),
                                Container(
                                  height: .4,
                                  width: double.infinity,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoalFormField extends StatelessWidget {
  const GoalFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.08,
      width: MediaQuery.of(context).size.width,
      // color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      //color: Colors.red,
      child: Column(
        children: [
          TextInput(
            keyboardType: keyboardType,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 15,
                ),
            hintText: hintText,
            filled: false,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            controller: controller,
          ),
          Container(
            height: .4,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
