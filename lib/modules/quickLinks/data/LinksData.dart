var linksData = {
  'Academics': [
    LinksModel(name: 'Moodle', url: 'https://moodle.iitd.ac.in/'),
    LinksModel(name: 'Gradescope', url: 'https://www.gradescope.com'),
    LinksModel(name: 'Piazza', url: 'https://piazza.com/'),
    LinksModel(name: 'Central Library', url: 'http://library.iitd.ac.in/'),
    LinksModel(
        name: 'Academic ERP',
        url: 'https://eacademics.iitd.ac.in/sportal/login'),
    LinksModel(
        name: 'Ciriculum Info', url: 'https://home.iitd.ac.in/curriculum.php'),
    LinksModel(
        name: 'Owncloud',
        url: 'https://owncloud.iitd.ac.in/nextcloud/index.php'),
  ],
  'Time Table': [
    LinksModel(
        name: 'Academic Calendar',
        url: 'https://home.iitd.ac.in/academic-calendar.php'),
    LinksModel(name: 'Exam Schedule', url: 'http://timetable.iitd.ac.in/'),
    LinksModel(name: 'Time Table', url: 'http://timetable.iitd.ac.in/'),
    LinksModel(
        name: 'List of Holidays',
        url: 'https://home.iitd.ac.in/uploads/holidays-year-2021.pdf')
  ],
  'Miscellaneous': [
    LinksModel(name: 'Webmail', url: 'https://webmail.iitd.ac.in/roundcube/'),
    LinksModel(name: 'IITD Website', url: 'https://home.iitd.ac.in/'),
    LinksModel(name: 'Career Services', url: 'https://ocs.iitd.ac.in/'),
    LinksModel(name: 'CSC', url: 'https://csc.iitd.ac.in/'),
    LinksModel(
        name: 'Smart Notice Board',
        url: 'http://notices.smartcampus.iitd.ac.in/'),
    LinksModel(name: 'NGU', url: 'https://ngu.iitd.ac.in/'),
    LinksModel(
        name: 'Internal Complaints Committee',
        url: 'http://old.iitd.ac.in/content/anti-sexual-harassment-policy'),
  ],
  'Boards and Councils': [
    LinksModel(name: 'SAC', url: 'http://sac.iitd.ac.in/'),
    LinksModel(name: 'BSA', url: 'http://bsa-iitd.in/home/'),
    LinksModel(name: 'BRCA', url: 'http://brca.iitd.ac.in/'),
    LinksModel(name: 'BSP', url: 'https://www.bspiitd.com/'),
    LinksModel(name: 'BHM', url: 'https://home.iitd.ac.in/bhm.php'),
    LinksModel(name: 'BSW', url: 'http://bsw.iitd.ac.in/'),
  ],
  'Health & Wellness': [
    LinksModel(name: 'Hospital', url: 'http://hospital.iitd.ac.in/'),
    LinksModel(name: 'Your Dost', url: 'https://yourdost.com/'),
  ]
};

class LinksModel {
  LinksModel({this.name, this.url});
  String name;
  String url;
}
