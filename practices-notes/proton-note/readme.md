

[vpn-andr-repo]: https://github.com/ProtonVPN/android-app.git
[vpn-andr-site]: https://protonvpn.com/download/ProtonVPN.apk
[vpn-f-droid]: https://f-droid.org/packages/ch.protonvpn.android

[vpn-ios-repo]: https://github.com/ProtonVPN/ios-mac-app.git
[vpn-ios-apple]: https://apps.apple.com/app/apple-store/id1437005085

[vpn-win-repo]: https://github.com/ProtonVPN/win-app.git
[vpn-linuxapp-repo]: https://github.com/ProtonVPN/linux-app.git
[vpn-linuxcli-repo]: https://github.com/ProtonVPN/linux-cli.git

[site-account]: https://account.proton.me
[site-account-up]: https://account.proton.me/signup
[site-account-in]: https://account.proton.me/login

[site]: https://proton.me

[site-mail]: https://proton.me/mail
[site-calendar]: https://proton.me/calendar
[site-drive]: https://proton.me/drive
[site-vpn]: https://protonvpn.com

[site-community]: https://proton.me/community/open-source

[repo]: https://github.com/ProtonMail/WebClients.git

[mail-andr-repo]: https://github.com/ProtonMail/proton-mail-android.git
[mail-ios-repo]: https://github.com/ProtonMail/ios-mail.git

[use-mail]: https://mail.proton.me
[use-calendar]: https://calendar.proton.me
[use-drive]: https://drive.proton.me
[use-vpn]: https://account.protonvpn.com

links: 

- [Proton — Privacy by default][site]
- [An Open Source Privacy Company | Proton][site-community]


[ProtonMail/WebClients | GitHub][repo] : 

> This project is a monorepo
>  hosting the proton web clients.
>  It includes the web applications,
>  their dependencies & shared modules
>  as well as all tooling surrounding
>  development of the web clients
>  (as well as some additional
>  miscellaneous things).
> 
> 这个项目是一个托管 proton web 客户端的 monorepo 。
> 它包括 Web 应用程序、它们的依赖项和共享模块、
> 以及围绕 Web 客户端开发的所有工具
>  (以及一些其他杂项) 。 
> 
> -   <img src="./.favicons/mail.svg" style="vertical-align: middle" height="20" width="20" /> <span style="vertical-align: middle; display: inline-block">[Proton Mail][use-mail]</span>
> -   <img src="./.favicons/calendar.svg" style="vertical-align: middle" height="20" width="20" /> <span style="vertical-align: middle; display: inline-block">[Proton Calendar][use-calendar]</span>
> -   <img src="./.favicons/drive.svg" style="vertical-align: middle" height="20" width="20" /> <span style="vertical-align: middle; display: inline-block">[Proton Drive][use-drive]</span>
> -   <img src="./.favicons/proton.svg" style="vertical-align: middle" height="20" width="20" /> <span style="vertical-align: middle; display: inline-block">[Proton Account][site-account]</span>
> -   <img src="./.favicons/vpn.svg" style="vertical-align: middle" height="20" width="20" /> <span style="vertical-align: middle; display: inline-block">[Proton VPN][use-vpn]</span>
> 
> Technically, this monorepo is
>  based on Yarn 2 & Yarn Workspaces,
>  with unified versioning
>  for all packages inside.
> 
> 从技术上讲，这个 monorepo 基于
>  Yarn 2 和 Yarn Workspaces ，
> 对内部的所有包进行统一版本控制。 
> 

- [Proton Drive][site-drive] 是个不错的
  加密的网络硬盘服务。
  
  和 MegaSYNC 很类似，也是端到端加密，
  也客户端也开源。
  
  但不是去中心化的，意味着完成对中心的攻击即可
  使服务对用户失效。
  
- [Proton Mail][site-mail] 是个不错的邮件服务，
  也是端到端加密。
  
  也不是去中心化的。并且，受到身为 15 眼联盟成员
  之一的所在国德国政府的命令，对于邮件标题不予加密。
  
- 免费订阅账户就可以使用私有虚拟网络，这里是比较划算的。
  其虚拟私有网络技术可能是基于 [WireGuard](../wireguard-note) 的，
  所以性能应该挺容易做好。
  不过在 [Windows client repo][vpn-win-repo] 里
  说了：
  
  > Service is responsible for interaction
  >  with OpenVPN, managing Windows firewall
  >  and Split Tunnel driver.
  > 
  
  这大概只是对客户端构成的描述吧，
  因为其他平台的客户端描述中都没有 `open` 的字样。
  
- 服务端我没找到代码和相应的自托管部署的说明，我不知道有没有。

