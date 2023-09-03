class ClubDetailModel {
  String? about;
  String? image;
  String? insta;
  String? linkedin;
  String? facebook;
  String? web;

  ClubDetailModel(
      {this.about,
      this.facebook,
      this.image,
      this.insta,
      this.linkedin,
      this.web});
}

ClubDetailModel? getClubDetailModelByKey(String key) {
  final clubData = clubsDetails[key];
  return ClubDetailModel(
    about: clubData['about'],
    image: clubData['image'],
    insta: clubData['insta'],
    linkedin: clubData['linkedin'],
    facebook: clubData['facebook'],
    web: clubData['web'],
  );
}

Map<String, dynamic> clubsDetails = {
  'AcesACM': {
    'about':
        'ACES ACM is the Computer Science department society of IIT Delhi.',
    'image': 'assets/images/aces.jpeg',
    'facebook': 'https://www.facebook.com/acesacm/about/?ref=page_internal',
    'insta': '',
    'linkedin': '',
    'web': 'http://www.cse.iitd.ac.in/aces-acm'
  },
  'Algorithms & Coding Club': {
    'about': 'The best place to stop by for coding lovers in IIT Delhi!',
    'image': 'assets/images/ancc.jpeg',
    'facebook': 'https://www.facebook.com/anciitd/',
    'insta': '',
    'linkedin': '',
    'web': ''
  },
  'Aeromodelling Club': {
    'about':
        'Aeromodelling Club, IIT-Delhi is a group of aeromodelling and aviation enthusiasts who have innate desire for flying.',
    'image': 'assets/images/aero.png',
    'facebook': 'https://www.facebook.com/aeroclubiitd',
    'insta': '',
    'linkedin':
        'https://www.linkedin.com/company/aeromodelling-club-iit-delhi/?lipi=urn%3Ali%3Apage%3Ad_flagship3_search_srp_companies%3BdNt4b9v3Tiex%2BEFhvzqBag%3D%3D&licu=urn%3Ali%3Acontrol%3Ad_flagship3_search_srp_companies-search_srp_result&lici=%2FOa4gEEgSYWRFly4naxjmg%3D%3D',
    'web': 'http://aeroclub.iitd.ac.in'
  },
  'Ankahi': {
    'about':
        'The dramatics society of IIT Delhi. By, For & Of the Dramatics Enthusiasts',
    'image': 'assets/images/ankahi.jpeg',
    'facebook': 'https://www.facebook.com/dramaiitd',
    'insta': 'https://www.instagram.com/ankahi_iitd/',
    'linkedin': '',
    'web': ''
  },
  'AXLR8R': {
    'about':
        'Axlr8r is the Formula SAE team of IITD. The team comprises of around 25 students who fabricate an open wheel E formula race car.',
    'image': 'assets/images/axlr8r.jpeg',
    'facebook': 'https://www.facebook.com/Axlr8rFormulaRacing/',
    'insta': 'https://www.instagram.com/axlr8r.formula.racing/',
    'linkedin': 'https://www.linkedin.com/company/axlr8r-formula-racing/',
    'web': 'http://automobileclub.iitd.ac.in'
  },
  'Board of Sports Activities': {
    'about': 'The organization for all things sport @ IIT Delhi. ',
    'image': 'assets/images/bsa.jpeg',
    'facebook': 'https://www.facebook.com/iitd.bsa/about/?ref=page_internal',
    'insta': 'https://www.instagram.com/bsa.iitd/',
    'linkedin':
        'https://www.linkedin.com/company/board-for-sports-activities-iit-delhi/',
    'web': 'https://bsa.iitd.ac.in'
  },
  'Board of Student Publications': {
    'about':
        'The journalistic and creative publishing faction of IITD, BSP exists to inform, eduacate and entertain.',
    'image': 'assets/images/bsp.jpeg',
    'facebook': 'https://www.facebook.com/bspiitd/?ref=page_internal',
    'insta': 'https://www.instagram.com/bsp.iitdelhi/',
    'linkedin':
        'https://www.linkedin.com/company/board-for-student-publications/',
    'web': 'https://bsp.iitd.ac.in'
  },
  'Debating Club': {
    'about': 'The debating club of IIT Delhi, for all the debate enthusiasts.',
    'image': 'assets/images/deb.jpeg',
    'facebook': 'https://www.facebook.com/debatingclubiitd',
    'insta': 'https://www.instagram.com/debsoc_iitd/',
    'linkedin':
        'https://www.linkedin.com/company/debating-club-iit-delhi/?lipi=urn%3Ali%3Apage%3Ad_flagship3_search_srp_companies%3BdNt4b9v3Tiex%2BEFhvzqBag%3D%3D&licu=urn%3Ali%3Acontrol%3Ad_flagship3_search_srp_companies-search_srp_result&lici=poV%2FxgDcTuyfKPL0a%2F1IGw%3D%3D',
    'web': 'http://www.debsociitd.com'
  },
  'Design Club': {
    'about': 'Everything is designed, some things are designed well',
    'image': 'assets/images/design.jpeg',
    'facebook': 'https://www.facebook.com/debatingclubiitd',
    'insta': 'https://www.instagram.com/designclubiitd/',
    'linkedin': 'https://www.linkedin.com/company/design-club-iitd/',
    'web': 'http://www.debsociitd.com'
  },
  'DevClub': {
    'about':
        'Dev Club is a community of tech-minded people in IIT Delhi. We work to build new applications to help the community.',
    'image': 'assets/images/devCLogo.png',
    'facebook': 'https://www.facebook.com/tech.iitd',
    'insta': 'https://www.instagram.com/devclub_iitd/',
    'linkedin': 'https://www.linkedin.com/company/devclub-iit-delhi',
    'web': 'https://devclub.in/'
  },
  'Economics Club': {
    'about':
        'Economics Club, IIT Delhi is dedicated towards inculcating economics and financial know-how among the student community.',
    'image': 'assets/images/eco.jpeg',
    'facebook': 'https://www.facebook.com/ecoclubiitd',
    'insta': 'https://www.instagram.com/economics_club_iitd/',
    'linkedin':
        'https://www.linkedin.com/company/economics-club-iit-delhi2017/?lipi=urn%3Ali%3Apage%3Ad_flagship3_search_srp_companies%3BdNt4b9v3Tiex%2BEFhvzqBag%3D%3D&licu=urn%3Ali%3Acontrol%3Ad_flagship3_search_srp_companies-search_srp_result&lici=iDnza9MPSgCWhhstRjvJjQ%3D%3D',
    'web': 'https://eco-club-iitd.blogspot.com'
  },
  'Electrical Engineering Society': {
    'about':
        'EES, IIT Delhi seeks to promote interaction amongst students and faculty by organizing interactive events.',
    'image': 'assets/images/EES.png',
    'facebook': 'https://www.facebook.com/eesiitd',
    'insta': 'https://www.instagram.com/ees.iit/',
    'linkedin': '',
    'web': 'http://ees.iitd.ac.in'
  },
  'Enactus IIT Delhi': {
    'about':
        'Enactus IIT Delhi aims to use power of entrepreneurial action to transform lives and shape a better and more sustainable world through various student led ventures.',
    'image': 'assets/images/enactus.jpeg',
    'facebook': 'https://www.facebook.com/FAC.iitd/events/?ref=page_internal',
    'insta': 'https://www.instagram.com/enactusiitdelhi/',
    'linkedin': 'https://www.linkedin.com/company/enactusiitdelhi/',
    'web': ''
  },
  'Azure : Fine Arts Society': {
    'about':
        'The community of art lovers, art enthusiasts and art learners of IIT Delhi.',
    'image': 'assets/images/facc.jpeg',
    'facebook': 'https://www.facebook.com/FAC.iitd/events/?ref=page_internal',
    'insta': 'https://www.instagram.com/azureiitd/',
    'linkedin':
        'https://www.linkedin.com/company/azure-fine-arts-society-of-iit-delhi/',
    'web': ''
  },
  'Finance Club': {
    'about':
        'Finance Club is a student body which aims at increasing the awareness of Finance as a career option through keynotes , workshops and competitions.',
    'image': 'assets/images/fin.png',
    'facebook':
        'https://www.facebook.com/financeatiitdelhi/events/?ref=page_internal',
    'insta': '',
    'linkedin': '',
    'web': ''
  },
  'Indoor Sports Club': {
    'about':
        'Finance Club is a student body which aims at increasing the awareness of Finance as a career option through keynotes , workshops and competitions.',
    'image': 'assets/images/isc.png',
    'facebook': 'https://www.facebook.com/isciitd/',
    'insta': '',
    'linkedin': '',
    'web': ''
  },
  'Indradhanu': {
    'about':
        'Indradhanu is IITD\'s LGBTQ collective. Our aim is creating a space for dialogue on gender & sexuality and rethinking and celebrating \'difference\'.',
    'image': 'assets/images/devCCover.png',
    'facebook': 'https://www.facebook.com/indradhanu.iit/',
    'insta': 'https://www.instagram.com/indradhanu_iitd/',
    'linkedin': '',
    'web': ''
  },
  'LitCLub': {
    'about':
        'The Literary Club aims at fostering a love for books and literature in students, and promoting literary activities.',
    'image': 'assets/images/lit.jpeg',
    'facebook': 'https://www.facebook.com/litclub.iitd/?ref=page_internal',
    'insta': 'https://www.instagram.com/litclub.iitd/',
    'linkedin': '',
    'web': 'http://brca.iitd.ac.in/literary.php?'
  },
  'Mathematics Society': {
    'about':
        'The Mathematics Society tries to foster the development of mathematics and its inquisitiveness among students through various events and workshops.',
    'image': 'assets/images/mathsoc.jpeg',
    'facebook': 'https://www.facebook.com/maths.society.iitd',
    'insta': 'https://www.instagram.com/mathsociitd/',
    'linkedin': '',
    'web': 'http://www.mathsoc-iitd.com'
  },
  'Photography & Films Club': {
    'about':
        'We are a group of passionate photographers, film makers and designers in IIT Delhi.',
    'image': 'assets/images/pfc.jpeg',
    'facebook': 'https://www.facebook.com/pfciitdelhi',
    'insta': 'https://www.instagram.com/pfciitd/',
    'linkedin': '',
    'web':
        'http://brca.iitd.ac.in/?fbclid=IwAR1L6cWWNaMC90OeCF0ZYBC8AaJUEfoKSKL0NQF60sj8hXupuAlydOgbFEc'
  },
  'Quizzing Club': {
    'about': 'The official quiz club of IIT Delhi.',
    'image': 'assets/images/qc.jpeg',
    'facebook': 'https://www.facebook.com/iitd.qc/',
    'insta': 'https://instagram.com/iitdqc',
    'linkedin': '',
    'web': 'http://brca.iitd.ac.in/quizzing.php'
  },
  'Robotics Club': {
    'about': 'The official Robotics Club of IIT Delhi',
    'image': 'assets/images/robo.jpeg',
    'facebook': 'https://www.facebook.com/iitdrobocon/',
    'insta': '',
    'linkedin':
        'https://www.linkedin.com/company/robotics-club-iit-delhi/?lipi=urn%3Ali%3Apage%3Ad_flagship3_search_srp_companies%3BU5HbkWyHRjSK7EouMGDiAQ%3D%3D&licu=urn%3Ali%3Acontrol%3Ad_flagship3_search_srp_companies-search_srp_result&lici=myvkoCFeR2CxosDTEaNIig%3D%3D',
    'web': 'http://roboticsclub.iitd.ac.in'
  },
  'ShARE': {
    'about':
        'ShARE is an international student think-tank which connects talented students to corporate and social leaders to discuss world economic issues.',
    'image': 'assets/images/shARE.jpeg',
    'facebook': 'https://www.facebook.com/shareiitdelhi',
    'insta': 'https://www.instagram.com/share_iitd/',
    'linkedin': 'https://www.linkedin.com/company/share-iit-delhi/',
    'web': ''
  },
  'Student Mentorship Program': {
    'about':
        'SMP ensures that every student at IIT Delhi gets mentored by understanding, willing and capable students.',
    'image': 'assets/images/devCCover.png',
    'facebook': 'https://www.facebook.com/smp.iitd/events/?ref=page_internal',
    'insta': '',
    'linkedin': '',
    'web': 'http://smp.iitd.ac.in/'
  },
  'Wellness Club': {
    'about':
        'Wellness Club IIT Delhi helds sessions like yoga, meditation, devotional singing, guest talks etc. for the overall wellness and health of IITD community.',
    'image': 'assets/images/wellness.png',
    'facebook': 'https://www.facebook.com/wellnessclubiitd/',
    'insta': '',
    'linkedin': '',
    'web': ''
  },
  'Dance Club': {
    'about':
        'The Most Glamorous and intuitive club of IIT-Delhi, The Dance Club, is an exemplary club with range of Activities from Inter-hostel to Inter-College events.',
    'image': 'assets/images/dance.jpeg',
    'facebook': 'https://www.facebook.com/DanceClub.IITDelhi',
    'insta': 'https://www.instagram.com/iitddanceclub/',
    'linkedin': '',
    'web':
        'https://l.facebook.com/l.php?u=http%3A%2F%2Fbrca.iitd.ac.in%2Fdance.php%3Ffbclid%3DIwAR2REtQuzpr9X4l5WLyQW7KKVEnk8vjTCYwqX5bnVh5JgjFc4vDQYLYweu0&h=AT2J07k9uaFqozvxDsXsL2OdU9ZncLVOjKWqqA0A-Y-y24GIYV5PQricuMOajoHk_OEfLBBPr5B6aPO-QvwTJer3jt35cUJ1e87zSLva1GdwXg8nUcC1v4u0B2t_8Bs8tdTBSfsLEUU'
  },
  'edC': {
    'about':
        'Entrepreneurship Development Council: eDC IIT Delhi is a platform to inspire, mentor and assist budding students to pursue entrepreneurship',
    'image': 'assets/images/edC.jpeg',
    'facebook': 'https://www.facebook.com/edciitdelhi',
    'insta': 'https://www.instagram.com/edc_iitd/',
    'linkedin': 'https://www.linkedin.com/company/edc-iit-delhi/',
    'web': 'http://www.edc-iitd.org'
  },
  'Hindi Samiti': {
    'about':
        'Hindi Samiti is a club of BRCA, IIT Delhi that works on promoting use of Hindi as a language in the IITD campus amongst the student and faculty community.',
    'image': 'assets/images/hs.jpeg',
    'facebook': 'https://www.facebook.com/hindisamiti.iitdelhi',
    'insta': 'https://www.instagram.com/hindisamiti_iitd/',
    'linkedin': '',
    'web':
        'https://l.facebook.com/l.php?u=http%3A%2F%2Fbrca.iitd.ac.in%2Fhindi.php%3Ffbclid%3DIwAR2ZlqqzgXetr2HXwfT2DeHmADFyv0bkKErSXJgm-nlD_ETJq9g33XqW4qg&h=AT2J07k9uaFqozvxDsXsL2OdU9ZncLVOjKWqqA0A-Y-y24GIYV5PQricuMOajoHk_OEfLBBPr5B6aPO-QvwTJer3jt35cUJ1e87zSLva1GdwXg8nUcC1v4u0B2t_8Bs8tdTBSfsLEUU'
  },
  'Music Club (Cadence)': {
    'about':
        'Music Club seeks to bring together everyone with a passion for any genre of music.The club is the perfect refuge for all those who can’t seem to fill their appetite for music.',
    'image': 'assets/images/music.jpeg',
    'facebook': 'https://www.facebook.com/hindisamiti.iitdelhi',
    'insta': 'https://www.instagram.com/iitdmusicclub/',
    'linkedin': '',
    'web':
        'https://l.facebook.com/l.php?u=http%3A%2F%2Fbrca.iitd.ac.in%2Fmusic.php%3Ffbclid%3DIwAR076idOwX97NZsv-6LZ49bNP8FOcpG9NQPk_xJP_XIqOUrtvwDW-U_K2AI&h=AT2J07k9uaFqozvxDsXsL2OdU9ZncLVOjKWqqA0A-Y-y24GIYV5PQricuMOajoHk_OEfLBBPr5B6aPO-QvwTJer3jt35cUJ1e87zSLva1GdwXg8nUcC1v4u0B2t_8Bs8tdTBSfsLEUU'
  },
  'SPIC MACAY': {
    'about':
        'Society for the Promotion of Indian Classical Music And Culture Amongst Youth',
    'image': 'assets/images/spic.jpeg',
    'facebook': 'https://www.facebook.com/SPIC.MACAY.IITD',
    'insta': 'https://www.instagram.com/spicmacay_iitd/',
    'linkedin':
        'https://www.linkedin.com/company/spicmacay/?lipi=urn%3Ali%3Apage%3Ad_flagship3_search_srp_companies%3Bzw6LrYLdQb%2BVBDqfB3ARsg%3D%3D&licu=urn%3Ali%3Acontrol%3Ad_flagship3_search_srp_companies-search_srp_result&lici=tuHZTy8NS7%2BpCsokonaQcA%3D%3D',
    'web':
        'https://spicmacay.org/?fbclid=IwAR37TCk6QeM2Oj4VC28nhveC9r1jVzYNqMdz5DcNjRp73cYNURBqsM2XXAk'
  },
  'IITD OnAir': {
    'about':
        'IITD OnAir is the media and coverage body of IIT Delhi, solely run by students. It a platform for people to produce their own shows, work in collaboration and create independent videos.',
    'image': 'assets/images/onair.jpeg',
    'facebook': 'https://www.facebook.com/IITDOnAir',
    'insta': 'https://www.instagram.com/iitdonair/',
    'linkedin':
        'https://www.linkedin.com/company/iitd-onair/?lipi=urn%3Ali%3Apage%3Ad_flagship3_search_srp_companies%3BeU7umjm6TeqtNq6evtg%2FfQ%3D%3D&licu=urn%3Ali%3Acontrol%3Ad_flagship3_search_srp_companies-search_srp_result&lici=%2F1nSSUEeTbCh%2F4uAOhMsSg%3D%3D',
    'web':
        'http://radio.iitd.ac.in/?fbclid=IwAR3SRpBbzEI3VUxt6fk8bn7wTFDM47GbcdM2A8JTJnRbGZnK7pz-rj41K7A'
  },
  'V-Defyn': {
    'about':
        'V-Defyn allows undergrads to channelize the skills, the rhythm and the technique of amateur dancers. V-Defyn Motions. V-Defyn Expressions. V-Defyn Spirit. V-Defyn Dance!',
    'image': 'assets/images/v-defyn.jpeg',
    'facebook': 'https://www.facebook.com/IITDOnAir',
    'insta': 'https://www.instagram.com/iitdonair/',
    'linkedin': '',
    'web':
        'http://radio.iitd.ac.in/?fbclid=IwAR3SRpBbzEI3VUxt6fk8bn7wTFDM47GbcdM2A8JTJnRbGZnK7pz-rj41K7A'
  },
  'NSS': {
    'about':
        'Empowering Change for a Better Nation!, Uplifting Communities and creating Positive Impact, Creating a ripple effect of positive change',
    'image': 'assets/images/nss.jpeg',
    'facebook': '',
    'insta': 'https://www.instagram.com/nssiitd/',
    'linkedin': '',
    'web': 'https://nss.iitd.ac.in/#!/'
  },
  'Physics and Astronomy Club': {
    'about': 'Bazinga! ',
    'image': 'assets/images/pac.jpeg',
    'facebook': 'https://www.facebook.com/PhysicsAndAstronomyIITD',
    'insta': '',
    'linkedin': '',
    'web': ''
  },
};
