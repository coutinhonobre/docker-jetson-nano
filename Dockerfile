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

# Define o diretório de trabalho
WORKDIR /workspace

# Muda para o usuário não-root
USER jupyter-user

# Expõe a porta do JupyterLab
EXPOSE 8888

# (Token será definido no docker-compose)
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
