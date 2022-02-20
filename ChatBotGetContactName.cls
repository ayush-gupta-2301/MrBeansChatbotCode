public with sharing class ChatBotGetContactName {
   
    public class TranscriptInput {
        @InvocableVariable(required=true)
        public ID routableID;
      }
      
      public class VisitorNameOutput {
        @InvocableVariable(required=true)
        public String sFirstName;
      }

    @InvocableMethod (label = 'GetContactFirstName')
    public static List<VisitorNameOutput> GetContactFirstName(List<TranscriptInput> transcripts )
    {
        List<VisitorNameOutput> names = new List<VisitorNameOutput>();
  
        for (TranscriptInput transcript : transcripts) {
        
          // Query for the transcript record based on the ID
          LiveChatTranscript transcriptRecord = [SELECT Name, FirstName__c
                                                 FROM LiveChatTranscript 
                                                 WHERE Id = :transcript.routableID 
                                                 LIMIT 1];
          
          // Store the first name in an output variable
          VisitorNameOutput nameData = new VisitorNameOutput();
          nameData.sFirstName = transcriptRecord.FirstName__c;
          
          // Add the name to the list of outputs
          names.add(nameData);
        }
        
        return names;
    }
}
