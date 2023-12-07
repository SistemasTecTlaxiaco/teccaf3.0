// script.js

// Obtén la referencia a los elementos de la lista de usuarios y platillos en el HTML
const userList = document.getElementById('user-list');
const dishList = document.getElementById('dish-list');

// Función para hacer una solicitud GET al backend y obtener los usuarios
function getUsers() {
  const xhr = new XMLHttpRequest();
  xhr.open('GET', 'http://ruta-del-backend/buscarUsuarios', true);
  xhr.onreadystatechange = function() {
    if (xhr.readyState === 4 && xhr.status === 200) {
      const users = JSON.parse(xhr.responseText);

      // Recorre los usuarios y crea elementos de lista para mostrarlos
      users.forEach(user => {
        const listItem = document.createElement('li');
        listItem.textContent = `${user[0]} - ${user[1].nombre} ${user[1].apellidopaterno}`;
        userList.appendChild(listItem);
      });
    }
  };
  xhr.send();
}

// Función para hacer una solicitud GET al backend y obtener los platillos
function getDishes() {
  const xhr = new XMLHttpRequest();
  xhr.open('GET', 'http://ruta-del-backend/buscarPlatillos', true);
  xhr.onreadystatechange = function() {
    if (xhr.readyState === 4 && xhr.status === 200) {
      const dishes = JSON.parse(xhr.responseText);

      // Recorre los platillos y crea elementos de lista para mostrarlos
      dishes.forEach(dish => {
        const listItem = document.createElement('li');
        listItem.textContent = `${dish[0]} - ${dish[1].descripcion}`;
        dishList.appendChild(listItem);
      });
    }
  };
  xhr.send();
}

// Llama a las funciones para obtener los usuarios y los platillos al cargar la página
getUsers();
getDishes();