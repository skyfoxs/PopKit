# Note for making framework with private pod

1. Create a new framework project `PopKit`
2. Add new iOS app target for showing example if needed `PopKitExample`
3. Add code to the framework
4. Create Podspec by running `pod spec create PopKit` (I used `PopKit` here for my pod name)
5. Edit podspec file.
6. Create `Specs/PopKit` directory for pod repo. (I use this repo for private pod repo. When we push Podspec to the repo, Pod will keep all Podspec versions in this directory. Skip this step if you have another repo for a private pod). To make the git track an empty folder, we can add `.gitkeep` into the directory.
7. Run this command to set repo for our private pod `pod repo add PopKit git@github.com:skyfoxs/PopKit.git`
8. Add all, commit, and tag version. Then push to the git repo.
9. Publish pod with `pod repo push PopKit PopKit.podspec --allow-warnings --verbose`

# Usage of this private pod framework

See [TestPod](https://github.com/skyfoxs/TestPod) repo for more detail.

# Command line tool

`PopKitGen` will be a command line tool for generating swift source code in the `PopKit` framework (like `SwiftGen`).

We have to create the `PopKitGenHelper` framework and import it into `PopKitGen` because we cannot add the unit tests for the `PopKitGen` target, but `PopKitGenHelper` can.