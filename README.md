# upload_dsym plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-upload_dsym)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-upload_dsym`, add it to your project by running:

```bash
fastlane add_plugin upload_dsym
```

## About upload_dsym

upload dsym to your specify server

**Note to author:** Add a more detailed description about this plugin here. If your plugin contains multiple actions, make sure to mention them here.

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

```ruby
upload_dsym(
  host: 'http://xxx/api/upload',
  dsym_zip_file: '/Users/xiongzenghui/Desktop/haha.app.dSYM.zip'
)
```

```ruby
upload_dsym(
  use_bugly: true,
  buglytoolpath: '/Users/xiongzenghui/tools/buglySymboliOS.jar',
  buglyid: 'xxx',
  buglykey: 'xxx',
  dsym_files: [
    '/Users/xiongzenghui/Desktop/Share.appex.dSYM',
    '/Users/xiongzenghui/Desktop/todayWidget.appex.dSYM'
  ],
  version: '9.9.9-test',
  package: 'com.xxx.ios-dev'
)
```

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
