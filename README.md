[![Actions Status](https://github.com/alfanthariq/mobile_device_identifier/workflows/Build%20and%20Test/badge.svg)](https://github.com/alfanthariq/mobile_device_identifier/actions)


# mobile_device_identifier

Flutter package to obtain unique ID from mobile device (android / ios) with uninstall resistant
<br /><br />
Android minSdkVersion = 21
<br />
iOS minimum version = 11

## Usage

```
final _mobileDeviceIdentifier = MobileDeviceIdentifier().getDeviceId();
```

You can combined with any encoding method to beautify string id. For example use Base64 encode with return value like 
```
RjFGMUJDNUItQkJERC00NjZCLUE2MzgtQzRDNUZGMDdCQzhF
```

## Method

###### Android
For android device, this package use UUID with MediaDrm to generate unique ID. With that, unique ID will not change even after uninstalling application

###### iOS
For iPhone device, this package use UUID with JNKeychain to generate unique ID to make ID still same even after reinstall application
