public with sharing class ChatBotGetAccountOrderDetails 
{

    public class TranscriptInput
    {
        @InvocableVariable(required=true)
        public ID routableID;
    }
      
    @InvocableMethod (label = 'GetOrderList')
    public static List<List<String>> GetOrderList(List<TranscriptInput> transcripts )
    {
        // Query for the transcript record based on the ID
        List<String> lstorders = new List<String>();
        LiveChatTranscript transcriptRecord = [SELECT Name, FirstName__c, LastName__c
                                                FROM LiveChatTranscript 
                                                WHERE Id = :transcripts[0].routableID 
                                                LIMIT 1];
        
        //VisitorNameOutput orderdetails = new VisitorNameOutput();
        String sfirstname = transcriptRecord.FirstName__c;
        String slastname = transcriptRecord.LastName__c;

        User userrecord = [Select Id from User where FirstName = :sfirstname and LastName = :slastname];
        List<Order> orders = new List<Order>([Select Id, OrderNumber from Order where CreatedById =:userrecord.Id order by CreatedDate desc limit 5]);
        if(!orders.isEmpty())
        {
            for (Order ord : orders)
            {
                lstorders.add(ord.OrderNumber);
                system.debug(lstorders);
            }
        }

        return new List<List<String>>{lstorders};
    }
}
