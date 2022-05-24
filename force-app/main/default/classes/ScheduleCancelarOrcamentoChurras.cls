public class ScheduleCancelarOrcamentoChurras implements Schedulable{
    public void execute(SchedulableContext ctx){
        BatchCancelarOrcamentoChurras batch = new BatchCancelarOrcamentoChurras();
        String jobId = Database.executeBatch(batch);
    }
}


