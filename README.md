# Tech-Pay Flutter
Tech-Pay Flutter es una aplicación desarrollada en Flutter que permite a los administradores gestionar clientes y visualizar transacciones de una pasarela de pagos. La aplicación incluye autenticación para el usuario administrador utilizando JWT.

## 🚀 Características
Gestión de Clientes: Permite al administrador agregar, editar y eliminar información de los clientes.
Visualización de Transacciones: Muestra un historial detallado de las transacciones realizadas.
Gestión de API Keys: Administración de claves API relacionadas con los clientes.
Autenticación Segura: Implementa inicio de sesión para el administrador con autenticación JWT.
Interfaz Intuitiva: Diseñada con principios de UI/UX para facilitar la navegación.

## 📋 Requisitos Previos
Antes de comenzar, asegúrate de tener instalado lo siguiente:

Flutter SDK (versión 3.0 o superior).
Dart SDK (versión 2.12 o superior).
Un editor de código como Visual Studio Code o Android Studio.
Pasarela de Pagos API: Necesitarás el enlace base de la API de tu pasarela de pagos para configurarla en la aplicación.
🛠️ Configuración Inicial
Clona este repositorio en tu máquina local utilizando el siguiente comando:

bash
Copiar
Editar
git clone https://github.com/DevJorgeRafael/tech-pay-flutter.git
cd tech-pay-flutter
Dentro del proyecto encontrarás un archivo llamado .env.example, que contiene las variables de entorno necesarias para la configuración del proyecto. Copia el archivo y renómbralo como .env:

bash
```
cp .env.example .env
```


Abre el archivo .env y completa los valores necesarios, incluyendo la URL de la API base. Ejemplo:

env
Copiar
Editar
## URL base de la API de la pasarela de pagos
bash
```
BASE_API_URL=https://192.168.1.6:3000/api
IS_DEV=false
```

## Configuración adicional
Ejecuta el siguiente comando para descargar e instalar todas las dependencias del proyecto:

bash
```
flutter pub get
```

Para ejecutar la aplicación en un dispositivo físico o emulador, utiliza el siguiente comando:

bash
```
flutter run
```

## 📂 Estructura del Proyecto
La estructura principal del proyecto es la siguiente:

text
```
/lib
├── app.dart                    # Configuración principal de la aplicación
├── features/
│   ├── auth/                   # Funcionalidad de autenticación
│   ├── home/                   # Gestión de clientes, transacciones y API Keys
│   │   ├── data/               # Repositorios y fuentes de datos
│   │   ├── domain/             # Entidades y lógica de negocio
│   │   ├── presentation/       # Vistas, widgets y providers
│   └── shared/                 # Widgets y servicios compartidos
├── injection_container.dart    # Configuración de dependencias
├── main.dart                   # Punto de entrada principal
```

## 📝 Uso
Inicio de Sesión
El administrador puede iniciar sesión utilizando sus credenciales, las cuales serán verificadas mediante JWT. Asegúrate de que el backend de la API esté configurado correctamente para aceptar solicitudes de autenticación.

## Gestión de Clientes
Visualiza una lista de clientes registrados.
Agrega, edita o elimina clientes según sea necesario.
## Visualización de Transacciones
Cada cliente tiene un historial de transacciones asociadas.
Las transacciones se pueden filtrar por fecha y estado.
## Gestión de API Keys
Administra claves API relacionadas con cada cliente.
Cambia el estado de las claves API (habilitar o deshabilitar).
