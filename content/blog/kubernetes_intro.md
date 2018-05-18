+++
date = "2018-05-11"
title = "O que é Kubernetes"
tags = ["kubernetes","overview", "101", "k8s", "intro"]
categories = ["k8s"]
draft = false
description = "Este pequeno texto irá dar um panorama geral sobre o que é Kubernetes."
weight = 10
+++

# Um passeio rápido sobre Kubernetes

<span style="display:block;text-align:center">![K8s](/img/k8slogo.png)</span>

Kubernetes é o que mais se fala hoje em dia. Foi desenvolvido inicialmente pelo Google, era um projeto interno chamado Borg e era o que o Google utilizava para executar e gerenciar as suas aplicações.

Se quiser saber mais sobre o Borg leia este [paper](https://pdos.csail.mit.edu/6.824/papers/borg.pdf).

Kubernetes também é conhecido pela abreviatura **K8s**.
Kubernetes (κυβερνήτης, palavra Grega para  "Timoneiro" or "piloto") foi fundado por Joe Beda, Brendan Burns and Craig McLuckie e anunciado em meados de 2014.
A versão inicial foi lançada em 21 de Julho de 2015. (extraido da [WikiPedia](https://en.wikipedia.org/wiki/Kubernetes#History))

Sendo bem simplista, Kubernetes é uma aplicação que executa e gerencia aplicações em containers (como as criadas pelo [Docker](https://www.docker.com/)). É uma plataforma que gerencia todo o ciclo de vida de um container.

Como um usuário de Kubernetes você pode definir como suas aplicações irão ser executadas, como elas vão se comunicar dentro e fora do cluster, você pode escalar a aplicação, fazer rollback, etc..

Kubernetes irá gerenciar a sua aplicação, por exemplo se você definiu que gostaria que sua aplicação tenha 5 replicas (replica são quantos pods da mesma imagem estarão no ar), o Kubernetes irá se assegurar que 5 replicas estejam sempre rodando. Se por acaso uma morrer ele irá iniciar um novo para substituir o que falhou.


## Arquitetura do Kubernetes

A arquitetura de um cluster de Kubernetes não é tão complicada de se entender. Um cluster de Kubernetes pode ser criado usando servidores físicos ou máquinas virtuais ou um mix disso.

O cluster é divido em ***master*** servers e ***nodes***.
Os ***masters*** são o cerebro do cluster, eles que gerenciam o estado dos pods e do cluster em si.
Os ***nodes*** são servidores responsáveis por aceitar e executar os containers.

### Master

Existem alguns componentes que são executados pelos servidores marcadados como ***master***. Vamos descrever cada um:

#### kube-apiserver

É uma dos componentes mais importantes do cluster. Ele gerencia o cluster a fz com que os usuários possam configurar seus workloads. Ele também é responsável em registrar o estados do cluster no ***etcd***.
O API server age como uma ponte entre todos os serviços do cluster. Ele implementa uma interface RESTful e tem um cliente chamado ***kubectl*** com que os usuários interagem como o cluster.

#### etcd

etcd é um store de chave-valor de alta consistência desenvolvido pela [CoreOS](https://coreos.com/etcd/).
o etcd é uma peça fundamental no cluster, pois ele registra o estado de todo o cluster.

#### kube-controller-manager

Este é um serviço mais genérico que tem muitas responsabilidades, ele gerencia o estado do cluster, o workload e algumas tarefas de rotina, se você, pro exemplo, pede para reduzir o número de replicas de um pod ele que vai tratar disso.

#### kube-scheduler

Este serviço cuida do agendamento do seu workload, ele verifica se seu workload tem algum requisito especifico, procura um node diposnível e capaz de executar o solicitado.
Também é responsável por gerenciar a capacidade de cada node e reportar para o API Server que por sua vez irá salvar as informações no etcd.

### Nodes

No ecosistema do Kubernetes os servidores que executam o workload são conhecidos como ***nodes***. Nestes servidores temos que ter algums requisitos, como ter o *docker* instaldo (ou outro container runtime como, por exemplo, [**rkt**](https://coreos.com/rkt/) também da CoreOS).

Nos nodes temos os serviços:

#### kubelet

Kubelet é o ponto de comunicação entre o node e o master. Ele que recebe os manifestos e inicia o processo de execução com o docker (ou outro runtime).

#### kube-proxy

É responsável por gerenciar a rede individual de cada pod e redicionar o trafego para o pod correto.

Abaixo um diagrama da arquitetura de um cluster Kubernetes:

![Arquitetura do Kubernetes](/img/Kubernetes.png)
fonte: [WikiPedia](https://en.wikipedia.org/wiki/Kubernetes)

Agora você deve estar se perguntando o que é um ***pod***, que descrevi acima.
Bom, um ***pod*** é a unidade mais básica do Kubernetes, um pod pode ser apenas um container ou vários.

Se um pod tiver mais de um container, a comunicação entre eles pode ser feita utilizando o **localhost** diretamente, não é necessário saber o ip nem dns. (Vou falar mais sobre pods em um outro post).

Bom agora você já tem uma idéia básica sobre o que é Kubernetes.
Nos próximos posts vamos falar mais sobre os Recursos (Workloads) que você pode criar em um cluster Kubernetes.

Para mais informações você pode consultar (sites em Inglês):

 - [Kubernetes.io](https://kubernetes.io)
 - [Docker](https://www.docker.com/)


Espero que tenha gostado.
Até mais ;-)
