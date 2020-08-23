.PHONY: sort_file
sort_file:
	Scripts/sort-Xcode-project-file.pl swift_dev_bot.xcodeproj/project.pbxproj

.PHONY: open_xcode
open_xcode:
	open swift_dev_bot.xcodeproj