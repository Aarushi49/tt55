public with sharing class Demovfp
{
public string firstname{set; get;}
public string lastname{set; get;}
public string message{set; get;}

public void Showmessage()
{
message='Welcome' +  firstname  + lastname;
}
}