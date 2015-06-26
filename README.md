# Docker container memory usage plugin for munin

This plugin charts memory usage of all running docker containers in one
chart.

## Requirements:

* Munin
* Docker
* Ruby

## Configuration

Root is required to access docker's statistics. Add to your munin-node
plugin configuration:

```
[docker_containers]
user root
```

## License

MIT license. See LICENSE.

## Author

Warren Guy <warren@guy.net.au>

https://warrenguy.me
