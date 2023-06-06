import 'package:flutter/material.dart';

import '../../../data/themes.dart';
import 'package:carousel_slider/carousel_slider.dart';

class VisitsPage extends StatelessWidget {
  VisitsPage({Key? key}) : super(key: key);
  List<String> images = [
    'https://www.consultoriaprocesos.com/wp-content/uploads/2019/05/grafico-control-proceso-1.png',
    'https://steemitimages.com/p/2gsjgna1uruvUuS7ndh9YqVwYGPLVszbFLwwpAYXZAxHr5bUXdS9Xbr4P7hwgSZ6JcTgdMNVgsozCDa7HdBAJJMFQJAzdvhnw28ChdsXAYEnnuk3dY?format=match&mode=fit&width=640',
    'https://www.consultoriaprocesos.com/wp-content/uploads/2019/05/grafico-control-proceso-1.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plan de visitas',
          style: TextStyle(color: kAppBar, fontSize: 16),
        ),
        backgroundColor: kWhite,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
        width: double.infinity,
        child: Column(
          children: [
            _nameCompany(),
            const Divider(),
            _infoUser(),
            SizedBox(height: 10),
            _slider(),
            const SizedBox(height: 7),
            _agenda(),
            SizedBox(height: 20),
            _buttonInit(context),
          ],
        ),
      ),
    );
  }

  SizedBox _buttonInit(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 48,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: kGreen,
        ),
        child: const Text('INICIAR VISITA',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: kWhite)),
      ),
    );
  }

  Container _agenda() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 7),
          Text(
            'Agenda',
            style: TextStyle(fontSize: 16, color: kGrey800),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 84,
                width: 104,
                padding: EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kGrey100,
                    border: Border.all(width: 1, color: kGrey400)),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '06',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text('Días del carro con productos',
                        style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              Container(
                height: 84,
                width: 104,
                padding: EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kGrey100,
                    border: Border.all(width: 1, color: kGrey400)),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '1200',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text('Galone por vender', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              Container(
                height: 84,
                width: 104,
                padding: EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kGrey100,
                    border: Border.all(width: 1, color: kGrey400)),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'S/5800',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text('Deuda por cobrar', style: TextStyle(fontSize: 12))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _slider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 150.0, // Ajusta la altura del slider según tus necesidades
            autoPlay: false, // Habilita la reproducción automática
          ),
          items: images.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 7),
        const Text('Desarrollo del cliente')
      ],
    );
  }

  Container _infoUser() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'VERONICA ARENAS MAMANI',
          style: TextStyle(fontSize: 20, color: kAppBar),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                    color: kGrey200,
                    border: Border.all(width: 1, color: kGrey200),
                    borderRadius: BorderRadius.circular(16)),
                child: const Text(
                  '45 Años',
                  style: TextStyle(fontSize: 12, color: kGrey800),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                    color: kGrey200,
                    border: Border.all(width: 1, color: kGrey200),
                    borderRadius: BorderRadius.circular(16)),
                child: const Text(
                  'Exigente',
                  style: TextStyle(fontSize: 12, color: kGrey800),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                    color: kGrey200,
                    border: Border.all(width: 1, color: kGrey200),
                    borderRadius: BorderRadius.circular(16)),
                child: const Text(
                  'Ocupada',
                  style: TextStyle(fontSize: 12, color: kGrey800),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: kGrey200,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: kGrey400,
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_2_outlined,
                      size: 50,
                      color: kGrey400,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: const Text(
                    'Veronica es unapersona que se destaca por su empatia, trato amable y valentia al enfrentar los desafios del cambio tecnologico en sus labores diarias, a pesar de no tener un titulo profesional, es de confiar, y muy cumplida en sus pagos ',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: TextStyle(fontSize: 14, color: kGrey600),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Row _nameCompany() {
    return Row(children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.only(right: 15),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 1.0, color: kGrey200),
            ),
          ),
          child: const Column(children: [
            Text(
              'REPRESENTACIONES CABAÑA DIESEL',
              style: TextStyle(fontSize: 20, color: kAppBar),
            ),
            Row(
              children: [
                Text(
                  'Ultima visita:',
                  style: TextStyle(fontSize: 14, color: kGrey600),
                ),
                SizedBox(width: 5),
                Text('HOY', style: TextStyle(color: kGrey800)),
                SizedBox(width: 5),
                Text('10:20 AM', style: TextStyle(color: kGrey800))
              ],
            )
          ]),
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 15),
        child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scoring',
                style: TextStyle(fontSize: 16, color: kGrey600),
              ),
              Text('A14323', style: TextStyle(fontSize: 20, color: kGreen)),
            ]),
      ),
    ]);
  }
}
