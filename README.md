# DevOps Training - App Java

Repositorio de la aplicación Java usada en el curso para practicar estrategias DevOps de CI/CD en proyectos compilados.

## Contexto del curso
- Herramientas: Jenkins (on-prem), GitHub/GitLab (SaaS) y Azure DevOps (plataforma cloud 360).
- La rama `feat/base` contiene el código mínimo para empezar y el enunciado de todas las prácticas.
- Cada práctica tiene su `.md` de enunciado en el repo de IaC (rama `feat/base`). La solución vive en la rama `training-x-title`.
- Este README se actualizará de forma incremental durante el curso.

## Repositorios y ramas
- App Python (base `feat/base`): https://github.com/contreras-adr/devops-training-python-app/tree/feat/base
- App Java (base `feat/base`): https://github.com/contreras-adr/devops-training-java-app/tree/feat/base
- IaC/DevOps (base `feat/base`): https://github.com/contreras-adr/devops-training-iac-devops/tree/feat/base

## Propósito del repositorio
- App Java simple con empaquetado y ejecución en contenedor.
- Base para pipelines, tests y análisis de calidad en CI/CD.

## Casos prácticos (5)
Habrá cinco casos prácticos, cada uno con una única rama de solución `training-x-title`.
- training-1-jenkins-config (ONGOING)
- training-2-piplines-ci-cd-jenkins (PENDING)
- training-3-github-actions (PENDING)
- training-4-gitlab-ci-cd (PENDING)
- training-5-azure-devops-pipelines (PENDING)

## Guía de uso local

### Crear imagen Docker de la app Java
```bash
docker build -t scalian_training-java-hello-world:0.0.2 --build-arg VERSION=0.0.2-SNAPSHOT -f devops/Dockerfile .

docker run -d --rm -p 8085:8080 --name java-app scalian_training-java-hello-world:0.0.2
curl localhost:8084/hello
docker stop java-app
```

### Verificar proyecto SonarQube (opcional)
```bash
# Evitar el siguiente error en Linux
# https://stackoverflow.com/questions/57998092/docker-compose-error-bootstrap-checks-failed-max-virtual-memory-areas-vm-ma
sudo sysctl -w vm.max_map_count=262144

docker-compose up -d sonarqube
docker-compose logs sonarqube

# Crear el proyecto en SonarQube accediendo a "localhost:9009"
# Nombre del proyecto: "devops-training-java-app"
docker networks ls
docker run \
    --rm -w /app \
    -v "c:/__ABSOLUTE_SRC_PATH__:/app" \
    --network java-project-base_java-project-net \
    maven:3.8.6-openjdk-11-slim \
    mvn verify sonar:sonar \
    -Dsonar.projectKey=devops-training-java-app \
    -Dsonar.host.url=http://172.16.234.10:9000 \
    -Dsonar.login=sqp_01291ee195139732bf0509b512c5f8dd4ccc8bf9

docker-compose down
```
