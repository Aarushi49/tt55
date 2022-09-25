public class testcalloutClass {
    public static void passlist(){
        HttpRequest req= new HttpRequest();
        Http http = new Http();
        req.setHeader('Content-type', 'application/json');
        req.setMethod('POST');
        req.setEndpoint('http://devccst.hodusoft.com/HoduCC_api/v1.4/getCustomerGroup');
        String reqBody= '{"token":"RGk6Iu9wsddSRy3d"}';
        req.setBody(reqBody);
        HttpResponse resp  = http.send(req);
        system.debug('respnse --'+resp.getBody());
        JSON2APexConverter jss = JSON2APexConverter.parse(resp.getBody());
        system.debug('jsjs--'+jss.data[2].customer_group_id);
        
    }
    public class JSON2APexConverter{
        public integer code;
        public string status;
        public string status_message;
        public list<dataWrapper> data;
    }
    
    public class dataWrapper{
        public integer customer_group_id;
        public string customer_group_name;
    }
    
    public static JSON2APexConverter parse(String json){
        return (JSON2APexConverter)System.JSON.deserialize(json,JSON2APexConverter.class);
    }
}