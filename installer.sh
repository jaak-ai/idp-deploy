#!/bin/bash

echo Validando version de sistema operativo
cat /etc/redhat-release; echo Finnished

echo Validando version de tarjeta grafica
lspci | grep -i nvidia; echo Finnished

echo Actualizando sistema operativo
dnf update
wait; echo Finnished

echo Creando carpeta de instalacion
mkdir -p /opt/jaak/installer; echo Finnished

echo Ingresando a carpeta de instalacion
cd /opt/jaak/installer; echo Finnished

echo Instalando wget
dnf -y install wget; echo Finnished

echo Descargando paquetes necesarios
wget https://storage.googleapis.com/jaak-artifac/packages/binarios/offline/epel-release-latest-8.noarch.npm
wait; echo Finnished

echo Descagando paquetes de CUDA
wget https://storage.googleapis.com/jaak-artifac/packages/binarios/offline/cuda-repo-rhel-8-11-8-local-11.8.0_520.61.05-1.x86_64.rpm
wait; echo Finnished

echo Descargando paquetes de CUDNN
wget https://storage.googleapis.com/jaak-artifac/packages/binarios/offline/cudnn-local-repo-rhel8-8.6.0.163-1.0-1.x86_64.npm
wait; echo Finnished

echo Validando paquetes descarggados
ls- ltrh

/usr/bin/crb enable;



echo Instalacion de paquetes
rpm -ivh epel-release-latest-8.noarch.rpm

rpm -ivh cuda-repo-rhel8-11-8-local-11.8.0_520.61.05-1.x86_64.rpm
wait; echo Finnished

pm -ivh cudnn-local-repo-rhel8-8.6.0.163-1.0-1.x86_64.rpm
wait; echo Finnished

echo Instalando driver NVIDIA
dnf -y module install nvidia-driver:520-dkms
wait;
echo Finnished

echo Validando datos de tarjeta NVIDIA
nvidia-smi
sleep 10

echo Instalando paquete CUDA
rpm -i cudnn-local-repo-rhel8-8.6.0.163-1.0-1.x86_64.rpm
wait;

Echo Instalando librerias libcudnn
dnf install libcudnn.x86_64
wait; echo Finnished

Echo Instalando libreria libcudnn8-devel
dnf install libcudnn8-devel.x86_64
wait; echo Finnished

echo Validando librerias instaladas
find / -name libcudnn*; echo Finnished

cd ..

echo Creando carpeta para instalacion de software
mkdir bin;
cd bin;
echo Finnished

echo Descaargando VectorStrange
wget https://storage.googleapis.com/jaak-artifact/jaak-vs.tar.gz
wait; echo Finnished

echo Descargando Liveness
wget https://storage.googleapis.com/jaak-artifact/jaak-lv.tar.gz
wait; echo Finnished

echo Descargando Image Quality
wget https://storage.googleapis.com/jaak-artifact/packages/binarios/jaak-iq.tar.gz
wait; echo Finnished

echo Descargando librerias
gsutil cp gs://jaak-artifact/packages/binarios/libs.tar.gz /opt/jaak/bin/
wait; echo Finnished

echo Revisando paquetes descargados
ls -lrth; echo Finnished

echo Descomprimiendo paquetes
tar -xvzf jaak-vs.tar.gz
tar -xvzf libs.tar.gz

echo Exportando librerias al PATH
export LD_LIBRARY_PATH=/opt/jaak/bin/libs

#echo Descargando servicios
#
#
#

#echo Copiando servicios 
# /usr/lib/systemd/system/jaak-lv.service
# /usr/lib/systemd/system/jaak-iq.service
# /usr/lib/systemd/system/jaak-vs.service
#

#echo Iniciando servicios
# systemctl start jaak-vs
# systemctl start jaak-lv
# systemctl start jaak-iq

#Instalacion de mongoDB
sudo yum install -y mongodb-org-6.0.4 mongodb-org-database-6.0.4 mongodb-org-server-6.0.4 mongodb-org-mongos-6.0.4 mongodb-org-tools-6.0.4
wait; echo Finnished

echo Inicializando mongo
sudo systemctl start mongo

echo Validando servicio activo de mongo
sudo systemctl status mongod



#Instalacion de minikube
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"