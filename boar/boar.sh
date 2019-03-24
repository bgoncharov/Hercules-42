# sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.atrun.plist
# sudo launchctl start /System/Library/LaunchDaemons/com.apple.atrun.plist

echo "echo 'Some words from the past' >> boar.txt | open boar.txt" | at 08:42 AM 12/21/2019
