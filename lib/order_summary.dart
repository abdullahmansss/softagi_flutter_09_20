import 'package:flutter/material.dart';

class Model
{
  final String title;
  final String price;
  final String qty;
  final String image;

  Model({this.title, this.price, this.qty, this.image});
}

class OrderSummary extends StatefulWidget
{
  final String title;

  OrderSummary({this.title});

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary>
{
  dynamic initValue;
  String s = 'Delivery Option';
  var list = [
    Model(
      title: 'Abdullah',
      price: 'EGP 517.00',
      qty: '8',
      image: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/llqs2a7mkbsk8idlsttf/air-max-90-shoe-bd1PN5.jpg',
    ),
    Model(
      title: 'Omar Mahdy',
      price: 'EGP 800.00',
      qty: '2',
      image: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/llqs2a7mkbsk8idlsttf/air-max-90-shoe-bd1PN5.jpg',
    ),
    Model(
      title: 'Mustafa Gado',
      price: 'EGP 517.00',
      qty: '5',
      image: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/llqs2a7mkbsk8idlsttf/air-max-90-shoe-bd1PN5.jpg',
    ),
    Model(
      title: 'Abdullah Mansour Ali',
      price: 'EGP 777.00',
      qty: '1',
      image: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/llqs2a7mkbsk8idlsttf/air-max-90-shoe-bd1PN5.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.place,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          s,
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        value: 0,
                        groupValue: initValue,
                        onChanged: (value)
                        {
                          setState(()
                          {
                            print('click');
                            initValue = value;
                          });
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 15.0,
                            top: 15.0,
                            bottom: 15.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Amr Jamal',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      print('change address clicked');
                                    },
                                    child: Text(
                                      'Change Address',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Kafr El-Batikh Damietta, Egypt',
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                '01007031191',
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Zip code: 11357',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.radio_button_unchecked,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Add New Address',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.indigo,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.indigo,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                bottom: 15.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.ac_unit,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Shipment',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.amber[300],
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Delivered by Wednesday, Aug 12',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (ctx, index) => buildItem(list[index]),
                          separatorBuilder: (ctx, index) => Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                          itemCount: list.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'grand total:'
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                        '870.00 EGP',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          s = 'Abdullah Mansour';
                        });
                      },
                      child: Text(
                        'proceed to checkout'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(Model model) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      height: 70.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(
                  flex: 1,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        model.price,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                        'Qty:${model.qty}'
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                image: DecorationImage(
                  image: NetworkImage(model.image),
                  fit: BoxFit.cover,
                )
            ),
          ),
        ],
      ),
    ),
  );
}