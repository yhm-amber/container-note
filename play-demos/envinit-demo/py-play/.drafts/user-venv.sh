# venv by uv
cd && uv venv --allow-existing --no-project && . .venv/bin/activate && python -m ensurepip --upgrade
alias pip='python -m pip'
alias ipykernel='python -m ipykernel'

# basic in jupyter
pip install -U -- pip wheel polars dfply pipe pipe-operator rustynum requests
pip install -U -- ipykernel ipywidgets nest-asyncio shinywidgets jupyter-ydoc jupyterlab-js jupyter-server-proxy jupyter_copilot cognite-jupyterlab-copilot jupyterlab-link-share jupyter-collaboration jupyverse[auth,notebook,jupyterlab] jupyterlab_widgets pwb_jupyterlab jupyterlab_git
ipykernel install --user --name "$(whoami)" --display-name "Python (venv user '$(whoami)')"
jupyter labextension list
jupyter server extension list

# axon like torch
pip install -U -- torch torchvision pytorch-lightning
