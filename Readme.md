# Proyecto de Infraestructura en GCP 🚀

Este repositorio define la infraestructura del proyecto en Google Cloud Platform (GCP) utilizando Terraform. La estructura permite crear y configurar servicios como balanceador de carga, Cloud Run, Artifactory, entre otros, siguiendo buenas prácticas de infraestructura como código (IaC).

### Módulos 🧩

![Diagrama de los Módulos](images/diagrama_modulos.png)

Los módulos permiten reutilizar código y estandarizar la configuración de los recursos. Cada módulo en este proyecto es responsable de un componente específico de la infraestructura, como:

- **artifactory**: Configura el repositorio de productos.
- **bucket**: Gestiona los buckets de almacenamiento.
- **certificate**: Gestiona los certificados SSL.
- **cloud-run**: Configura Cloud Run para los servicios.
- **load-balancer**: Define el balanceador de carga y sus backends.
- **oidc**: Gestiona la autenticación OIDC para GitHub Actions.
- **secret**: Define los secretos necesarios.
- **service-account**: Crea cuentas de servicio.
- **sql**: Configura la base de datos SQL.
- **vpc**: Gestiona la red y las IPs estáticas.

## Cómo Utilizar 🚀

### Requisitos ✅

- Terraform CLI
- Google Cloud CLI
- Cuenta en Google Cloud Platform con permisos apropiados

### Configuración ⚙️

1. Cloná este repositorio:

   ```sh
   git clone git@github.com:daviresio/products-iac.git
   cd products-iac
   ```

2. Autenticáte en GCP:

   ```sh
   gcloud auth login
   ```

3. Inicializá Terraform:

   ```sh
   terraform init
   ```

4. Validá y aplicá los cambios:

   ```sh
   terraform plan
   terraform apply
   ```

## Mejores Prácticas 🌟

- **Modularización**: Todos los recursos fueron modularizados para facilitar la reutilización y el mantenimiento.
- **Autenticación Segura**: Uso de cuentas de servicio y OIDC para la autenticación de workloads.
- **Control de Versión**: Siempre versionar los archivos Terraform para rastrear cambios en la infraestructura.

## Deuda Técnica 🔧

Durante la implementación, identificamos algunos puntos que necesitan ser mejorados:

1. **Habilitación de APIs de Google**: Como es necesario habilitar las APIs de Google en el primer uso, faltó incluir un script que automatice esta habilitación; actualmente, es necesario ir habilitando las APIs manualmente según se presenten errores.
2. **Integración con CI**: No se implementó la integración con un pipeline de CI para automatizar el aprovisionamiento de la infraestructura.
3. **Sustitución de Imagen en Cloud Run**: La imagen utilizada actualmente es de un Artifactory privado, lo que impide que el health check funcione correctamente. Es necesario sustituirla por una imagen que responda "ok" para el health check.
4. **Manejo de Secretos**: Sería recomendable sustituir los secretos por variables de entorno o algún servicio en la nube que no versione los secretos en el repositorio.

## Contacto 📧

Si tenés dudas o sugerencias, ponete en contacto al email: [daviresio@gmail.com](mailto:daviresio@gmail.com).
