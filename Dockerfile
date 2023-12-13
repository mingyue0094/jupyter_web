# 使用基础镜像
FROM jupyter/base-notebook

# 安装 Golang
USER root
RUN apt-get update && apt-get install -y golang && apt-get clean

# 安装 C++ 相关工具
RUN apt-get install -y build-essential && apt-get clean

# 切换回用户
USER jovyan

# # 安装 Jupyter 插件，支持 Golang
# RUN go get -u github.com/gopherdata/gophernotes && \
#     mkdir -p ~/.local/share/jupyter/kernels/gophernotes && \
#     cp -r $GOPATH/src/github.com/gopherdata/gophernotes/kernel/* ~/.local/share/jupyter/kernels/gophernotes

# 安装 Jupyter 插件，支持 C++
RUN conda install -c conda-forge xeus-cling

# 设置密码
RUN python3 -c "from notebook.auth import passwd; print(passwd('$JUPYTER_PASSWORD'))" > /home/jovyan/.jupyter/jupyter_notebook_config.py

EXPOSE 8888

# 启动 Jupyter Notebook
CMD ["start-notebook.sh"]

