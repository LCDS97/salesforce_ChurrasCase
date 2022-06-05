Datetime DateNow = Datetime.now();
System.debug(DateNow);

String strConvertedDate = 
  DateNow.format('MM/dd/yyyy HH:mm:ss', 
                 'America/Sao_Paulo');

System.debug(strConvertedDate);


Pattern dt = Pattern.compile('(?i)(\\d{2})/(\\d{2})/(\\d{4}) (\\d{2}):(\\d{2}):(\\d{2})');
Matcher m = dt.matcher(strConvertedDate);
Datetime result;
if(m.find()) {
    result = DateTime.newInstanceGMT(
        Integer.valueOf(m.group(3)), // yuck
        Integer.valueOf(m.group(2)),
        Integer.valueOf(m.group(1)),
        Integer.valueOf(m.group(4)),
        Integer.valueOf(m.group(5)),
        Integer.valueOf(m.group(6))        
        );
}

System.debug(result);