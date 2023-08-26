class HangoutDetailModel {
  String about;
  String phone;
  String website;
  String loc;
  String image;

  HangoutDetailModel({
    required this.about,
    required this.phone,
    required this.website,
    required this.loc,
    required this.image,
  });
}

HangoutDetailModel? getHangoutDetailModelByKey(String key) {
  final hangoutData = hangoutsDetails[key];
  return HangoutDetailModel(
    about: hangoutData['about'],
    phone: hangoutData['phone'],
    website: hangoutData['website'],
    loc: hangoutData['loc'],
    image: hangoutData['image'],
  );
}

Map<String, dynamic> hangoutsDetails = {
  'Masala Mix': {
    'about': 'Masala Mix IIT Delhi',
    'phone': '9810061748',
    'website': 'http://www.masala-mix.com/',
    'loc': 'https://maps.app.goo.gl/AvTGMW63za8SKddZ9',
    'image':
        'https://content.jdmagicbox.com/comp/delhi/z6/011pxx11.xx11.181113202746.h7z6/catalogue/masala-mix-hauz-khas-delhi-l801s9i1wn.jpg'
  },
  'Cafe Coffee Day': {
    'about':
        'The famous Café cum restaurant, serving coffee, cakes and sandwiches at subsidized rates.',
    'phone': '+9118001025093',
    'website':
        'https://www.tripadvisor.in/ShowUserReviews-g304551-d13190474-r551981783-Cafe_Coffee_Day-New_Delhi_National_Capital_Territory_of_Delhi.html',
    'loc':
        'https://www.google.com/maps/place/Caf%C3%A9+Coffee+Day/@28.5453802,77.192356,15z/data=!4m2!3m1!1s0x0:0xefd3c272b0349c81?sa=X&ved=2ahUKEwiPjMz4p9LqAhUTILcAHVS6BSQQ_BIwG3oECBkQCA',
    'image':
        'https://media-cdn.tripadvisor.com/media/photo-s/11/b2/71/6b/a-nice-overall-ambience.jpg'
  },
  'Amul Cafe': {
    'about': 'Serves Amul Products',
    'phone': '8447963877',
    'website':
        'https://www.justdial.com/Delhi/Amul-Cafe-Registrar-IIT-New-Delhi/011PXX11-XX11-170113083022-Y6Z3_BZDET',
    'loc':
        'https://www.google.com/maps/place/Amul+Cafe/@28.5449093,77.1898985,17z/data=!4m8!1m2!2m1!1samul+iit+delhi!3m4!1s0x390d1df6f4d3717f:0xfbe464f1c1ada2b9!8m2!3d28.5448431!4d77.191546?hl=en',
    'image':
        'https://content.jdmagicbox.com/comp/delhi/z3/011pxx11.xx11.170113083022.y6z3/catalogue/amul-cafe-registrar-iit-new-delhi-delhi-coffee-shops-kemiks5i3f.jpg'
  },
  'Shiru Cafe': {
    'about':
        'The famous Café cum restaurant, serving coffee, cakes and sandwiches at subsidized rates.',
    'phone': '',
    'website': 'http://global.shirucafe.com/',
    'loc':
        'https://www.google.com/maps/place/Amul+Cafe/@28.5449093,77.1898985,17z/data=!4m8!1m2!2m1!1samul+iit+delhi!3m4!1s0x390d1df6f4d3717f:0xfbe464f1c1ada2b9!8m2!3d28.5448431!4d77.191546?hl=en',
    'image':
        'https://lh5.googleusercontent.com/p/AF1QipPwjFBO9V5CCLUo8ue9QeL6uA_bROyOKRg_isAy=w408-h288-k-no'
  },
  'HPMC Store': {
    'about':
        'H.P. Horticulture Produce Marketing & Processing Corporation Juice Shop.',
    'phone': '',
    'website': 'https://hpmc.gov.in/',
    'loc':
        'https://www.google.com/maps/place/HPMC+store/@28.5447125,77.1894686,17z/data=!3m1!4b1!4m5!3m4!1s0x390d1df65f7e86b5:0xa7db5cd397466521!8m2!3d28.5447125!4d77.1916573?hl=en',
    'image':
        'https://lh5.googleusercontent.com/p/AF1QipMME0vkTNa9mOMG4ev7BFpjYU8b0MoExvrEyV53=w426-h240-k-no'
  },
  'Nescafe': {
    'about': 'The place to enjoy Maggi, coffee, sandwiches and more.',
    'phone': '',
    'website': '',
    'loc':
        'https://www.google.com/maps/place/HPMC+store/@28.5447125,77.1894686,17z/data=!3m1!4b1!4m5!3m4!1s0x390d1df65f7e86b5:0xa7db5cd397466521!8m2!3d28.5447125!4d77.1916573?hl=en',
    'image': 'https://blogs.ubc.ca/dominicinindia/files/2012/09/D-Nescafe.jpg'
  },
  'Staff Canteen': {
    'about':
        'IIT Delhi\'s Staff Canteen. Unlike its name, it is open to all and provides clean, hygenic and affordable meals.',
    'phone': '',
    'website': '',
    'loc':
        'https://www.google.com/maps/place/Staff+Canteen/@28.5435735,77.1912549,15z/data=!4m2!3m1!1s0x0:0x6cda61906d75bd1b?sa=X&hl=en&ved=2ahUKEwjKgZOX9dTqAhXQyjgGHc9YDRkQ_BIwG3oECBMQCA',
    'image':
        'https://qph.fs.quoracdn.net/main-qimg-9716df72fc0640634a9e7cd2cdaa1c96'
  },
  'Rajdhani Chatkare Foods': {
    'about': 'Affordable snacks and meals across cuisines available here.',
    'phone': '+919999916948',
    'website':
        'https://www.zomato.com/ncr/rajdhani-chatkhare-food-hauz-khas-new-delhi',
    'loc':
        'https://www.google.com/maps/place/Rajdhani+Chatkare+Foods/@28.5482115,77.1842648,15z/data=!4m2!3m1!1s0x0:0x9afe153cd05ebaa2?sa=X&hl=en&ved=2ahUKEwjGmuG099TqAhXI7XMBHZSOAdsQ_BIwCnoECBcQCA',
    'image':
        'https://content3.jdmagicbox.com/comp/delhi/j6/011pxx11.xx11.180505105548.e1j6/catalogue/rajdhani-chatkhare-food-hauz-khas-delhi-home-delivery-restaurants-xokptgx3q6.jpg'
  },
  'Chaayos': {
    'about':
        'Chaayos\' IIT Delhi outlet. Subsidized rates, amazing ambience and some great chai.',
    'website':
        'https://www.tripadvisor.in/ShowUserReviews-g304551-d10382590-r561220093-Chaayos_Hauz_Khas_Village-New_Delhi_National_Capital_Territory_of_Delhi.html',
    'loc':
        'https://www.google.com/maps/search/chaayos+iit+delhi/@28.5463959,77.1867586,20.99z',
    'phone': '+919821193375',
    'image':
        'https://lh5.googleusercontent.com/p/AF1QipMYZgJ_inQG0r9zw6YRa30s7kGnC6kX39EWwAWU=w408-h272-k-no'
  },
  'Roopsagar Bakery': {
    'about':
        'This bakery serves pure-vegetarian treats such as cakes, pastries, cookies, snacks, cheesecakes and muffins.',
    'phone': '+917838118004',
    'website':
        'https://www.justdial.com/Delhi/Roop-Sagar-Bakery-Jia-Sarai-IIT/011PXX11-XX11-140624095712-G2R4_BZDET',
    'loc':
        'https://www.google.com/maps/place/Roopsagar+Bakery/@28.5462598,77.1867701,20.99z/data=!4m8!1m2!2m1!1schaayos+iit+delhi!3m4!1s0x390d1df3d079797d:0xad66433f77174401!8m2!3d28.5464176!4d77.1866872',
    'image': 'https://img4.nbstatic.in/tr:w-500/5b0277acd60180000c8384fc.jpg'
  },
  'Quiet Kitchen': {
    'about': 'Quiet Kitchen IIT Delhi',
    'website': 'https://www.nearbuy.com/delhi-ncr/quiet-kitchen-iit-campus',
    'loc':
        'https://www.google.com/maps/place/Roopsagar+Bakery/@28.5462598,77.1867701,20.99z/data=!4m8!1m2!2m1!1schaayos+iit+delhi!3m4!1s0x390d1df3d079797d:0xad66433f77174401!8m2!3d28.5464176!4d77.1866872',
    'phone': '',
    'image': 'https://img4.nbstatic.in/tr:w-500/5cbdb3e7d60180000d7ad0f2.png'
  },
  'Shadab Cafe': {
    'about': 'Shadab Cafe, near Zanskar Hostel IIT Delhi',
    'phone': '',
    'website': '',
    'loc':
        'https://www.google.com/maps/place/Shadab+Cafe/@28.5470604,77.1864516,21z/data=!4m8!1m2!2m1!1schaayos+iit+delhi!3m4!1s0x390d1d42fb9211cd:0x37259187a509c7af!8m2!3d28.5471686!4d77.1863379',
    'image': 'assets/images/shadab.jpeg'
  },
  'Koolees': {
    'about': 'Koolees Shakes and Ice Creams',
    'phone': '',
    'website': '',
    'loc':
        'https://www.google.com/maps/place/Koolees/@28.5483362,77.1841118,3a,75y,90t/data=!3m8!1e2!3m6!1sAF1QipODhrEABfAzgrLd8HtyX6iYGnmanW9_qx5eYjMt!2e10!3e12!6shttps:%2F%2Flh5.googleusercontent.com%2Fp%2FAF1QipODhrEABfAzgrLd8HtyX6iYGnmanW9_qx5eYjMt%3Dw203-h114-k-no!7i1920!8i1080!4m8!1m2!2m1!1schaayos+iit+delhi!3m4!1s0x390d1df2610d33ab:0xcee0f14dea219558!8m2!3d28.5482842!4d77.1842343',
    'image': 'assets/images/koolees.jpeg'
  },
  'Chai Point': {
    'about':
        'Best place for a cup of tea inside IIT and it\'s quite pocket friendly as well.',
    'loc':
        'https://www.google.com/maps/place/Chai+point/@28.5438559,77.1933482,21z/data=!4m12!1m6!3m5!1s0x390d1df15770dce3:0xbb86890ffb8130d9!2sApollo+Pharmacy!8m2!3d28.5458568!4d77.187847!3m4!1s0x390d1d0986f3a585:0x141996188ca40268!8m2!3d28.5438882!4d77.1934082',
    'phone': '+918880141000',
    'website': '',
    'image':
        'https://lh5.googleusercontent.com/p/AF1QipOGma6167m_UGLNYurA8XnznnOyuHE9vkbOuicp=w408-h724-k-no'
  },
  'Mother Dairy Booth': {
    'about': 'Mother Dairy Booth & Safal Store',
    'loc':
        'https://www.google.com/maps/place/Mother+Dairy+Booth+%26+Safal+Store/@28.5433479,77.1989034,18.32z/data=!4m12!1m6!3m5!1s0x390d1df669c26951:0x94b46b5f3cfd7d17!2sSeminar+Hall!8m2!3d28.5450672!4d77.1926337!3m4!1s0x390ce208ca8f6a05:0x6825a535f0aca1ee!8m2!3d28.5429564!4d77.2001512',
    'phone': '+9118001801018',
    'website': 'http://www.motherdairy.com/',
    'image':
        'https://content3.jdmagicbox.com/comp/delhi/q3/011pxx11.xx11.121229120836.z8q3/catalogue/safal-mother-dairy-defence-colony-delhi-fruit-vendors-isfkybyfxn.jpg'
  },
};
