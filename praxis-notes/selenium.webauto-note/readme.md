[site]: https://selenium.dev/ "Selenium automates browsers. That's it! // Selenium 使浏览器自动化。就是这样！ // What you do with that power is entirely up to you. // 你用这个力量做什么完全取决于你。 // Primarily it is for automating web applications for testing purposes, but is certainly not limited to just that. // 它主要用于自动化 Web 应用程序以进行测试，但当然不仅限于此。 // Boring web-based administration tasks can (and should) also be automated as well. // 无聊的基于网络的管理任务也可以（而且应该）自动化。"
[docs]: https://selenium.dev/documentation ""
[src/gh]: https://github.com/SeleniumHQ/selenium.git "(Apache-2.0) (Languages: Java 34.7%, C# 15.3%, C++ 14.3%, JavaScript 11.1%, Ruby 6.9%, Python 6.2%, Other 11.5%) A browser automation framework and ecosystem."

[ide.site/site]: https://selenium.dev/selenium-ide/ "Selenium IDE · Open source record and playback test automation for the web // If you want to create quick bug reproduction scripts, create scripts to aid in automation-aided exploratory testing, then you want to use Selenium IDE; a Chrome, Firefox and Edge add-on that will do simple record-and-playback of interactions with the browser. // 如果您想创建快速错误重现脚本，创建脚本来辅助自动化辅助探索性测试，那么您需要使用 Selenium IDE；一个 Chrome、Firefox 和 Edge 插件，可以简单地记录和回放与浏览器的交互。"
[ide.src/gh]: https://github.com/SeleniumHQ/selenium-ide.git "(Apache-2.0) (Languages: TypeScript 75.2%, JavaScript 19.6%, HTML 3.3%, Elixir 1.1%, Starlark 0.4%, CSS 0.3%, Python 0.1%) Open Source record and playback test automation for the web."

[ide/firefox]: https://addons.mozilla.org/en-GB/firefox/addon/selenium-ide/ "(4.01 MB) Selenium IDE - Get this Extension for 🦊 Firefox"
[ide/chrome]: https://chrome.google.com/webstore/detail/selenium-ide/mooikfkahbdckldjjndioackbalphokd "(3.96MiB) Selenium IDE - Chrome Web Store"

[oci.src/gh]: https://github.com/SeleniumHQ/docker-selenium.git "(Apache-2.0) (Languages: Shell 35.5%, Dockerfile 22.7%, Makefile 20.1%, Python 14.4%, Smarty 7.3%) Docker images for Selenium Grid // https://hub.docker.com/u/selenium // :: docker run -d -p 4444:4444 -p 7900:7900 --shm-size=2g selenium/standalone-firefox:4.11.0-20230801 ;: curl http://localhost:4444 ;: http://localhost:7900/?autoconnect=1&resize=scale&password=secret // "

[standalone-firefox.oci/dockerhub]: https://hub.docker.com/r/selenium/standalone-firefox ":: docker pull selenium/standalone-firefox"
[node-firefox.oci/dockerhub]: https://hub.docker.com/r/selenium/node-firefox ":: docker pull selenium/node-firefox"
[standalone-edge.oci/dockerhub]: https://hub.docker.com/r/selenium/standalone-edge ":: docker pull selenium/standalone-edge"
[node-edge.oci/dockerhub]: https://hub.docker.com/r/selenium/node-edge ":: docker pull selenium/node-edge"
[standalone-chrome.oci/dockerhub]: https://hub.docker.com/r/selenium/standalone-chrome ":: docker pull selenium/standalone-chrome"
[node-chrome.oci/dockerhub]: https://hub.docker.com/r/selenium/node-chrome ":: docker pull selenium/node-chrome"

[grid/docs]: https://www.selenium.dev/documentation/grid/ "Want to run tests in parallel across multiple machines? Then, Grid is for you. // 想要在多台机器上并行运行测试吗？那么，Grid 适合您。 // Selenium Grid allows the execution of WebDriver scripts on remote machines by routing commands sent by the client to remote browser instances. // Selenium Grid 允许通过将客户端发送的命令路由到远程浏览器实例来在远程计算机上执行 WebDriver 脚本。 // Grid aims to: 网格的目标是： // Provide an easy way to run tests in parallel on multiple machines // 提供一种在多台机器上并行运行测试的简单方法 // Allow testing on different browser versions // 允许在不同的浏览器版本上进行测试 // Enable cross platform testing // 启用跨平台测试 // :: e.g. :: docker network create grid && docker run -d -p 4442-4444:4442-4444 --net grid --name selenium-hub selenium/hub && printf %s'\n' firefox chrome edge | xargs -i -P1 -- docker run -d --net grid -e SE_EVENT_BUS_HOST=selenium-hub --shm-size=2g -e SE_EVENT_BUS_PUBLISH_PORT=4442 -e SE_EVENT_BUS_SUBSCRIBE_PORT=4443 -- selenium/node-{}:4.11.0-20230801"
