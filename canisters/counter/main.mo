import Text "mo:base/Text";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import D "mo:base/Debug";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
//import Identity "ic:canister/identity";
import Int "mo:base/Int";
//import Time "mo:base/Time";
import Principal "mo:base/Principal";

//Backend del canister

actor teccaf {

  type Usuario = {
    nombre: Text;
    apellidopaterno: Text;
    apellidomaterno : Text;
    telefono : Int;
    email: Text;
    tipo: Text; // "proveedor" o "cliente"
    identidad: Principal; // Identidad de Internet Identity
  };
  type Indice = Nat;
  var indice: Indice = 0;
  let usuarios = HashMap.HashMap<Text, Usuario>(0, Text.equal, Text.hash);


  //var usuarios : [Usuario] = [];

  private func generateIUser() : Nat {
    indice += 1;
    return indice;
  };
 

  public func crearUsuario({
    nombre; 
    apellidopaterno; 
    apellidomaterno; 
    telefono; 
    email; 
    tipo; 
    identidad}:Usuario) : async Text {
    let postuser = {
      nombre = nombre; 
      apellidopaterno = apellidopaterno; 
      apellidomaterno = apellidomaterno; 
      telefono = telefono; 
      email = email; 
      tipo = tipo; 
      identidad = identidad};

    let clave = Nat.toText(generateIUser());
    usuarios.put(clave, postuser);
    //identidad: Principal; // Identidad de Internet Identity
    return "Usuario agregado correctamente";
  };






  public query func buscarUsuarios () : async [(Text, Usuario)]{
    let userIter : Iter.Iter<(Text, Usuario)> = usuarios.entries();
    let userArray : [(Text, Usuario)] = Iter.toArray(userIter);
    return userArray;

  };

  public query func buscarUsuariosid (id: Text) : async ?Usuario {
    let user: ?Usuario = usuarios.get(id);
    return user;
  };

public func actualizarUsuario (
  id:Text, 
  indice:Nat, 
  nombre:Text,
  apellidopaterno:Text, 
  apellidomaterno:Text, 
  telefono:Int, 
  email:Text, 
  tipo:Text, 
  identidad:Principal) : async Bool {
    let user: ?Usuario= usuarios.get(id);

    switch (user) {
      case (null) {
        return false;
      };
      case (?currentuser) {
        let user: Usuario = {
          nombre = nombre; 
          apellidopaterno = apellidopaterno; 
          apellidomaterno = apellidomaterno; 
          telefono = telefono; 
          email = email; 
          tipo = tipo; 
          identidad = identidad};
        usuarios.put(id,user);
        //Debug.print("Updated post with ID: " # id);
        return true;
      };
    };

  };





//Platillos
//------------------------------------------------------------------------------------------
// Define el tipo de datos platillos
type Platillos = {
  TipoPlatillos: Text; //entrada, aperitivo, postres, bebidas
  descripcion: Text;
  promocion: Text;  
  precio: Int;
};

private func generateIEvent() : Nat {
    indice += 1;
    return indice;
  };


// Declara una estructura de datos para almacenar platillos
var platillos = HashMap.HashMap<Text, Platillos>(0, Text.equal, Text.hash);



// Función para crear un nuevo Platillo
public func crearPlatillos(
  tipoPlatillo: Text,
  descripcion: Text,
  promocion: Text,
  precio: Int
) : async Text {
  let nuevoPlatillo: Platillos = {
    TipoPlatillos = tipoPlatillo;
    descripcion = descripcion;
    promocion = promocion;
    precio = precio;
  };
  
  // Genera una clave única para el platillo (puedes modificar esto según tus necesidades)
  let clave = tipoPlatillo;
  
  // Almacena el platillo en la estructura de datos
  platillos.put(clave, nuevoPlatillo);
  
  return "Platillo agregado correctamente";
};

// Función para modificar un plstillo existente
public func modificarPlatillo(
  tipoPlatillo: Text,
  nuevaDescripcion: Text,
  nuevapromocion: Text,
  nuevoPrecio: Int
) : async Text {
  let platilloExistente : ?Platillos = platillos.get(tipoPlatillo);
  
  switch (platilloExistente) {
    case (null) {
      // El platillo no existe, devuelve un mensaje de error
      return "platillo no encontrado. No se puede modificar.";
    };
    case (?Platillos) {
      // El platillo existe, actualiza sus propiedades
      let platilloActualizado : Platillos = {
        TipoPlatillos = tipoPlatillo;
        descripcion = nuevaDescripcion;
        promocion = nuevapromocion;
        precio = nuevoPrecio;
      };
      
      // Almacena el platillo actualizado
      platillos.put(tipoPlatillo, platilloActualizado);
      
      return "platillo modificado correctamente";
    };
  };
};

// Función para eliminar un platillo
public func eliminarPlatillo(tipoPlatillo: Text) : async Text {
  let platilloExistente : ?Platillos = platillos.get(tipoPlatillo);
  
  switch (platilloExistente) {
    case (null) {
      // El platillo no existe, devuelve un mensaje de error
      return "platillo no encontrado. No se puede eliminar.";
    };
    case (?_) {
      // El platillo existe, elimínalo
      platillos.delete(tipoPlatillo);
      return "platillo eliminado correctamente";
    };
  };
};

public query func buscarPlatillos () : async [(Text, Platillos)]{
    let platvIter : Iter.Iter<(Text, Platillos)> = platillos.entries();
    let platvArray : [(Text, Platillos)] = Iter.toArray(platvIter);
    return platvArray;

  };

  public query func buscarPlatillosID (id: Text) : async ?Platillos {
    let serv: ?Platillos = platillos.get(id);
    return serv;
  };

}