# Note for making framework with private pod

1. Create a new framework project `PopKit`
2. Add new iOS app target for showing example if needed `PopKitExample`
3. Add code to the framework
4. Create Podspec by running `pod spec create PopKit` (I used `PopKit` here for my pod name)
5. Edit podspec file.
6. Create `Specs/PopKit` directory for pod repo. (I use this repo for private pod repo. When we push podspec to repo, pod will keep all podspec version in this directory. Skip this step if have another repo for private pod). To make git track empty folder we can add `.gitkeep` into the directory.
7. Run this command to set repo for our private pod `pod repo add PopKit git@github.com:skyfoxs/PopKit.git`
8. Add all, commit, and tag version. Then push to the git repo.
9. Publish pod with `pod repo push PopKit PopKit.podspec --allow-warnings --verbose`

# For usage of this private pod framework

See [TestPod](https://github.com/skyfoxs/TestPod) repo for more detail.