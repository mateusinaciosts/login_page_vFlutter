import 'package:flutter/material.dart';
import 'package:login_firebase/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:tag_ui/tag_ui.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool islogin = true;
  late String actionButtom = "xx";
  late String alternanciaButtom = "xx";
  bool loading = false;

  setFormAction(bool acao) {
    setState(() {
      islogin = acao;
      if (islogin) {
        actionButtom = "Entrar";
        alternanciaButtom = "Ainda não tem conta! Cadastre-se agora.";
      } else {
        actionButtom = "Cadastrar";
        alternanciaButtom = "Volta ao Login";
      }
    });
  }

  entrar() async {
    setState(() {
      loading = true;
    });
    try {
      await context
          .read<AuthService>()
          .entrar(_emailController.text, _passwordController.text);
    } on AuthException catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.messagem)));
    }
  }

  registrar() async {
    setState(() {
      loading = true;
    });
    try {
      await context
          .read<AuthService>()
          .registar(_emailController.text, _passwordController.text);
    } on AuthException catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.messagem)));
    }
  }

  @override
  void initState() {
    setFormAction(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('assets/imagens/logo.png'),
                TagTextField(
                  controller: _emailController,
                  label: "Email",
                  value: "",
                  validator: (usuario) {
                    if (usuario == null || usuario.isEmpty) {
                      return 'Por favor, digite seu Usuario.';
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_emailController.text)) {
                      return 'Por favor, digite um e-mail correto';
                    }
                    return null;
                  },
                ),
                TagTextField(
                  obscureText: true,
                  label: "Senha",
                  value: "",
                  controller: _passwordController,
                  validator: (senha) {
                    if (senha == null || senha.isEmpty) {
                      return 'Por favor, digite sua senha.';
                    }
                    if (senha.length < 6) {
                      return 'seu dever ter no minimo 6 caracteres';
                    }
                    return null;
                  },
                ),
                Column(
                    children: (loading)
                        ? [
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ]
                        : [
                            TagButton(
                              text: actionButtom,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (islogin) {
                                    entrar();
                                  } else {
                                    registrar();
                                  }
                                }
                              },
                            ),
                          ]),
                TagLinkButton(
                  text: alternanciaButtom,
                  onPressed: () {
                    setFormAction(!islogin);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
