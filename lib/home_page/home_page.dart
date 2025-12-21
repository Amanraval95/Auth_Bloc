import 'package:auth_bloc/bottom_navigation/add_item/add_item.dart';
import 'package:auth_bloc/bottom_navigation/add_item/add_item_bloc/item_bloc.dart';
import 'package:auth_bloc/bottom_navigation/add_item/add_item_bloc/item_event.dart';
import 'package:auth_bloc/bottom_navigation/bottom_nav_bloc/nav_event.dart';
import 'package:auth_bloc/bottom_navigation/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bottom_navigation/bottom_nav_bloc/nav_bloc.dart';
import '../../bottom_navigation/bottom_nav_bloc/nav_state.dart';
import '../auth/auth_bloc/auth_bloc.dart';
import '../auth/auth_bloc/auth_state.dart';
import '../auth/auth_pages/LoginPage.dart';

class HomePage extends StatelessWidget {
  final List<Widget> pages = [AddItem(), Profile()];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavBloc()),
        BlocProvider(
          create: (_) =>
              ItemBloc(FirebaseAuth.instance.currentUser!.uid)
                ..add(LoadItemsEvent()),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LoginPage()),
            );
          }
        },
        child: Scaffold(
          body: BlocBuilder<NavBloc, NavState>(
            builder: (context, navState) {
              return IndexedStack(
                index: navState.currentIndex,
                children: pages,
              );
            },
          ),
          bottomNavigationBar: BlocBuilder<NavBloc, NavState>(
            builder: (context, navstate) {
              return Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  selectedIconTheme: const IconThemeData(color: Colors.black),
                  selectedItemColor: Colors.black,

                  onTap: (index) {
                    context.read<NavBloc>().add(ChangeTabEvent(index));
                  },
                  currentIndex: navstate.currentIndex,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.add_box),
                      label: "Add",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_pin_rounded),
                      label: "profile",
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
