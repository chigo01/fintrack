import 'dart:developer';

import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/core/widgets/textfield.dart';
import 'package:fintrack/src/features/goals/models/goal.dat.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddGoalScreen extends StatelessWidget {
  const AddGoalScreen({Key? key, required this.goals}) : super(key: key);
  final GoalsList goals;

  @override
  Widget build(BuildContext context) {
    List<String> header = [
      'Name',
      'Amount',
      'Saved Already',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Goal'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: goals.color.withOpacity(.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        goals.imageUrl,
                        height: 70,
                        width: 100,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(goals.name),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: context.height * 0.6,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor.withOpacity(.1),
              child: Column(
                children: [
                  const GoalFormField(hintText: 'Name'),
                  const SizedBox(height: 20),
                  const GoalFormField(hintText: 'Target Amount'),
                  const SizedBox(height: 30),
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
                        const Text('Mar 12, 2023'),
                        Container(
                          height: 2,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ).onTap(() {
                    log('date');
                  }),
                  Container(
                    height: context.height * 0.08,
                    width: context.width,
                    // color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          child: Text(
                            'I have already saved',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.09,
                          width: MediaQuery.of(context).size.width * 0.3,
                          //         color: Colors.blue,

                          //color: Colors.red,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextInput(
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
                                controller: null,
                              ),
                              Container(
                                height: 2,
                                width: double.infinity,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
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
                        ),
                        SizedBox(
                          height: context.height * 0.09,
                          width: MediaQuery.of(context).size.width * 0.7,
                          //         color: Colors.blue,

                          //color: Colors.red,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextInput(
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
                                controller: null,
                              ),
                              Expanded(
                                child: Container(
                                  height: 2,
                                  width: double.infinity,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
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
  });
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.08,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      //color: Colors.red,
      child: Column(
        children: [
          TextInput(
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 15,
                ),
            hintText: hintText,
            filled: false,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            controller: null,
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: context.height * 0.1,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
