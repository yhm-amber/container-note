ref:

- [Liqo.io](https://liqo.io/)
- [docs.liqo.io](https://docs.liqo.io/en/latest/)）

## 简介

在[安装需求](https://docs.liqo.io/en/latest/installation/requirements.html)中有提到：

> Liqo supports two alternative peering approaches, each characterized by **different requirements in terms of network connectivity** (i.e., mutually reachable endpoints):
> 
> - [**Out-of-band control plane peering**](https://docs.liqo.io/en/latest/features/peering.html#featurespeeringoutofbandcontrolplane): it requires **three separated traffic flows** (hence, three exposed endpoints).
> - [**in-band control plane peering**](https://docs.liqo.io/en/latest/features/peering.html#featurespeeringinbandcontrolplane): it requires a **single endpoint**, as all control plane traffic is tunneled inside the cross-cluster VPN.
> 
> More details available in the [peering section](https://docs.liqo.io/en/latest/features/peering.html).
> 
> *Note: The two peering approaches are **non-mutually exclusive**: a cluster can leverage different approaches toward different remote clusters, provided that the connectivity requirements are satisfied.*
> 


> Liqo支持两种替代的对等互连方法，每种方法**在网络连接**（即相互访问的端点）**方面具有不同的要求**：
> 
> - [**带外控制平面对等互连**](https://docs.liqo.io/en/latest/features/peering.html#featurespeeringoutofbandcontrolplane)：它需要**三个独立的流量流**（也就是三个公开的终结点）。
> - [**带内控制平面对等互连**](https://docs.liqo.io/en/latest/features/peering.html#featurespeeringinbandcontrolplane)：它需要**单个终结点**，因为所有控制平面流量都在跨集群 VPN 内通过隧道传输。
>     
> 有关更多详细信息，请参阅[对等互连部分](https://docs.liqo.io/en/latest/features/peering.html)。
> 
> *注意：这两种对等互连方法是**非互斥的**：只要满足连接要求，群集就可以对不同的远程群集利用不同的方法。*
> 

## 骚操作

我试试能不能用 Liqo 把多个单节点集群联系起来成为一个去中心化的集群。

### 准备好单机集群

这里使用 k0s 。

步骤参考[这个笔记](../k0s-note#单机模式)。

### 联系起来这几个节点





