# Poisson Saturne Strange Attractor

https://user-images.githubusercontent.com/45020018/169628131-76a65d40-fe01-4e40-95cb-dc23cd36161a.mp4

## Examples
run

create image 'Poisson Saturne' Attractor
```
swift run PoissonSaturne
```
save `PoissonSaturne.png` into current directory.

create image 'Solar Sail' Attractor
```
swift run PoissonSaturne --solar-sail
```
save `SolarSail.png` into current directory.

option

image size
```
 -w 480 -h 360
```

high density
```
 -d 8
```

count of iteration
```
 -N 100000
```

Examples rotaion

Poisson Saturne
```
 -x 0 -y 180 -z 75
```
Solar Sail
```
 --solar-sail -x 0 -y 90 -z 0
```

Example Shell Script
```
for i in `seq 10 99`
do
    ./PoissonSaturne -x 0 -y $i -z 75 -o ~/Downloads/y0$i.png
done
```
