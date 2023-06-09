import 'package:flutter/material.dart';
import 'package:manutencao_usc/src/infra/infra.dart';

class MenuInternoBotao extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final Color iconColor;
  final Function? onPressed;
  final Color? circleColor;
  final bool isCircleEnabled;
  final double betweenHeight;
  final dynamic page;
  final String? rota;

  // ignore: use_key_in_widget_constructors
  const MenuInternoBotao(
      {Key? key,
      this.label,
      this.icon,
      this.onPressed,
      this.iconColor = Colors.white,
      this.circleColor,
      this.isCircleEnabled = true,
      this.page,
      this.rota,
      this.betweenHeight = 5.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          abrirJanela(context, rota, page);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          isCircleEnabled
              ? CircleAvatar(
                  backgroundColor: circleColor,
                  radius: 20.0,
                  child: Icon(
                    icon,
                    size: 18.0,
                    color: iconColor,
                  ),
                )
              : Icon(
                  icon,
                  size: 18.0,
                  color: iconColor,
                ),
          SizedBox(
            height: betweenHeight,
          ),
          Text(
            label!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: Constantes.ralewayFont),
          )
        ],
      ),
    );
  }
}

abrirJanela(BuildContext context, String? rota, dynamic page) {
  if (page != null) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
  if (rota != '' && rota != null) {
    var pagina = Rotas.definirRotasWidget(rota);
    Navigator.push(context, MaterialPageRoute(builder: (context) => pagina));
    /*
    Navigator.pushNamed(
      context,
      rota,
    );
    */
  }
}
