public class calloutforaccount {
    public static void getAnimalNameById(Integer accountId){
        Http http=new Http();
        HttpRequest req=new HttpRequest();
        req.setEndPoint('https://boon-developer-edition.ap8.force.com//services/apexrest/Accounts/0010o000028AxTL/contacts');
        req.setMethod('GET');
        HttpResponse res=http.send(req);
       system.debug(res.getBody());

}
}