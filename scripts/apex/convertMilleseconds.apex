OrcamentoChurras__c orcamentoChurra = [SELECT Id, Fim__c, Inicio__c FROM OrcamentoChurras__c WHERE id = 'a008a00000xvlXZAAY'];

Long horaInicio = orcamentoChurra.Inicio__c.getTime();
Long horaFim = orcamentoChurra.Fim__c.getTime();

system.debug('########### hora inicio' + horaInicio);
system.debug('########### hora fim' + horaFim);

Long horadoShow = Math.round((horaFim - horaInicio));

Long mins = horadoShow / 60000;
Long hours = mins / 60;
Long remainingMins = mins - ( hours * 60);
String totalTime = String.valueOf(hours) + ' hrs ' + String.valueOf(remainingMins) + ' mins';

system.debug('########### hora convertida ' + totalTime);

system.debug('########### hora show' + horadoShow);

// Descobrir porque vem como null com esse meu método
if(hours == 0 || mins == null){
            hourFormatada = '00';
        }
        if(mins == 0 || mins == null){
            minFormatada = '00';
        }

        if(hours >= 0 && hours < 10){
            hourFormatada = '0' + String.valueOf(hours);
        }
        if(mins >= 0 && mins < 10){
            minFormatada = '0' + String.valueOf(mins);
        }

        horaMinFormatada = hourFormatada + ':' + minFormatada;

        return horaMinFormatada;