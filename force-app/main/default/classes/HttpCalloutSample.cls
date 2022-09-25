public class HttpCalloutSample {
    
    public static String getCalloutResponseContents() {
        string userPassword = 'AlbinaH@thecreditpros.com:Credit@123';
        Blob userPasswordblob = Blob.valueOf(userPassword);
        string userPasswordvalue = EncodingUtil.base64Encode(userPasswordblob);
        system.debug('paramvalue--'+userPasswordvalue);
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://mautic-dev.thecreditpros.com/api/contacts/batch/new');
 		req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Basic '+userPasswordvalue );
        req.setHeader('Accept', 'application/json');
        req.setBody('[{"firstname":"testGGB","lastname":"testGGB","email":"testGGB@gmail.com"}]');
        req.setMethod('POST');
       
        HttpResponse res = h.send(req);
        system.debug('HttpResponse---'+res.getBody());
        return res.getBody();
    }
}