part of event_calendar;

class QueueManager {
  static final LocalStorage ls = LocalStorage('iitdapp');

  static Future<List> storeList(List lis) async{
    await ls.setItem('calQueue', {'data':lis});
    return lis;
  }

  static Future getList() async{
    var jsLis = await ls.getItem('calQueue');
    return jsLis!=null?jsLis['data']:[];
  }

  // ignore: always_declare_return_types
  static addToList(var item) async {
    var lis = await getList();
    lis.add(item);
    await storeList(lis);
  }

  // ignore: always_declare_return_types
  static executeList(var lis) async {
    var prefs = await SharedPreferences.getInstance();
    await lis.forEach((data) async {
      var succ = false;
      if(data['func']=='postReminder'){
        var res = await postReminder(Event('99',eventId: data['eventId']), data['patch'],body: data['event'],addToQueue: false);
        if(res=='timeout')
          {
            connectedToInternet = false;
          }
        if(res=='') {
          succ = true;
        }
        if(res!= 'error' && res!='timeout' && res!=''){
          await prefs.setString(
              'ser ' + res, 'loc ' + data['eventId']);
        }
      }
      else if(data['func']=='deleteReminderFromServer'){
        var res = await deleteReminderFromServer(data['eventId'],addToQueue: false);
        if(res==-1){
          connectedToInternet =false;
        }
        if(res==1) {
          succ = true;
        }
      }
      if(connectedToInternet) {
        lis.remove(data);
        await storeList(lis);
      }
    });
    await storeList(lis);
  }


}