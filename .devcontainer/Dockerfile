FROM ubuntu:18.04

# aptの初期化
RUN apt update && apt upgrade 
# curlインスコ
RUN apt install curl -y
# stack install
RUN curl -sSL https://get.haskellstack.org/ | sh

RUN apt install -y sqlite3 libsqlite3-dev libicu-dev libtinfo-dev libgmp-dev zlib1g-dev

ENV PATH ~/.local/bin:$PATH
ENV PATH $(stack path --local-bin):$PATH

RUN git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules
RUN cd haskell-ide-engine && stack ./install.hs hie-8.6.5
RUN cd haskell-ide-engine && stack ./install.hs build-data

ENV PATH $(stack path --compiler-bin):$PATH

RUN echo PATH=~/.local/bin:$PATH >> /root/.bashrc && \
    echo PATH=$(stack path --local-bin):$PATH >> /root/.bashrc && \
    echo PATH=$(stack path --compiler-bin):$PATH >> /root/.bashrc