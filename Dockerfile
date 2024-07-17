# Imagem base otimizada para Jetson (L4T) com CUDA e cuDNN
FROM nvcr.io/nvidia/l4t-tensorflow:r35.3.1-tf2.11-py3

# Atualiza lista de pacotes e instala as dependências
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Instala o JupyterLab e outras bibliotecas Python
RUN pip3 install --upgrade pip \
    && pip3 install jupyterlab numpy matplotlib pandas scipy scikit-learn

# Cria um usuário não-root para segurança
RUN useradd -ms /bin/bash jupyter-user

# Define o token fixo (substitua 'seu_token_secreto' por um valor seguro)
ENV JUPYTER_TOKEN=9dsf87AJSdkj12398DDslkjSDF98
ENV PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# Define o diretório de trabalho
WORKDIR /workspace

# Muda para o usuário não-root
USER jupyter-user

# Expõe a porta do JupyterLab
EXPOSE 8888

# Inicia o JupyterLab com o token fixo
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]