public class capacitycheckclass
{
    public static void capacityfunc(list<Series__c> Mylist)
    { 
        for(Series__c s:Mylist)
        {
            if((s.RAM__c<1 && s.Processor__c<2) && s.Hard_disk__c<50)
            {
              s.Capacity__c='Low Capacity';
            }
        }
    }

}