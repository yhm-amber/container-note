

# ~/.profile

(
	: basic in jupyter ;
	pip install -U -- pip wheel polars dfply pipe ipywidgets ipykernel shinywidgets jupyter-server-proxy jupyter_copilot cognite-jupyterlab-copilot jupyterlab-link-share jupyter-collaboration jupyterlab_widgets pwb_jupyterlab jupyterlab_git ;
	jupyter lab clean ;
	clear ;
	: )

: pyenv user
cd && uv venv --allow-existing --no-project && . .venv/bin/activate && python -m ensurepip --upgrade

: alises
alias pip='python -m pip'
alias ipykernel='python -m ipykernel'
