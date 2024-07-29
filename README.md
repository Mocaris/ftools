

ftools.yaml

```yaml
#  忽略文件和文件夹
ignore:
  - "**/2.0x/**"
  - "**/3.0x/**"
  - "**.txt"
  - "**.json"
# 资源文件夹
assets_dir: assets/image
# 生成资源 class name
class_name: Assets
# 生成资源 class path
class_path: lib/resource/assets.dart
# 生成资源 是否排序
sort: true
```


> uasge:
> ftools -g