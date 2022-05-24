@isTest

public class TestDataFactory{

    public static void gerarConta(){
        List<Account> conta = new List<Account>();
        
        
        conta.add(new Account(
            Name='Nome Teste'
            ));

        insert conta;
    }


    public static List<OrcamentoChurras__c> criarOrcamentoComItens(Integer numcontatoPerOrcamento, Integer numOrcamentos){
      
      List<Contact> contatos = new List<Contact>();
      for(Integer i=0;i<numcontatoPerOrcamento;i++) {
          Contact c = new Contact(
                                FirstName='Test',
                                LastName='Contact' + i,
                                CPF__c='498.282.820-20');
          contatos.add(c);
      }
      insert contatos;


      List<OrcamentoChurras__c> orcamentos = new List<OrcamentoChurras__c>();
  
      for(Integer c = 0; c < numOrcamentos; c++){
        Contact contato = contatos[c];

        for(Integer k = 0; k < numcontatoPerOrcamento; k++){
          orcamentos.add(new OrcamentoChurras__c(
            Name='Orcamento numero ' + k,
            Contato__c=contato.Id,
            Fim__c= Date.Today() - 2,
            Status__c = 'Novo'));
        }
      }

      insert orcamentos;
      return orcamentos;
      
    }
 

    public static User gerarUsuario(Boolean opcaoDml, String strPerfil) {
        Profile objPerfil =[SELECT Id, Name FROM Profile WHERE Name =: strPerfil LIMIT 1 ];
        Long currentTimeMillis = System.currentTimeMillis();
        String emailUsuario = 'email+' + currentTimeMillis + '@bestminds.com';
        User usuarioComPapel = new User(
          FirstName = 'Nome',
          LastName = 'Sobrenome',
          Email = emailUsuario,
          Username = emailUsuario + '.' + currentTimeMillis,
          CompanyName = 'Everymind',
          Title = 'Desenvolvedor',
          Alias = 'nomsob',
          TimeZoneSidKey = 'America/Sao_Paulo',
          EmailEncodingKey = 'UTF-8',
          LanguageLocaleKey = 'pt_BR',
          LocaleSidKey = 'pt_BR',
          ProfileId = objPerfil.Id
        );
        if (opcaoDml)
          insert usuarioComPapel;
        return usuarioComPapel;
      }
      public static void atribuirPermissionSetToUser(User user, String permissionSetName) {
          PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = :permissionSetName];
          PermissionSetAssignment psa = new PermissionSetAssignment();
          psa.AssigneeId = user.Id;
          psa.PermissionSetId = ps.Id;
          insert psa;
      }
}


