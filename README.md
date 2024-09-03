# Poisson Saturne Strange Attractor

https://user-images.githubusercontent.com/45020018/169628131-76a65d40-fe01-4e40-95cb-dc23cd36161a.mp4

## Examples
run

create image 'Poisson Saturne' Attractor
```
PoissonSaturne json/PoissonSaturne.json -y 180 -z 75 -o ~/Downloads/PoissonSaturne.png
```
save `PoissonSaturne.png` into `Downloads` directory.

create image 'Solar Sail' Attractor
```
PoissonSaturne json/SolarSail.json -y 90 -o ~/Downloads/SolarSail.png
```
save `SolarSail.png` into `Downloads` directory.

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

Example Shell Script
```
for i in `seq 10 99`
do
    PoissonSaturne PoissonSaturne.json -x 0 -y $i -z 75 -o ~/Downloads/y0$i.png
done
```
