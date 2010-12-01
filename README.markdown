# xcode-git-cfbundleversion.rb

Update CFBundleVersion in product Info.plist file with Git commit number

*NOTE* this script does not update the Info.plist that is inside your project. Doing so would create a commit / build loop in which the project Info.plist would contain a value behind the current commit. It simply sets the version in the .app created as the result of a build.

## How to use

1. Install the `plist` gem in your system gems
2. Right-click the target you want to add the versioning phase to (usually the target that builds your app)
3. Select: Add -> New Build Phase -> New Run Script Build Phase
4. Specify /usr/bin/ruby as the Shell for the script
5. Paste the script body into the Script text area
6. Ensure that the build phase is at the end of the target's list of build phases

## References

This script is based on following people's works:

- [http://github.com/jsallis/xcode-git-versioner](http://github.com/jsallis/xcode-git-versioner)
- [http://github.com/juretta/iphone-project-tools/tree/v1.0.3](http://github.com/juretta/iphone-project-tools/tree/v1.0.3)
