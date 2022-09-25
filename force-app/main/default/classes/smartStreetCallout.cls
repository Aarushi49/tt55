public class smartStreetCallout {
    public static void getData(String street,String zip){
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('GET');
        req.setEndpoint('https://us-street.api.smartystreets.com/street-address?auth-id=5b59cf2f-2943-a993-fa3a-7a466fee093e&auth-token=mEzOvM9surbQ6ZUSY3h6&street='+EncodingUtil.urlEncode(street,'UTF-8')+'&zip='+EncodingUtil.urlEncode(zip,'UTF-8'));
        HttpResponse response = http.send(req);
        system.debug('aarushi---'+response);
                        
        
    }
}