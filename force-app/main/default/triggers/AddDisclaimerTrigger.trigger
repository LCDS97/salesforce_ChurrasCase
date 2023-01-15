trigger AddDisclaimerTrigger on FeedItem (after insert) {

    EditFeedItemHelper.edit(trigger.new);

}