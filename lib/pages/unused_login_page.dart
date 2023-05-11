import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:service_learning_website/widgets/app_bar_g.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool enableLogin() => (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty);
  bool enableLoginBT = false;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() {
      if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
        setState(() {
          enableLoginBT = true;
        });
      } else {
        setState(() {
          enableLoginBT = false;
        });
      }
    });
    passwordController.addListener(() {
      if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
        setState(() {
          enableLoginBT = true;
        });
      } else {
        setState(() {
          enableLoginBT = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              const AppBarG(),
            ];
          },
          body: LayoutBuilder(
            builder:(BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Align(
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      width: 400,
                      height: 500,
                      padding: const EdgeInsets.only(left: 50,right: 50),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: enableLoginBT
                                ? const Color(0xFF00ba7c).withOpacity(.6)
                                : const Color(0xFFff4060).withOpacity(.6),
                            spreadRadius: -50,
                            blurRadius: 100,
                            offset: const Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Card(
                        elevation: 0,
                        color: const Color(0xFFf5f5f5),
                        shadowColor: enableLoginBT
                            ? const Color(0xFF00ba7c)
                            : const Color(0xFFff4060),
                        child: Container(
                          padding: const EdgeInsets.only(left: 25,right: 25),
                          child: Form(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50,),
                                const Icon(Icons.account_circle,color: Color(0xFF474747),size: 60,),
                                const SizedBox(height: 20,),
                                const Text('LOGIN',style: TextStyle(color: Color(0xFF474747),fontSize: 20),),
                                const SizedBox(height: 40,),
                                TextFormField(
                                  controller: usernameController,
                                  cursorColor: const Color(0xFF474747),
                                  style: const TextStyle(color: Color(0xFF474747)),
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(width: 1,color: Color(0xFF474747))
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(width: 1,color: Color(0xFF474747))
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(width: 1,color: Color(0xFFff4060))
                                    ),
                                    // border: UnderlineInputBorder(
                                    //   borderSide: BorderSide(width: 3,color: Color(0xFFFFFFFF))
                                    // ),
                                    labelText: 'USERNAME',
                                    labelStyle: TextStyle(color: Color(0xFF474747),fontSize: 12),
                                  ),
                                ),
                                const SizedBox(height: 15,),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  cursorColor: const Color(0xFF474747),
                                  style: const TextStyle(color: Color(0xFF474747)),
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(width: 1,color: Color(0xFF474747))
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(width: 1,color: Color(0xFF474747))
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(width: 1,color: Color(0xFFff4060))
                                      ),
                                      // border: UnderlineInputBorder(
                                      //   borderSide: BorderSide(width: 3,color: Color(0xFFFFFFFF))
                                      // ),
                                      labelText: 'PASSWORD',
                                      labelStyle: TextStyle(color: Color(0xFF474747),fontSize: 12)
                                  ),
                                ),
                                const SizedBox(height: 75,),
                                ShakeWidget(
                                  duration: const Duration(milliseconds: 500),
                                  shakeConstant: ShakeDefaultConstant2(),
                                  autoPlay: false,
                                  enableWebMouseHover: enableLoginBT ? false : true,
                                  child: ElevatedButton(
                                    onPressed: !enableLoginBT
                                        ? null
                                        : () {
                                      // go  further.
                                    },// used with firebase
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size.zero,
                                        padding: const EdgeInsets.all(0),
                                      ),
                                    child: AnimatedContainer(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: enableLoginBT
                                            ? const Color(0xFF00ba7c)
                                            : const Color(0xFFff4060),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 6),
                                      duration: const Duration(milliseconds: 600),
                                      child: const Center(
                                        child: Text(
                                          'LOGIN',
                                          style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
    );
  }
}
