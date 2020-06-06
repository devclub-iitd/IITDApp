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

  static addToList(var item) async {
    var lis = await getList();
    lis.add(item);
    await storeList(lis);
  }

  static executeList(var lis) async {
    lis.forEach((data) async {
      var succ = false;
      if(data['func']=='postReminder'){
        var res = await postReminder(null, data['patch'],body: data['event']);
        if(res=='timeout')
          {
            connectedToInternet = false;
            return;
          }
        if(res=='') {
          succ = true;
        }

      }
      else if(data['func']=='deleteReminderFromServer'){
        var res = await deleteReminderFromServer(data['eventId']);
        if(res==-1){
          connectedToInternet =false;
          return;
        }
        if(res==1) {
          succ = true;
        }
      }
      if(succ) {
        lis.remove(data);
      }
    });
    await storeList(lis);
  }


}