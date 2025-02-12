# 🌦️ Weather API 

La API recibe el nombre de una ciudad y devuelve el **pronóstico del clima** de los próximos **7 días**.

> ⚠️ **No sé mucho de programación, pero hice lo mejor que pude!** 😃  
> Si encuentras algo que mejorar, dime cómo hacerlo! 🚀

---

## **🛠 Instalación**

### **Requisitos**
Antes de empezar, necesitas instalar:
- Ruby 3.2.2
- Rails 7.x
- Bundler

---

### **Clonar el proyecto**
Abre la terminal y ejecuta:

```sh
git clone https://github.com/TU_USUARIO/weather_api.git
cd weather_api
```

### **Instala las dependencias**
```sh
bundle install
```

### **Prende el servidor**
```sh
bin/rails server
```

🚀 Cómo usar la API
Abre tu navegador o usa Postman con esta URL:
```http://localhost:3000/weather?city=Monterrey```
🔹 Esto devolverá un JSON con la temperatura mínima y máxima de los próximos 7 días, de todos los lugares que coinciden con el nombre que ingresaste.

🌍 Interfaz "amigable"
Si quieres probar la interfaz web, ve a:
```http://localhost:3000/weather_page```
Aquí puedes escribir el nombre de una ciudad, elegirla y ver su pronóstico de manera amigable. 😃

📝 Notas finales
No uso base de datos porque no es necesario.
No necesitas autenticación, cualquiera puede usar la API.
Si tienes dudas, dime! Estoy aprendiendo. 😊
