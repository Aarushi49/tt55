public class StringManipulation {
    public static void addHashMethod(String inputString){
        Integer count=0;
        list<String> listInput = new list<String>();
        listInput = inputString.split(' ');
        String pattern ='(?i)(test)';
        system.debug('list is --'+listInput);
        String finalString='';
        for(String str : listInput){
            if(str.containsIgnoreCase('test')){
                list<String> updated = str.split(pattern);
                string finalString2='';
                for(String str2 : updated){
                    String str22 = str2;
                    if(str2.containsIgnoreCase('test')){
                        str22='#'+str2+'#';
                    }
                    finalString2= finalString2+ str22;
                }
                system.debug('hh---'+finalString2);
                count++; 
                finalString =finalString+' '+ finalString2+' '; 
                
            }else{
                finalString =finalString +' '+str+' '; 
            }
        }
        system.debug('count--'+finalString);
    }
    
}