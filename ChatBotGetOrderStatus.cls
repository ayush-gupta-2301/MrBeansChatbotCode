public without sharing class ChatBotGetOrderStatus 
{
    public class Input{
        @InvocableVariable(required=true)
        public String ordernumber;
    }

    public class Output{
        @InvocableVariable(required=true)
        public String orderstatus;
    }

    @InvocableMethod(label = 'GetOrderStatus')
    public static  List<Output> GetOrderStatus(List<input> inputs)
    {
        List<Output> outputlst = new List<Output>();
       // List<Order> orders = new List<Order>();
        Output o = new Output();
        Order order = [Select Id, Status from Order where OrderNumber = :inputs[0].ordernumber Limit 1];
        o.orderstatus = order.Status;
        outputlst.add(o);
        return outputlst;
    }
}
