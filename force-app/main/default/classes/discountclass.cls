public class discountclass
{
    public static void discountfunc(list<Mobile__c> Mylist)
    {
        for(Mobile__c m:Mylist)
        {
            if(m.Brand__c=='Samsung')
            {
                m.Price__c=m.Price__c*0.90;
                m.Discount_Status__c='Congrats!!YOU GOT 10% DISCOUNT';
            }
            else if(m.Brand__c=='Apple')
            {
                m.Price__c=m.Price__c*0.80;
                m.Discount_Status__c='Congrats!!YOU GOT 20% DISCOUNT';
            }
            
        }
    }
    
    public static void discountfunc2(list<Mobile__c> Mylist)
    {
        for(Mobile__c m:Mylist)
        {
            if(m.Brand__c=='Samsung')
            {
                m.Price__c=m.Price__c*0.95;
                m.Discount_Status__c='Congrats!!YOU GOT 5% DISCOUNT';
            }
             else if(m.Brand__c=='Apple')
            {
               
                m.Discount_Status__c='';
            }
            
            
        }
    }
}