# build docker image
```
docker build ./ -t $IMAGE_NAME
```

# docker run command
```
docker run --gpus all -dit -p 8888:8888 -v /home/takumi-k/docker/sample/work:/work --name $CONTAINER_NAME  $IMAGE_NAME
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

http://localhost:8888
