import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  FormScreenState createState() => FormScreenState();
}

class FormScreenState extends State<FormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _name = '';
  String _age = '';
  String _dob = '';
  String _password = '';

  void _submitForm() {
    if (_nameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _dobController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Внимание'),
            content: const Text('Нужно обязательно заполнить все поля!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Form submission logic
      setState(() {
        _name = _nameController.text;
        _age = _ageController.text;
        _dob = _dobController.text;
        _password = _passwordController.text;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Имя'),
                onChanged: (value) {
                  if (value.isNotEmpty && !RegExp(r'^[а-яА-Яa-zA-Z ]+$').hasMatch(value)) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Ошибка'),
                          content: const Text('Разрешено вводить только буквы'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _nameController.text = _nameController.text.substring(0, _nameController.text.length - 1);
                                Navigator.pop(context);
                              },
                              child: const Text('ОК'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    _name = value;
                  }
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Возраст'),
                onChanged: (value) {
                  if (value.isNotEmpty && !RegExp(r'^[0-9]+$').hasMatch(value)) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Ошибка'),
                          content: const Text('Разрешено вводить только цифры'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _ageController.text = _ageController.text.substring(0, _ageController.text.length - 1);
                                Navigator.pop(context);
                                },
                              child: const Text('ОК'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    _age = value;
                  }
                },
              ),
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(labelText: 'Дата рождения'),
                onChanged: (value) {
                  if (value.isNotEmpty && !RegExp(r'^[0-9.]+$').hasMatch(value)) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Ошибка'),
                          content: const Text('Неверный формат даты\nПример ввода: 16.0.1980'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _dobController.text = _dobController.text.substring(0, _dobController.text.length - 1);
                                Navigator.pop(context);
                              },
                              child: const Text('ОК'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    _dob = value;
                  }
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Пароль'),
                obscureText: true,
                onChanged: (value) {
                  _password = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Здесь добавьте логику для загрузки изображения
                    },
                    icon: Icon(Icons.image),
                    label: Text('Загрузить изображение'),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get password => _password;

  String get dob => _dob;

  String get age => _age;

  String get name => _name;
}