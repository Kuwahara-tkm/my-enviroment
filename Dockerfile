FROM nvidia/cuda:12.1.0-base-ubuntu22.04

RUN apt-get update && apt-get install -y \
    python3-pip \ 
    sudo \
    wget \
    git \
    curl \
    vim \
    byobu

RUN ln -s /usr/bin/python3.10 /usr/bin/python

RUN pip install --upgrade pip

RUN pip install \ 
    torch \
    torchvision \
    torchaudio \
    torchinfo \
    torchviz \
    einops \
    timm \
    tensorflow \
    matplotlib \
    cupy-cuda12x

RUN git clone https://github.com/fangwei123456/spikingjelly.git /work/spikingjelly \
    && cd /work/spikingjelly \
    && python setup.py install

# Install vim-plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Solarized coler scheme
RUN mkdir -p ~/.vim/colors && \
    cd ~/.vim/colors && \
    curl -O https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim


# .vimrc
RUN echo 'call plug#begin("~/.vim/plugged")' >> ~/.vimrc && \
    echo "Plug 'preservim/nerdtree'" >> ~/.vimrc && \
    echo "Plug 'altercation/vim-colors-solarized'" >> ~/.vimrc && \
    echo 'call plug#end()' >> ~/.vimrc && \
    echo 'nnoremap <C-n> :NERDTree<CR>' >> ~/.vimrc && \
    echo 'syntax enable' >> ~/.vimrc && \
    echo 'set background=dark' >> ~/.vimrc && \
    echo 'set number' >> ~/.vimrc && \
    echo 'colorscheme molokai' >> ~/.vimrc && \
    echo 'filetype plugin indent on' >> ~/.vimrc && \
    echo 'syntax on' >> ~/.vimrc && \
    echo 'set t_Co=256' >> ~/.vimrc && \
    echo 'highlight Normal ctermbg=none' >> ~/.vimrc && \
    echo 'highlight NonText ctermbg=none' >> ~/.vimrc && \
    echo 'highlight LineNr ctermbg=none' >> ~/.vimrc && \
    echo 'highlight Folded ctermbg=none' >> ~/.vimrc && \
    echo 'highlight EndOfBuffer ctermbg=none ' >> ~/.vimrc && \
    echo 'highlight Comment ctermfg=DarkBlue ' >> ~/.vimrc && \
    echo 'highlight Visual cterm=none ctermbg=yellow ctermfg=black guibg=yellow guifg=black ' >> ~/.vimrc && \
    echo 'inoremap { {}<LEFT> ' >> ~/.vimrc && \
    echo 'inoremap [ []<LEFT> ' >> ~/.vimrc && \
    echo 'inoremap ( ()<LEFT> ' >> ~/.vimrc && \
    echo 'inoremap " ""<LEFT> ' >> ~/.vimrc && \
    echo "inoremap ' ''<LEFT> " >> ~/.vimrc && \
    echo 'autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4' >> ~/.vimrc

# Vimプラグインをインストールします
RUN vim +PlugInstall +qall

WORKDIR /work

CMD ["/bin/bash"]
