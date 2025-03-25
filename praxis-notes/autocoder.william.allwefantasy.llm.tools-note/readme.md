[site]: https://auto-coder.chat/ "AI-powered interactive coding assistant // 人工智能驱动的交互式编码助手"

[pip/pypi]: https://pypi.org/project/auto-coder/ "(: pip install -U -- auto-coder) (: cd your-project ;: auto-coder.chat)"
[web.pip/pypi]: https://pypi.org/project/auto-coder-web/ "(: pip install -U -- auto-coder-web) (: cd your-project ;: auto-coder.web) (: open-web localhost:8007)"

[src/gh]: https://github.com/allwefantasy/auto-coder.git "(Apache-2.0) (Languages: HTML 75.8%, Python 17.0%, Jupyter Notebook 6.6%, TypeScript 0.5%, Go 0.1%, JavaScript 0.0%) Auto-Coder (powered by Byzer-LLM)"
[web.src/gh]: https://github.com/allwefantasy/auto-coder.web.git "(Languages: TypeScript 68.0%, Python 23.9%, Shell 3.5%, CSS 1.4%, JavaScript 1.3%, Jupyter Notebook 1.0%, Other 0.9%) port: 8007"

[oci/dockerhub]: https://hub.docker.com/r/allwefantasy/auto-coder-web "(: docker run --name auto-coder-web -e BASE_URL=https://api.deepseek.com/v1 -e API_KEY=$MODEL_DEEPSEEK_TOKEN -e MODEL=deepseek-chat -p 8006:8006 -p 8007:8007 -p 8265:8265 -v <你的项目>:/app/work -v <你的日志目录>:/app/logs -- allwefantasy/auto-coder-web ;: open-web localhost:8007)"
