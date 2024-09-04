import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_event.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_state.dart';
import 'package:wp_test/presentation/widgets/input_field.dart';
import 'package:wp_test/presentation/widgets/primary_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() {
      context.read<ApiBloc>().add(ValidateUrl(url: _inputController.text));
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.title} Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          String? errorText;
          bool isButtonEnabled = false;

          if (state is ApiUrlValidation) {
            errorText = state.error;
            isButtonEnabled = state.error == null;
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: InputField(
                      label: 'API URL',
                      icon: Icons.link,
                      controller: _inputController,
                      validator: (value) {
                        if (errorText != null) {
                          return errorText;
                        }
                        return null;
                      },
                    ),
                  ),
                  Spacer(),
                  PrimaryButton(
                    text: 'Start',
                    //TODO: Remove this after implemented good validation in TextField
                    onPressed: isButtonEnabled
                        ? () {
                            context.read<ApiBloc>().add(
                                FetchTasks(endpoint: _inputController.text));

                            Navigator.of(context).pushNamed('/process');
                          }
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
