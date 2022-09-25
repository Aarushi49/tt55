public with sharing class Demovfp2
{


public String message1{ get; set; }
public string fn{get; set;}
public string ln{get; set;}
public string message{get; set;}


public void firstname()
{

message= 'Welcome' + fn;

}

public void fullname()
{

message1= 'Welcome' + fn  +  ln;

}
public void reset()
{

message='';
message1= '';

}


}