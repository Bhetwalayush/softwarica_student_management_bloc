import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softwarica_student_management_bloc/core/common/snackbar/my_snackbar.dart';
import 'package:softwarica_student_management_bloc/features/auth/presentation/view/register_view.dart';
import 'package:softwarica_student_management_bloc/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:softwarica_student_management_bloc/features/home/presentation/view/home_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'kiran');
  final _passwordController = TextEditingController(text: 'kiran123');

  final _gap = const SizedBox(height: 8);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    // const Text(
                    //   'Login',
                    //   style: TextStyle(
                    //     fontSize: 30,
                    //     fontFamily: 'Brand Bold',
                    //   ),
                    // ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Brand Bold',
                          ),
                        );
                      },
                    ),
                    _gap,
                    TextFormField(
                      key: const ValueKey('username'),
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    TextFormField(
                      key: const ValueKey('password'),
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      }),
                    ),
                    _gap,
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_usernameController.text == 'kiran' &&
                              _passwordController.text == 'kiran123') {
                            // context.read<LoginBloc>().add(
                            //       LoginStudentEvent(
                            //         email: _usernameController.text,
                            //         password: _passwordController.text,
                            //       ),
                            //     );

                            context.read<LoginBloc>().add(
                                  NavigateHomeScreenEvent(
                                    destination: HomeView(),
                                    context: context,
                                  ),
                                );
                          } else {
                            showMySnackBar(
                              context: context,
                              message: 'Invalid username or password',
                              color: Colors.red,
                            );
                          }
                        }
                      },
                      child: const SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Brand Bold',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      key: const ValueKey('registerButton'),
                      onPressed: () {
                        context.read<LoginBloc>().add(
                          NavigateRegisterScreenEvent(
                                destination: RegisterView(),
                                context: context,
                              ),
                            );
                      },
                      child: const SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Brand Bold',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
