public class Leadquery
{

public static list <lead> leadlist{set; get;}
public Leadquery()
{
}

public static void showdata()
{
leadlist=[SELECT Name,Company FROM Lead WHERE Email = null LIMIT 10];
}

}