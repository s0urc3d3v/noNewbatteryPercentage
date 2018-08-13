@interface SBUILegibilityLabel : UIView
@property (nonatomic, copy) NSString *string;
@end

@interface NCNotificationListSectionRevealHintView : UIView
@property (nonatomic, retain) SBUILegibilityLabel * revealHintTitle;
-(void) _updateHintTitle;
-(float) getBatteryPercentage;
@end

%hook NCNotificationListSectionRevealHintView

- (void) _updateHintTitle {
  %orig;
  
  //Get current battery percentage
  float batteryLevelAsFloat = [self getBatteryPercentage];
  int batteryLevelAsInt = ((int)(batteryLevelAsFloat)); //Convert battery level to an int
  
  NSString *batteryLevelAsNSString =[NSString stringWithFormat:@"%s %d%s", "Your battery is at", abs(batteryLevelAsInt), "\%"];

  self.revealHintTitle.string = batteryLevelAsNSString;
}

%new - (float)getBatteryPercentage {
  [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
  float batteryRemaining = [[UIDevice currentDevice] batteryLevel];
  return batteryRemaining * 100;
}

%end
