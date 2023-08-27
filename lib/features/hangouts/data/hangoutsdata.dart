class HangoutCardModel {
  String name;
  String comment;
  String note;
  double rating;
  String image;

  HangoutCardModel({
    required this.name,
    required this.comment,
    required this.image,
    required this.note,
    required this.rating,
  });

  factory HangoutCardModel.fromJson(Map<String, dynamic> json) {
    return HangoutCardModel(
      name: json['name'],
      comment: json['comment'],
      image: json['image'],
      note: json['note'],
      rating: json['rating'],
    );
  }
}

List<Map<String, dynamic>> hangoutsJSONdata = [
  {
    'name': 'Masala Mix',
    'comment': 'Serves Multi-Cuisine',
    'note': 'Open from 11:00 to 23:00',
    'rating': 3.8,
    'image': 'https://content.jdmagicbox.com/comp/delhi/z6/011pxx11.xx11.181113202746.h7z6/catalogue/masala-mix-hauz-khas-delhi-l801s9i1wn.jpg'
  },
  {
    'name': 'Cafe Coffee Day',
    'comment': 'Serves coffee, cakes and more',
    'note': 'Open from 11:00 to 23:00',
    'rating': 4.0,
    'image':
        'https://media-cdn.tripadvisor.com/media/photo-s/11/b2/71/6b/a-nice-overall-ambience.jpg'
  },
  {
    'name': 'Amul Cafe',
    'comment': 'Serves Amul Products',
    'note': 'Open from 8:00 to 3:00',
    'rating': 3.9,
    'image':
        'https://content.jdmagicbox.com/comp/delhi/z3/011pxx11.xx11.170113083022.y6z3/catalogue/amul-cafe-registrar-iit-new-delhi-delhi-coffee-shops-kemiks5i3f.jpg'
  },
  {
    'name': 'Shiru Cafe',
    'comment': 'Free Drinks',
    'note': 'Open from 8:00 to 3:00',
    'rating': 4.8,
    'image': 'https://lh5.googleusercontent.com/p/AF1QipPwjFBO9V5CCLUo8ue9QeL6uA_bROyOKRg_isAy=w408-h288-k-no'
  },
  {
    'name': 'HPMC Store',
    'comment': 'HPMC store in IITD',
    'note': '',
    'rating': 3.6,
    'image': 'https://lh5.googleusercontent.com/p/AF1QipMME0vkTNa9mOMG4ev7BFpjYU8b0MoExvrEyV53=w426-h240-k-no'
  },
  {
    'name': 'Nescafe',
    'comment': '',
    'note': '',
    'rating': 4.0,
    'image': 'https://blogs.ubc.ca/dominicinindia/files/2012/09/D-Nescafe.jpg'
  },
  {
    'name': 'Staff Canteen',
    'comment': 'Open For All',
    'note': '',
    'rating': 4.7,
    'image':
        'https://qph.fs.quoracdn.net/main-qimg-9716df72fc0640634a9e7cd2cdaa1c96'
  },
  {
    'name': 'Rajdhani Chatkare Foods',
    'comment': 'Serves Multi-Cuisine',
    'note': '',
    'rating': 3.0,
    'image':
        'https://content3.jdmagicbox.com/comp/delhi/j6/011pxx11.xx11.180505105548.e1j6/catalogue/rajdhani-chatkhare-food-hauz-khas-delhi-home-delivery-restaurants-xokptgx3q6.jpg'
  },
  {
    'name': 'Chaayos',
    'comment': '',
    'note': '',
    'rating': 4.0,
    'image': 'https://lh5.googleusercontent.com/p/AF1QipMYZgJ_inQG0r9zw6YRa30s7kGnC6kX39EWwAWU=w408-h272-k-no'
  },
  {
    'name': 'Roopsagar Bakery',
    'comment': 'IITD Bakery',
    'note': '',
    'rating': 4.6,
    'image': 'https://img4.nbstatic.in/tr:w-500/5b0277acd60180000c8384fc.jpg'
  },
  {
    'name': 'Quiet Kitchen',
    'comment': '',
    'note': '',
    'rating': 2.9,
    'image': 'https://img4.nbstatic.in/tr:w-500/5cbdb3e7d60180000d7ad0f2.png'
  },
  {
    'name': 'Chai Point',
    'comment': '',
    'note': '',
    'rating': 4.0,
    'image': 'https://lh5.googleusercontent.com/p/AF1QipOGma6167m_UGLNYurA8XnznnOyuHE9vkbOuicp=w408-h724-k-no'
  },
  {
    'name': 'Mother Dairy Booth',
    'comment': '',
    'note': '',
    'rating': 3.7,
    'image':
        'https://content3.jdmagicbox.com/comp/delhi/q3/011pxx11.xx11.121229120836.z8q3/catalogue/safal-mother-dairy-defence-colony-delhi-fruit-vendors-isfkybyfxn.jpg'
  },
];
