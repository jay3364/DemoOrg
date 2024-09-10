trigger Task16 on Contact (after insert, after Update, after Delete) {
    triggerHandler16.maxDivide(Trigger.New);
    System.debug('This is finished trigger16');
}