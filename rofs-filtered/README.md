Docker image for [gburca/rofs-filtered](https://github.com/gburca/rofs-filtered/)

# Usage


```bash 
docker run --rm -it \
    --privileged --cap-add SYS_ADMIN --device /dev/fuse \
    --mount type=bind,source=$(pwd)/host_dir_with_files,target=/container_dir_readonly,readonly,bind-propagation=shared \
    --mount type=bind,source=$(pwd)/host_dir_for_filtered_files,target=/container_dir_filtered_files,bind-propagation=shared \
    --mount type=bind,source=$(pwd)/host_dir_filter_rules.rc,target=/filter_rules.rc \
    apkawa/rofs-filtered  \
        -o source=/container_dir_readonly  \
        -o config=/filter_rules.rc \
        -f \
        /container_dir_filtered_files/
```

docker-compose

```yaml

# Must be >=3.3
version: '3.3'

services:
   rofs-filtered:
      build:
        dockerfile: ./Dockerfile
        context: .
      image: apkawa/rofs-filtered
      container_name: rofs-filtered
      # required
      privileged: true
      # required
      cap_add:
        - SYS_ADMIN
      # required
      devices:
        - /dev/fuse
      command: >
        -o source=/container_dir_readonly
        -o config=/filter_rules.rc
        -f
        /container_dir_filtered_files/

      volumes:
        # From filtered
        - type: bind
          source: /tmp/rofs/host_dir_with_files
          target: /container_dir_readonly
          read_only: true
          bind:
            propagation: shared
        # to filtered
        - type: bind
          source: /tmp/rofs/host_dir_for_filtered_files
          target: /container_dir_filtered_files
          read_only: false
          bind:
            propagation: shared
        - /tmp/rofs/host_dir_filter_rules.rc:/filter_rules.rc:ro

   example:
     image: nginx
     ports:
       - 19091:80
     depends_on:
       - rofs-filtered
     volumes:
       # mount filtered files
       - /tmp/rofs/host_dir_for_filtered_files:/opt/www/files/:ro,shared
```