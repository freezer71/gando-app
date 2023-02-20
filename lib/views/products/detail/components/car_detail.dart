import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/models/Car.dart';
import 'package:gando/models/ProfileSeller.dart';
import 'package:gando/views/products/booking/booking_screen.dart';
import 'package:gando/views/seller/profile_screen.dart';
import 'package:gando/widget/reusable/cache_image_network.dart';
import 'package:get/get.dart';

class CarDetailPage extends StatefulWidget {
  final Car car;

  const CarDetailPage({Key? key, required this.car}) : super(key: key);

  @override
  State<CarDetailPage> createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  int _quantity = 0;
  late Car car;
  late List<String> _carImagesList = [];
  bool _iscollected = false;

  int _currentImageSlider = 0;

  final List equipmentsList = [
    {'name': 'Climatisation'},
    {'name': 'Régulateur de vitesse'},
    {'name': 'Radio'},
    {'name': 'Siège enfant'},
    {'name': 'GPS'},
  ];

  final List featuresList = [
    {'name': 'Kilomètrage', 'icon': Icons.speed, 'value': '50-100 000 km'},
    {
      'name': 'Boite de vitesse',
      'icon': Icons.cable_rounded,
      'value': 'Automatique'
    },
    {'name': 'Places', 'icon': Icons.six_ft_apart_outlined, 'value': '5'},
    {'name': 'Carburant', 'icon': Icons.ev_station, 'value': 'Diesel'},
    {'name': 'Portes', 'icon': Icons.car_crash_outlined, 'value': '3'},
  ];

  final List reviewsList = [
    {
      'name': 'Lisa',
      'rate': '5/5',
      'image': 'assets/images/av.png',
      'description':
          'Voiture propre et conforme a l\'annonce\n Facile a conduire et qui roule tres bien.'
    },
    {
      'name': 'Marco',
      'rate': '4/5',
      'image': 'assets/images/av.png',
      'description':
          'Voiture propre et conforme a l\'annonce\n Facile a conduire et qui roule tres bien.'
    },
    {
      'name': 'Vicent',
      'rate': '3/5',
      'image': 'assets/images/av.png',
      'description':
          'Voiture propre et conforme a l\'annonce\n Facile a conduire et qui roule tres bien.'
    },
    {
      'name': 'Thierry',
      'rate': '5/5',
      'image': 'assets/images/av.png',
      'description':
          'Voiture propre et conforme a l\'annonce\n Facile a conduire et qui roule tres bien.'
    },
    {
      'name': 'Nagulan',
      'rate': '4/5',
      'image': 'assets/images/av.png',
      'description':
          'Voiture propre et conforme a l\'annonce\n Facile a conduire et qui roule tres bien.'
    },
  ];

  late ProfileSeller profileSeller;

  @override
  void initState() {
    car = widget.car;
    _carImagesList.addAll([APP_FILE+car.images!.supplementaire.toString(),
        APP_FILE+car.images!.avant34.toString(),
        APP_FILE+car.images!.ariere34.toString(),
        APP_FILE+car.images!.lateral.toString(),
        APP_FILE+car.images!.interieur.toString(),]
    );

    profileSeller = ProfileSeller(
      'Marco DEGARDIO',
      'assets/images/av.png',
      'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum  ',
      8,
      2,
      [],
      true,
      '5/5',
      DateTime.now(),
    );

    super.initState();
  }

