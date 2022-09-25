public class NewCaseListController {
public List<Case> getNewCases(){

list<Case> caselist =[select id , CaseNumber  from Case where Status ='New'];
return caselist;

}


}