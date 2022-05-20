/// Formatação do CPF
IF(
     AND(
               LEN((SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE({!$Record.CPF__c}, '.', ''), '.', ''), ' ', ''), '-', ''))) = 11,
               NOT(CONTAINS((SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE({!$Record.CPF__c}, '.', ''), '.', ''), ' ', ''), '-', '')),
             '('))),
            MID(((SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE({!$Record.CPF__c}, '.', ''), '.', ''), ' ', ''), '-', ''))),1,3)
            & "."
            &MID(((SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE({!$Record.CPF__c}, '.', ''), '.', ''), ' ', ''), '-', ''))),4,3)
            & "."
            &MID(((SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE({!$Record.CPF__c}, '.', ''), '.', ''), ' ', ''), '-', ''))),7,3)
            & "-"
            &MID(((SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE({!$Record.CPF__c}, '.', ''), '.', ''), ' ', ''), '-', ''))),10,4),
            (SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE({!$Record.CPF__c}, '.', ''), '.', ''), ' ', ''), '-', ''))
        )



/// Verificar mascára do CPF
NOT(OR( LEN({!$Record.CPF__c})=0,AND(MOD(MOD(11-
MOD( VALUE(MID({!$Record.CPF__c},1,1))*10+ VALUE(MID({!$Record.CPF__c},2,1))*9+ VALUE(MID({!$Record.CPF__c},3,1))*8+ VALUE(MID({!$Record.CPF__c},5,1))*7+ VALUE(MID({!$Record.CPF__c},6,1))*6+ VALUE(MID({!$Record.CPF__c},7,1))*5+ VALUE(MID({!$Record.CPF__c},9,1))*4+ VALUE(MID({!$Record.CPF__c},10,1))*3+ VALUE(MID({!$Record.CPF__c},11,1))*2,11),11),10)= VALUE(MID({!$Record.CPF__c},13,1)),MOD(MOD(11-
MOD( VALUE(MID({!$Record.CPF__c},1,1))*11+ VALUE(MID({!$Record.CPF__c},2,1))*10+ VALUE(MID({!$Record.CPF__c},3,1))*9+ VALUE(MID({!$Record.CPF__c},5,1))*8+ VALUE(MID({!$Record.CPF__c},6,1))*7+ VALUE(MID({!$Record.CPF__c},7,1))*6+ VALUE(MID({!$Record.CPF__c},9,1))*5+ VALUE(MID({!$Record.CPF__c},10,1))*4+ VALUE(MID({!$Record.CPF__c},11,1))*3+ VALUE(MID({!$Record.CPF__c},13,1))*2,11),11),10)= VALUE(MID({!$Record.CPF__c},14,1))))) && NOT(OR(LEN({!$Record.CPF__c})=0,AND(MOD(MOD(11-MOD( VALUE(MID({!$Record.CPF__c},1,1))*10+ VALUE(MID({!$Record.CPF__c},2,1))*9+ VALUE(MID({!$Record.CPF__c},3,1))*8+ VALUE(MID({!$Record.CPF__c},4,1))*7+ VALUE(MID({!$Record.CPF__c},5,1))*6+ VALUE(MID({!$Record.CPF__c},6,1))*5+ VALUE(MID({!$Record.CPF__c},7,1))*4+ VALUE(MID({!$Record.CPF__c},8,1))*3+ VALUE(MID({!$Record.CPF__c},9,1))*2,11),11),10)= VALUE(MID({!$Record.CPF__c},10,1)),MOD(MOD(11-
MOD( VALUE(MID({!$Record.CPF__c},1,1))*11+ VALUE(MID({!$Record.CPF__c},2,1))*10+ VALUE(MID({!$Record.CPF__c},3,1))*9+ VALUE(MID({!$Record.CPF__c},4,1))*8+ VALUE(MID({!$Record.CPF__c},5,1))*7+ VALUE(MID({!$Record.CPF__c},6,1))*6+ VALUE(MID({!$Record.CPF__c},7,1))*5+ VALUE(MID({!$Record.CPF__c},8,1))*4+ VALUE(MID({!$Record.CPF__c},9,1))*3+ VALUE(MID({!$Record.CPF__c},10,1))*2,11),11),10)= VALUE(MID({!$Record.CPF__c},11,1)))))