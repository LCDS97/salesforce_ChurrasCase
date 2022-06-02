BusinessHours bh = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
Case casoExemplo = [SELECT Id, EntradaProduto__c, SaidaProduto__c FROM Case WHERE EntradaProduto__c != null AND SaidaProduto__c != null LIMIT 1];

Datetime entrada = casoExemplo.EntradaProduto__c;
Datetime saida = casoExemplo.SaidaProduto__c;

Long resultado = BusinessHours.diff(bh.id,entrada,saida);
System.debug(resultado);

Long mins = resultado / 60000;
Long hours = mins / 60;
Long remainingMins = mins - ( hours * 60);
String totalTime = String.valueOf(hours) + ' hrs ' + String.valueOf(remainingMins) + ' mins';
System.debug(totalTime);