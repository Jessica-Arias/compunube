Dentro de la carpeta se encuentra los archivos necesarios para la implementación del microproyecto 2 de Computación en la nube, para cada punto se muestra acontinuación los comandos necesarios para su implementación:
Nota: Los archivos en la máquina virtual se encuentran dentro de /vagrant/kubernet

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Primer punto:
	az login
	az aks get-credentials --resource-group microproyecto2_group --name microproyecto2
	kubectl get service
	(Desde este momento se confirma que su creación es exitosa, sin embargo se crea una aplicación para comprobarlo).
	kubectl apply -f azure-vote.yaml
	kubectl get service azure-vote-front --watch

- Comprobación:
	Entrar desde el ordenador a la EXTERNAL-IP

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Segundo punto:
	az login
	az aks get-credentials --resource-group microproyecto2_group --name microproyecto2
	kubectl apply -f deployment.yaml
	kubectl expose deployment kubermatic-dl-deployment  --type=LoadBalancer --port 80 --target-port 5000
	kubectl get service

-Comprobación:
	1.) Cargar en la carpeta compartida imagenes, de las clases del CIFAR10 (Avión, automóvil, ave, gato, venado, perro, caballo, barco, camión, rana)
	2.) Usar en la máquina virtual los siguientes comandos:	
	cd /vagrant
	ls
	curl -X POST -F img=@perro.jpg 20.121.76.255/predict
	nota: Cambiar 20.121.76.255 por la EXTERNAL-IP del servicio y perro.jpg por el nombre de la imagen a enviar

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Tercer punto:	
	az login
	az aks get-credentials --resource-group microproyecto2_group --name microproyecto2
	kubectl apply -f nginx-deployment.yaml
	kubectl apply -f nginx-service.yaml
	kubectl get service

Comprobación:
	Entrar desde el ordenador a la EXTERNAL-IP

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Punto Extra: 
	kubectl apply -f https://k8s.io/examples/application/php-apache.yaml
	kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
	kubectl get hpa
	(En otra terminal, correr la carga): kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"
	kubectl get hpa php-apache --watch (Despues de un minuto se va actualizando, va aumentando los tragets y las réplicas).
	(Frenar la carga de la otra terminal)
	(La carga de la terminal principal irá disminuyendo, al igual que las réplicas).
