//suma de numeros

func suma_dos_nums(num1: felt, num2: felt) -> (suma: felt) {
    alloc_locals;
    local sumando = num1+num2;
    return (suma=sumando);
}

func main{output_ptr: felt*}(){
    alloc_locals;
    
    const NUM1 = 1;
    const NUM2 = 10;

    let (suma) = suma_dos_nums(num1 = NUM1, num2 = NUM2);
    serialize_word(suma);
    return ();
}

//Al comienzo de nuestro programa en Cairo escribimos %builtins output.
// Aquí estamos diciendo al compilador de Cairo que usaremos el builtin llamado output. 
//La definición de builtin es bastante técnica y sale del alcance de este primer tutorial (aquí esta en la documentación). 
//Por el momento, nos basta indicar que podemos convocar capacidades especiales de Cairo a través de los builtins. Si sabes C++ seguramente ya encontraste las similitudes.

//El builtin output es lo que permite que el programa se comunique con el mundo exterior.
// Puedes considerarlo como el equivalente de print() en Python o std::cout de C++ (documentación de Cairo).

//La interacción entre builtin output y la función serialize_word, que importamos previamente, 
//nos permitirá imprimir a la consola. En este caso con serialize_word(sum). 
//No te preocupes, más adelante lo veremos más de cerca.

//Así se importan varias funciones de una misma biblioteca:}
 from starkware.cairo.common.math import (assert_not_zero, assert_not_equal).


// Struc diccionario de cairo?
 struct MiStruct{
    primer_miembro : felt,
    segundo_miembro : felt,
}

//tuplas

# Una tupla con tres elementos
local tuple0 : (felt, felt, felt) = (7, 9, 13)
local tuple1 : (felt) = (5,)  # (5) is not a valid tuple.

# Una tupla con nombre no requiere una coma final
local tuple2 : (a : felt) = (a=5)

# Tupla que contiene otra tupla.
local tuple3 : (felt, (felt, felt, felt), felt) = (1, tuple0, 5)
local tuple4 : ((felt, (felt, felt, felt), felt), felt, felt) = (
    tuple3, 2, 11)
let a = tuple0[2]  # let a = 13.
let b = tuple4[0][1][2]  # let b = 13.


//Estructura de funciones y comentarios

func función(arg1: felt, arg2) -> (retornado: felt){
  // Cuerpo de la función
  let (suma) = suma_dos_nums(num1 = NUM1, num2 = NUM2);
  return(retornado=suma);
}

//Argumentos implicitos

%builtins output

func serialize_word{output_ptr : felt*}(word : felt):
    assert [output_ptr] = word
    let output_ptr = output_ptr + 1
    # El nuevo valor de output_ptr es implícitamente
    # añadido en return.
    return ()
end







