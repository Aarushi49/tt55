public class pen{
    public String Color;
    public Integer Price;
    
    public pen(){
        Color = 'Pink';
        Price = 3;
    }
    
    public integer CalculatePrice1(Integer NumberofPens){
        Integer TotalPrice;
        TotalPrice= Price*NumberofPens;
        return TotalPrice;
        
    }
    
    public void CalculatePrice2(Integer NumberofPens){
        Integer TotalPrice;
        TotalPrice= Price*NumberofPens;
        System.debug(' The total Price is '+TotalPrice);
    }
}