[website]: https://localsend.org
[github]: https://github.com/localsend/localsend.git
[f-droid]: https://f-droid.org/packages/org.localsend.localsend_app
[appimage]: https://github.com/localsend/localsend/releases/download/v1.6.2/LocalSend-1.6.2.AppImage
[apple-store]: https://apps.apple.com/us/app/localsend/id1661733229
[ms-store]: ms-windows-store://pdp/?productid=9NCB4Z0TZ6RR

[website], [github], [f-droid], [appimage], [apple-store], [ms-store]

> Share files to nearby devices.  
> Free, open source, cross-platform.  

> An open source cross-platform alternative to AirDrop
> 

dev ([ref][github]) : 

~~~ sh
: After you have installed Flutter, then you can start this app by typing the following commands :
flutter pub get
flutter pub run build_runner build
flutter run

: :::: :

: Build : Android : Traditional APK :
flutter build apk

: Build : Android : AppBundle for Google Play :
flutter build appbundle

: :::: :

: Build : Linux : Traditional :
flutter build linux

: Build : Linux : AppImage :
appimage-builder --recipe AppImageBuilder.yml

: :::: :

: Build : Apple : iOS :
flutter build ipa

: Build : Apple : MacOS :
flutter build macos

: :::: :

: Build : Windows : Traditional :
flutter build windows

: Build : Windows : Local MSIX App :
flutter pub run msix:create

: Build : Windows : Store ready :
flutter pub run msix:create --store

~~~