  @override
  void dispose() {
    _carImagesList.clear();
    _currentImageSlider = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor.withOpacity(0.9),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: true,
                backgroundColor: AppTheme.backgroundColor,
                expandedHeight: Get.height / 3.5,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: AppTheme.light,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  // title: Container(
                  //   child: Text("${car.brand}", style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  //       color: AppTheme.darkColor,
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w900),),
                  // ),
                  background: CarouselSlider(
                    items: _carImagesList
                        .map((item) {
                          printInfo(info: "item: $item");
                      return Container(
                        child: buildCacheNetworkImage(
                            width: 0, height: 0, url: item),
                      );
                    })
                        .toList(),
                    options: CarouselOptions(
                        initialPage: 0,
                        aspectRatio: 1,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: true,
                        autoPlay: false,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentImageSlider = index;
                          });
                        }),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._buildTitle(),
                      const SizedBox(height: 20),
                      ..._buildDescriptionPlanKilometer(),
                      _buildSpacerHeight(),
                      _buildSeller(),
                      _buildSpacerHeight(),
                      ..._buildDescription(),
                      _buildSpacerHeight(),
                      ..._buildCarCondition(),
                      _buildSpacerHeight(),
                      ..._buildEquipment(),
                      _buildSpacerHeight(),
                      ..._buildFeatures(),
                      _buildSpacerHeight(),
                      ..._buildReviews(),
                      const SizedBox(height: 200),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buldFloatBar()
        ],
      ),
    );
  }

  List<Widget> _buildTitle() {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width / 1.8,
                  child: Text(car.brand!,
                      maxLines: 3,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          overflow: TextOverflow.fade,
                          color: AppTheme.darkColor)),
                ),
                Text(
                  car.model!,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppTheme.darkColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: AppTheme.darkColor,
            ),
            child: Text(
              '${car.pricePerDay} €',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppTheme.backgroundColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: AppTheme.primaryColor,
            ),
            child: Icon(
              Icons.star,
              color: AppTheme.backgroundColor,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '4.8 (53 avis)',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: AppTheme.darkColor,
                fontSize: 14,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    ];
  }

  Widget _buildSpacerHeight() {
    return SizedBox(height: 30);
  }

  Widget _buildSpacerWidth(width) {
    return SizedBox(width: width);
  }

  Widget _buildLine() {
    return Container(height: 1, color: AppTheme.darkColor.withOpacity(0.3));
  }

  List<Widget> _buildEquipment() {
    return [
      Row(
        children: [
          Text('Equipements',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppTheme.darkColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900)),
        ],
      ),
      const SizedBox(height: 22),
      Container(
        child: GridView.builder(
            padding: EdgeInsets.zero,
            key: Get.keys[2],
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: equipmentsList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
                childAspectRatio: 2),
            itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      color: AppTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      equipmentsList[index]['name'],
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppTheme.darkColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
      ),
    ];
  }

  List<Widget> _buildReviews() {
    Widget buildBox(index) => Container(
          height: 120,
          margin: EdgeInsets.symmetric(vertical: 10),
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            color: AppTheme.backgroundColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 65,
                  width: 65,
                  child: CircleAvatar(
                    backgroundColor: AppTheme.backgroundColor,
                    backgroundImage: const AssetImage(
                      'assets/images/av.png',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reviewsList[index]['name'],
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppTheme.darkColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        reviewsList[index]['description'],
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppTheme.darkColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                      // name of seller wiil be here
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: AppTheme.primaryColor,
                      ),
                      child: Icon(
                        Icons.star,
                        color: AppTheme.backgroundColor,
                      ),
                    ),
                    _buildSpacerWidth(10.0),
                    Text(reviewsList[index]['rate'],
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppTheme.darkColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500))
                  ],
                )
              ],
            ),
          ),
        );

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Avis',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppTheme.darkColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900)),
          Container(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Voir plus',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppTheme.darkColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: AppTheme.darkColor,
                  )
                ],
              )),
        ],
      ),
      const SizedBox(height: 8),
      Container(
        height: Get.height / 1.6,
        child: Column(
          children: List.generate(3, (index) => buildBox(index)),
        ),
      ),
    ];
  }

  List<Widget> _buildFeatures() {
    Widget buildBox(index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: AppTheme.backgroundColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    featuresList[index]['icon'],
                    color: AppTheme.darkColor.withOpacity(0.3),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(featuresList[index]['name'],
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppTheme.darkColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w900)),
                ],
              ),
              Text(featuresList[index]['value'],
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.redColor,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w900))
            ],
          ),
        );

    return [
      Text('Caratéristiques Techniques',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: AppTheme.darkColor,
              fontSize: 20,
              fontWeight: FontWeight.w900)),
      const SizedBox(height: 22),
      ListView.builder(
        padding: EdgeInsets.zero,
        key: Get.keys[3],
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: featuresList.length,
        // : const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 3,
        //     mainAxisSpacing: 10,
        //     crossAxisSpacing: 5,
        //     childAspectRatio: 1.7
        // ),
        itemBuilder: (context, index) => buildBox(index),
      ),
    ];
  }

  List<Widget> _buildDescriptionPlanKilometer() {
    return [
      Row(
        children: [
          Text('Forfait Kilometrique',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppTheme.darkColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900)),
          const SizedBox(width: 8),
          Icon(
            Icons.info_outline_rounded,
            color: AppTheme.darkColor,
            size: 20,
          )
        ],
      ),
      const SizedBox(height: 8),
      ExpandableText(
        '250 Km sont inclus pour 1 journée, au dela du forfait +0,24 €/km vous sera ajouté.',
        expandText: ' Voir plus',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: AppTheme.darkColor,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        collapseText: ' Voir moins',
        linkStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: AppTheme.redColor,
            fontSize: 14,
            fontWeight: FontWeight.w600),
      ),
    ];
  }

  List<Widget> _buildCarCondition() {
    return [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: AppTheme.backgroundColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        width: Get.width,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Condition de location',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppTheme.darkColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w900),
            ),
            Text(
              '• 18 ans minimum\n • Jeunes conducteurs autorisés de 0 à 2 ans',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppTheme.darkColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ) // name of seller wiil be here
          ],
        ),
      ),
    ];
  }

  Widget _buildSeller() {
    return Container(
      height: 120,
      margin: EdgeInsets.zero,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: AppTheme.backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 65,
              width: 65,
              child: CircleAvatar(
                backgroundColor: AppTheme.backgroundColor,
                backgroundImage: const AssetImage(
                  'assets/images/av.png',
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Marco DEGARDIO',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    '8 locations déja effectuées\nMembres depuis 2022',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  )
                  // name of seller wiil be here
                ],
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppTheme.redColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {
                  Get.to(() => SellerProfileScreen(
                        seller: profileSeller,
                      ));
                },
                child: Text(
                  'Voir le Profil',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.backgroundColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ))
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDescription() {
    return [
      Text('Description du véhicule',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: AppTheme.darkColor,
              fontSize: 18,
              fontWeight: FontWeight.w900)),
      const SizedBox(height: 8),
      ExpandableText(
        'Lorem  tempor incididunt ut labore et Lorem ipsum Lorem ipsum dolor sit amet',
        expandText: ' Voir plus',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: AppTheme.darkColor,
            fontSize: 14,
            fontWeight: FontWeight.w600),
        collapseText: ' Voir moins',
        linkStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: AppTheme.redColor,
            fontSize: 14,
            fontWeight: FontWeight.w600),
      ),
    ];
  }

  Widget _buildQuantity() {
    return Row(
      children: [
        const Text('Quantity',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(width: 20),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            color: Color(0xFFF3F3F3),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                InkWell(
                  child: Icon(
                    Icons.remove,
                    color: AppTheme.darkColor,
                  ),
                  onTap: () {
                    if (_quantity <= 0) return;
                    setState(() => _quantity -= 1);
                  },
                ),
                const SizedBox(width: 20),
                Text('$_quantity',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18)),
                const SizedBox(width: 20),
                InkWell(
                  child: Icon(
                    Icons.add,
                    color: AppTheme.darkColor,
                  ),
                  onTap: () => setState(() => _quantity += 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buldFloatBar() {
    buildAddCard() => Container(
          height: 58,
          width: Get.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: AppTheme.primaryColor,
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 20,
                color: const Color(0xFF101010).withOpacity(0.25),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              // splashColor: const Color(0xFFEEEEEE),
              onTap: () {
                //got to next page
                Get.to(() => BookingScreen(
                      car: car,
                    ));
              },
              child: Center(
                child: Text(
                  'Continuer'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    // go to signalisation page
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flag,
                        color: AppTheme.redColor,
                      ),
                      const Text('Signaler l\'annonce',
                          style: TextStyle(
                              color: Color(0xFF757575), fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                buildAddCard()
              ],
            ),
            // const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
