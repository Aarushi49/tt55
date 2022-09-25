public with sharing class Calculator
{
public integer num1{get; set;}
public integer num2{get; set;}
public integer result{get; set;}

public void add()
{
result=num1+num2;

}

public void sub()
{
result=num1-num2;

}


public void mult()
{
result=num1*num2;

}


public void div()
{
if(num1>num2)
{
result=num1/num2;
}

else 
result=num2/num1;
}


}