
## SSRS 数据库迁移

这个 SSRS 是个无状态服务，数据都在数据库里。你可以简单地配置数据库（必须是经由 SSRS 服务所创）和访问门户网址中的路径从而看到一个前端页面。

部分参考：

- SQL Server Reporting Services (SSRS)
  
  - [迁移 Reporting Services 安装（本机模式） - SSRS | Microsoft Docs](https://docs.microsoft.com/zh-cn/sql/reporting-services/install-windows/migrate-a-reporting-services-installation-native-mode?view=sql-server-ver16)
  - [将报表服务器数据库移至其他计算机（本机模式） - SSRS | Microsoft Docs](https://docs.microsoft.com/zh-cn/sql/reporting-services/report-server/moving-the-report-server-databases-to-another-computer-ssrs-native-mode?view=sql-server-ver16)
  - [Reporting Services 的备份和还原操作 - SSRS | Microsoft Docs](https://docs.microsoft.com/zh-cn/sql/reporting-services/install-windows/backup-and-restore-operations-for-reporting-services?view=sql-server-ver16)
  
- SQL Server
  
  - [快速入门：备份和还原数据库 - SQL Server | Microsoft Docs](https://docs.microsoft.com/zh-cn/sql/relational-databases/backup-restore/quickstart-backup-restore-database?view=sql-server-ver16)
  - [SQL Server 数据库的备份和还原 - SQL Server | Microsoft Docs](https://docs.microsoft.com/zh-cn/sql/relational-databases/backup-restore/back-up-and-restore-of-sql-server-databases?view=sql-server-ver16)
  - [完整文件备份 (SQL Server) - SQL Server | Microsoft Docs](https://docs.microsoft.com/zh-cn/sql/relational-databases/backup-restore/full-file-backups-sql-server?view=sql-server-ver16)
  - [创建完整数据库备份 - SQL Server | Microsoft Docs](https://docs.microsoft.com/zh-cn/sql/relational-databases/backup-restore/create-a-full-database-backup-sql-server?view=sql-server-ver16)
  - [使用 SSMS 还原数据库备份 - SQL Server | Microsoft Docs](https://docs.microsoft.com/zh-cn/sql/relational-databases/backup-restore/restore-a-database-backup-using-ssms?view=sql-server-ver16)
  

### 数据库

前提：

- 你要有一个现成的数据库，你将要备份它。
- 你要拿到这个数据库的密钥文件（一般是个 `.snk` 文件），以及打开这个文件所需的密码。
- 你要有一个可以还原这个数据库的地方，并且，你不介意重名数据库被覆盖、或不介意把之前的数据库还原为新的名称。

步骤：参考文档或者根据图形界面提示操作。

要点：

- 根据[将报表服务器数据库移至其他计算机（本机模式）](https://docs.microsoft.com/zh-cn/sql/reporting-services/report-server/moving-the-report-server-databases-to-another-computer-ssrs-native-mode?view=sql-server-ver16#using-backup-and-copy_only-to-backup-the-report-server-databases)中的描述，备份数据库时，要勾选 `仅复制备份` （即 `COPY_ONLY` ）。
  
- 根据[Reporting Services 的备份和还原操作](https://docs.microsoft.com/zh-cn/sql/reporting-services/install-windows/backup-and-restore-operations-for-reporting-services?view=sql-server-ver16#backing-up-the-report-server-databases)中的描述，要把 `ReportServer` 数据库以 ***恢复**模式* 为 `完整` 的配置备份、把相应的 `ReportServerTempDB` 数据库以 ***恢复**模式* 为 `简单` 的配置备份。
  
  这里的要求在使用 SSMS 客户端操作时非常容易满足，因为 ***恢复**模式* 部分你没法选，而这两个库默认就是这两个合乎文档建议的配置。
  
  另外，这两个数据库名是默认的，**不论你在安装时是否有用 SSRS 指定它们，它们都是会在安装后被创建的**。

- 恢复时，需要在 `选项` 里勾选 `覆盖现有数据库 (WITH REPLACE)` ，否则会报错说 `System.Data.SqlClient.SqlError: 备份集中的数据库备份与现有的 'ReportServer' 数据库不同。 (Microsoft.SqlServer.SmoExtended)` 。恢复后需要还原密钥。
  
### SSRS

安装好后会有一个 ReportServer 配置工具，用它能连接上一个 SSRS 服务并对该服务配置。

要注意的：

- 那个 *Web 门户 URL* 一开始是不能配置的，全灰的而且空着。
  
  你需要在 *Web 服务 URL* 里的 *站点标识* 里给指定一个 IP 地址，然后才能配置 *门户* 里的东西、从而才能访问 SSRS 那个用来给人看的页面。



