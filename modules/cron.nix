{ulib, ...}:
with ulib; (systemConfiguration {
  services.cron = enabled {
    systemCronJobs = [
      # Kill ghostty-wrappe every minute outside of 3-7 PM
      "*/1 0-2,7-23 * * * root pkill .ghostty-wrappe"

      # Kill kitty every minute outside of 3-7 PM
      "*/1 0-2,7-23 * * * root pkill kitty"

      # Kill browsers every minute outside of 3-5 PM
      "*/1 0-2,5-23 * * * root pkill brave"
      "*/1 0-2,5-23 * * * root pkill tor"
    ];
  };
})
