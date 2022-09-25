public class starcont
{
public decimal i;
public decimal j;
public string s1{set;get;}
public string s;

public starcont(){
s='';
s1='\n';
for(i=1; i<=8 ;i++)
{
  s='';
  for(j=1; j<=i; j++)
  {
    s+='*';
  }
   
   system.debug(s);
   s1+=s + '\n';
}

   system.debug(s1);

 

}
}