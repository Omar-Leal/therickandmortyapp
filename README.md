
# Prueba Técnica iOS  

Este repositorio contiene el proyecto desarrollado como parte de la prueba técnica para la posición de desarrollador iOS. A continuación, se describen los detalles técnicos, patrones de diseño aplicados y funcionalidades implementadas.  

---

## Tecnologías utilizadas  

- **Framework:** UIKit  
- **Lenguaje:** Swift  
- **Librerías:**  
  - **Firebase:** Para la funcionalidad de registro y login.  
  - **SkeletonView:** Para mostrar un loader mientras se espera la respuesta de los endpoints.  

---

## Patrones de diseño implementados  

1. **Coordinador:**  
   - Centraliza la navegación y gestiona el flujo de la aplicación.  
   - Utilizado para determinar el estado de login y registro mediante el SDK de Firebase.  

2. **MVVM (Model-View-ViewModel):**  
   - Aplicado en los componentes internos, especialmente en la interacción con la API de *Rick and Morty*.  
   - Mejora la separación de responsabilidades y la testabilidad del código.  

---

## Funcionalidades adicionales  

1. **Filtro por nombre:**  
   - Se implementó un campo de texto (`UITextField`) que permite filtrar personajes por nombre.  
   - Incluye un **debounce** para optimizar las consultas mientras el usuario escribe.  

2. **Filtros avanzados:**  
   - Botón debajo del campo de texto que despliega un **PopUp** con opciones de filtros adicionales.  

3. **Optimización con Caché:**  
   - Imágenes descargadas almacenadas en caché para mejorar el rendimiento.  
   - Implementación de caché de respuestas para optimizar las consultas a la API.  

4. **Manejo de errores:**  
   - Control robusto de errores para gestionar problemas de conexión con el backend, garantizando una experiencia de usuario fluida.  

---

## Instalación y configuración  

1. Clona el repositorio:  
   ```bash  
   git clone [URL del repositorio]  
   ```  

2. Instala las dependencias del proyecto:  
   ```bash  
   pod install  
   ```  

3. Configura Firebase:  
   - Añade el archivo `GoogleService-Info.plist` en el directorio del proyecto.  

4. Ejecuta el proyecto en Xcode.  

---

## Contacto  

Si tienes alguna duda o comentario, no dudes en contactarme:  
**Omar Leal**  
omar.leal@example.com  
