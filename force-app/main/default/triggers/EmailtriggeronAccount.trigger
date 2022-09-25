trigger EmailtriggeronAccount on Account (before insert) {
    for(Account con:Trigger.new){   
        if(con.Site == null && con.name != null){
            con.Site= con.name + 'test.com';
        }
       
    }
}