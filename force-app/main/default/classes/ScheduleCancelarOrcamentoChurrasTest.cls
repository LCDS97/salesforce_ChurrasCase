@isTest 

private class ScheduleCancelarOrcamentoChurrasTest{

    @isTest
    static void executeTest(){
        Test.startTest();
            ScheduleCancelarOrcamentoChurras schedule = new ScheduleCancelarOrcamentoChurras();

            String sch = '0 0 22 * * ? *';

            System.schedule('Test Schedule para Cancelar Orçamento', sch, schedule);
        Test.stopTest();
    }
}
