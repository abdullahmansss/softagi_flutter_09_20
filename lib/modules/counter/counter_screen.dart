import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/modules/counter/cubit/cubit.dart';
import 'package:flutter_app/modules/counter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class CounterScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<CounterCubit, CounterStates>(
      listener: (context, state)
      {
        if(state is AddCounterState)
        {
          Toast.show(state.s, context);
          CounterCubit.get(context).add();
        }

        if(state is SubCounterState)
        {
          Toast.show(state.s, context);
        }
      },
      builder: (context, state)
      {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Counter'
            ),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    CounterCubit.get(context).change(true);
                  },
                  child: Icon(
                    Icons.add,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  CounterCubit.get(context).count.toString(),
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                FloatingActionButton(
                  onPressed: () {
                    CounterCubit.get(context).change(false);
                  },
                  child: Icon(
                    Icons.remove,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}