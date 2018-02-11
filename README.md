# Установка 1с (i386) на Ubuntu (i386)

## Подготовка

Копируем пакеты 1с в папку dist

## Сборка образа

```sh
docker build -t z-ank/1c .
```

## Запуск

```sh
chmod +x run && ./run
```

или
добавить в ~/.bashrc
(`alias 1centerprise="docker run --rm -e DISPLAY=$DISPLAY -v $HOME/.Xauthority:/home/developer/.Xauthority -v $HOME:/home/developer -v /win-d:/mnt/ --net=host --pid=host --ipc=host z-ank/1c &"`)
