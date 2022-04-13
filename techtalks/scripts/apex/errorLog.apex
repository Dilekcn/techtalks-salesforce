try {
    Lead newRecord = new Lead();
    newRecord.FirstName = 'Dilek';
    newRecord.LastName = null;
    insert newRecord;
} catch (Exception exc) {
    System.debug('EXC:' + exc.getMessage());
    ErrorLogHelper.createErrorLog('DailyLeadWebService', 'fechLeads', exc.getMessage());

}