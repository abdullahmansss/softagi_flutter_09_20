import 'package:flutter/material.dart';
import 'package:flutter_app/modules/check/cubit/cubit.dart';
import 'package:flutter_app/modules/check/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider<CheckCubit>(
        create: (context) => CheckCubit(),
        child: BlocConsumer<CheckCubit,CheckStates>(
          listener: (context, state){},
          builder: (context, state){
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: CheckCubit.get(context).chocolate,
                        onChanged: (chocolateNew)
                        {
                          CheckCubit.get(context).checkChocolate(chocolateNew);
                        },
                      ),
                      Text(
                          'Chocolate'
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: CheckCubit.get(context).mocca,
                        onChanged: (moccaNew)
                        {
                          CheckCubit.get(context).checkMocca(moccaNew);
                        },
                      ),
                      Text(
                          'Mocca'
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}