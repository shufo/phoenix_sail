# Usage

## Basic

### Up and running

```
$ sail up
```

To daemonize containers


```
$ sail up -d
```

To see container status

```
$ sail ps
```

### logs

```
$ sail logs phoenix.test
```

### Shell

To attach shell on application

```
$ sail shell
```

## Advanced

### MySQL

Connect To MySQL shell

```bash
$ sail mysql
```

### NPM

You can use npm command 

```bash
$ sail npm install --save-dev lodash
```
