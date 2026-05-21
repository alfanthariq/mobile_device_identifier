## [0.0.1] - 16/01/2023.

* First launch

## [0.0.2] - 18/01/2023.

* Add encoded example

## [0.0.3] - 09/01/2025.

* Update dependency
* Update SDK constraint
* Fix namespace android

## [0.0.4] - 21/05/2026.

* Add Swift Package Manager support for iOS alongside existing CocoaPods support.
* Drop `JNKeychain` (CocoaPods-only) dependency; device ID is now stored via the native Keychain Services API. Legacy `JNKeychain`-encoded values are migrated to the new format on first read.
* Remove vestigial Objective-C plugin wrapper; Flutter registers the Swift plugin class directly via the Swift module.
* Raise iOS deployment target to 12.0.