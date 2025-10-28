

class Castillo{
  //Las defensas y ataques mejor numeros altos (100 o 500) para facilitar las escalas y usar así siempre números enteros
  var defensa = nivelCastillo * 10
  var nivelCastillo = 1

  method subirNivel(){
    nivelCastillo = nivelCastillo + 1
  }

  method recibirDaño(nivelDaño){
    defensa = defensa - nivelDaño
  }
}

class Torre{
  var nivelTorre
  const daño

  method subirNivel(){
    nivelTorre = nivelTorre + 1
  }

  method atacar() = daño + nivelTorre
}

//Los Stats de los enemigos luego resolvemos como automatizar la creación y parametrización para polimorfizarlo de nivel a nivel
class EnemigoBase{
  //El nivel de juego luego resolvemos como pasárlo para parametrizar y automatizarlo al pasar de nivel
  const nivelEnemigo = juego.nivelJuego() * 2
  const daño
  var vida

  method recibirDaño(nivelDeDaño){
    vida = vida - nivelDeDaño
  }

  method atacar() = daño + nivelEnemigo
}

class EnemigoJefe{
  const nivelEnemigo = juego.nivelJuego() * 2
  const daño //Algún multiplicador respecto a los EnemigosBase
  var vida //Algún multiplicador respecto a los EnemigosBase

  method recibirDaño(nivelDeDaño){
    vida = vida - nivelDeDaño
  }

  method atacar() = daño * nivelEnemigo
}

