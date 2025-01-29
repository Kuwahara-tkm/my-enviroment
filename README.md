# build docker image
```
docker build ./ -t $IMAGE_NAME
```

# docker run command
#### arch-kuwahara(WSL)
```
docker run --gpus all -dit -p 8888:8888 -v /home/takumi-k/docker/sample/work:/work --name $CONTAINER_NAME  $IMAGE_NAME
```
#### cad-kuwahara
```
docker run --gpus all -dit -p 8888:8888 -v /mnt/ssd1/work:/work --shm-size=32g --name $CONTAINER_NAME  $IMAGE_NAME
```

#### cad111
```
docker run --gpus all -dit -p 8888:8888 -v /mnt/kuwahara/Cognitive-Tasks-with-Spiking-LCA:/work --name $CONTAINER_NAME  $IMAGE_NAME
```

# enter into docker container
```
docker exec -u 0 -it $CONTAINER_NAME /bin/bash  
```
```
docker exec -u 0 -it $CONTAINER_NAME /bin/zsh
```

# TensorBord run
```
tensorboard --logdir=runs --host=0.0.0.0 --port=8888
```

[TensorBord](http://localhost:8888)


# aliasの設定 
```
setenv CONTAINER_NAME container_name
alias docker_zsh 'docker exec -u 0 -it $CONTAINER_NAME /bin/zsh'
```
