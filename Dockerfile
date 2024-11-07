FROM nvidia/cuda:12.1.0-base-ubuntu22.04

RUN apt-get update && apt-get install -y \
    python3-pip \ 
    sudo \
    zsh \
    # wget \
    git \
    curl \
    vim \
    byobu \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ENV SHELL /usr/bin/zsh
RUN zsh
RUN chsh -s /bin/zsh
SHELL ["/bin/zsh", "-c"]

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

# molokai coler scheme
RUN mkdir -p ~/.vim/colors && \
    git clone https://github.com/tomasr/molokai && \
    mv molokai/colors/molokai.vim ~/.vim/colors/

# .vimrc
RUN echo 'call plug#begin("~/.vim/plugged")' >> ~/.vimrc && \
    echo "Plug 'vim-airline/vim-airline'" >> ~/.vimrc && \
    echo "Plug 'vim-airline/vim-airline-themes'" >> ~/.vimrc && \
    echo "Plug 'lambdalisue/fern.vim'" >> ~/.vimrc && \
    echo "Plug 'lambdalisue/fern-git-status.vim'" >> ~/.vimrc && \
    echo "Plug 'airblade/vim-gitgutter'" >> ~/.vimrc && \
    echo 'call plug#end()' >> ~/.vimrc && \
    echo 'set background=dark' >> ~/.vimrc && \
    echo 'set number' >> ~/.vimrc && \
    echo 'syntax on' >> ~/.vimrc && \
    echo 'colorscheme molokai' >> ~/.vimrc && \
    echo 'set t_Co=256' >> ~/.vimrc && \
    echo 'let g:airline_theme="simple"' >> ~/.vimrc && \
    echo 'let g:airline#extensions#tabline#enabled = 1' >> ~/.vimrc && \
    echo 'nmap <C-n> <Plug>AirlineSelectNextTab' >> ~/.vimrc && \
    echo "let g:airline#extensions#default#layout = [[ 'a', 'b', 'c' ], ['z']]" >> ~/.vimrc && \
    echo 'nnoremap <C-f> :Fern . -reveal=% -drawer -toggle -width=40<CR>' >> ~/.vimrc && \
    echo 'highlight Visual ctermfg=black ctermbg=yellow' >> ~/.vimrc && \
    echo 'highlight LineNr ctermbg=NONE guibg=NONE' >> ~/.vimrc && \
    echo 'filetype plugin indent on' >> ~/.vimrc && \
    echo 'inoremap { {}<LEFT>' >> ~/.vimrc && \
    echo 'inoremap [ []<LEFT>' >> ~/.vimrc && \
    echo 'inoremap ( ()<LEFT>' >> ~/.vimrc && \
    echo 'inoremap " ""<LEFT>' >> ~/.vimrc && \
    echo "inoremap ' ''<LEFT>" >> ~/.vimrc && \
    echo "set encoding=utf-8" >> ~/.vimrc && \
    echo "set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8" >> ~/.vimrc && \
    echo 'autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4' >> ~/.vimrc

# vim-plug install
RUN vim +PlugInstall +qall

# oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

# zsh default
RUN chsh -s $(which zsh)

WORKDIR /work

CMD ["/bin/zsh"]
