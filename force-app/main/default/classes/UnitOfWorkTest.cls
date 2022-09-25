@IsTest
private class UnitOfWorkTest {

    private static List<Schema.SObjectType> MY_SOBJECTS =
            new Schema.SObjectType[]{
                    Account.SObjectType,
                    Contact.SObjectType,
                    Note.SObjectType
            };

    @IsTest static void challengeComplete() {
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(MY_SOBJECTS);

        for (Integer i = 0; i < 100; i++) {
            Account a = new Account(Name = 'Test' + i);
            uow.registerNew(a);

            for (Integer j = 0; j < 5; j++) {
                Contact c = new Contact(LastName = 'Test' + String.fromCharArray(new List<Integer>{
                        65 + i
                }));
                uow.registerNew(c, Contact.AccountId, a);

                Note n = new Note();
                n.Body = 'Test' + String.fromCharArray(new List<Integer>{
                        65 + i
                });
                n.Title = 'Test' + String.fromCharArray(new List<Integer>{
                        65 + i
                });
                uow.registerRelationship(n, Note.ParentId, a);
                uow.registerNew(n, Note.ParentId, a);
            }
        }

        Test.startTest();
        uow.commitWork();
        Test.stopTest();

        System.assertEquals(100, [SELECT Id FROM Account].size());
        System.assertEquals(500, [SELECT Id FROM Contact].size());
        System.assertEquals(500, [SELECT Id FROM Note].size());
    }
}