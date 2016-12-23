FROM jare/vim-bundle

RUN apk update && \
    apk add the_silver_searcher

RUN cd /home/developer/bundle && \
    git clone --depth 1 https://github.com/encody/nvim.git && \
    git clone --depth 1 https://github.com/mattn/emmet-vim.git && \
#cleanup
    sh /util/ocd-clean /home/developer/bundle/  > /dev/null 2>&1

COPY my.vimrc /ext/.vimrc
