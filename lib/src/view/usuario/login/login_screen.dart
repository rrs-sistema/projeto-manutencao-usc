// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../../view/usuario/recuperacao/forgot_password_screen.dart';
import './../../../view/usuario/core/colors/hex_color.dart';
import './../../../view/usuario/core/fade_animation.dart';
import './../../../view/shared/caixas_de_dialogo.dart';
import './../../../view/shared/gradiente_app.dart';
import './../../../database/app_db.dart';
import './../../../infra/constantes.dart';
import './../../../view/home_page.dart';
import './../../../infra/sessao.dart';

// FONTE: https://github.com/uzairdev2/Login-UI/tree/master/lib
enum FormData {
  matricula,
  password,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  bool ispasswordev = true;
  FormData? selected;

  TextEditingController matriculaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: gradienteApp(),
          image: DecorationImage(
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                HexColor("#fff").withOpacity(0.2), BlendMode.dstATop),
            image: const AssetImage(Constantes.backgroundLogin),
            //backgroundLogin
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeAnimation(
                  delay: 1,
                  child: Text("Manutenção USC - Login",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      )),
                ),
                Card(
                  elevation: 5,
                  color: Constantes.secondaryColor!.withOpacity(0.4),
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeAnimation(
                          delay: 0.8,
                          child: Image.asset(
                            Constantes.logoPrincipal,
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const FadeAnimation(
                          delay: 1,
                          child: Text(
                            "Faça login para continuar",
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.matricula
                                  ? Constantes.btnPrimary
                                  : Constantes.btnSecondary,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: matriculaController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.matricula;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: selected == FormData.matricula
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                                hintText: 'Matricula',
                                hintStyle: TextStyle(
                                    color: selected == FormData.matricula
                                        ? enabledtxt
                                        : deaible,
                                    fontSize: 12),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.matricula
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: selected == FormData.password
                                    ? Constantes.btnPrimary
                                    : Constantes.btnSecondary),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: passwordController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.password;
                                });
                              },
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.lock_open_outlined,
                                    color: selected == FormData.password
                                        ? enabledtxt
                                        : deaible,
                                    size: 20,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: ispasswordev
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: selected == FormData.password
                                                ? enabledtxt
                                                : deaible,
                                            size: 20,
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            color: selected == FormData.password
                                                ? enabledtxt
                                                : deaible,
                                            size: 20,
                                          ),
                                    onPressed: () => setState(
                                        () => ispasswordev = !ispasswordev),
                                  ),
                                  hintText: 'Senha',
                                  hintStyle: TextStyle(
                                      color: selected == FormData.password
                                          ? enabledtxt
                                          : deaible,
                                      fontSize: 12)),
                              obscureText: ispasswordev,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.password
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextButton(
                              onPressed: () async {
                                if (matriculaController.text == null ||
                                    matriculaController.text == '') {
                                  showInSnackBar(
                                      'Ops! Por favor informar a matricula.',
                                      corFundo: Constantes.btnSecondary,
                                      context);
                                  return;
                                }
                                if (passwordController.text == null ||
                                    passwordController.text == '') {
                                  showInSnackBar(
                                      'Ops! Por favor informar a senha.',
                                      corFundo: Constantes.btnSecondary,
                                      context);
                                  return;
                                }

                                Usuario? usuario = await Sessao.db.usuarioDao
                                    .logar(matriculaController.text,
                                        passwordController.text);
                                if (usuario != null && usuario.codigo! > 0) {
                                  final SharedPreferences prefs = await _prefs;
                                  prefs.setString('codigoUsuario',
                                      usuario.codigo.toString());
                                  prefs.setString(
                                      'nomeUsuario', usuario.nome.toString());
                                  prefs.setString(
                                      'emailUsuario', usuario.email.toString());
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const HomePage();
                                  }));
                                } else {
                                  if (!mounted) return;
                                  showInSnackBar(
                                      'Ops! Matricula ou senha invalida',
                                      corFundo: Constantes.btnSecondary,
                                      context);
                                  return;
                                }
                              },
                              // ignore: sort_child_properties_last
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                  //backgroundColor: Constantes.btnSecondary,
                                  backgroundColor: const Color(0xFF2697FF),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 80),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)))),
                        ),
                      ],
                    ),
                  ),
                ),

                //End of Center Card
                //Start of outer card
                const SizedBox(
                  height: 10,
                ),
                FadeAnimation(
                  delay: 1,
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const ForgotPasswordScreen();
                      }));
                    }),
                    child: Text("Não consegue fazer login?",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
