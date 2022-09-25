global class scheduledemo implements Schedulable
{
    global void execute(SchedulableContext SC)
    {
    batchclass cb=New batchclass();
    database.executeBatch(cb,200);
    
    }


}