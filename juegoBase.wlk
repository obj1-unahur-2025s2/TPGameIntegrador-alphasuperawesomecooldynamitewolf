import castillo.*
import enemigos.*
import niveles.*
import wollok.game.*
import menu.*
import controles.*
import armas.*


object juego {
  method iniciar() {
    game.title("Orcs defense")
    game.height(10)
    game.width(20)
    game.boardGround("fondo.png")
    game.addVisual(menu)
    menu.seleccionNivel()
    game.start()
    
  } 
}

object juegoDelCastillo {//para mantener la estructura del juego. <- primero debe pasar por el menu
  var  property nivel = nivelPrueba
  var juegoCorriendo=false
  const niveles=[]
  const nivelesCompeltos=[]
 
  method agregarNiveles(unNivel) {
    if(!niveles.contains(unNivel)){
      niveles.add(unNivel)
    }
  }
  method vaciarNiveles() {
    niveles.clear()
    console.println(" VACIE niveles")
    console.println(niveles)
  } 
  method tieneNiveles() =niveles.size()>0 
  method iniciarNivel() {
    controles.configurarTeclas()
    juegoCorriendo=true
    if(!game.hasVisual(torresOpciones)) game.addVisual(torresOpciones)
    console.println(niveles)
    self.obtenerNivel().iniciar()

  }
   
  method obtenerNivel() = niveles.first()
  method pasarDeNivel() {
    nivelesCompeltos.add(nivel)
    niveles.remove(nivel)
    nivel=self.obtenerNivel()
  }
  method volverAlMenu() {juegoCorriendo=true ; }
  method reiniciarPartida() {if(self.tieneNiveles()){juegoCorriendo=true  self.obtenerNivel().reiniciarPartida()}} 
  method juegoCorriendo() =juegoCorriendo 
  method perderPartida() {  self.obtenerNivel().perderPartida(); if(!game.hasVisual(menuGameOver))game.addVisual(menuGameOver);menuGameOver.seleccionNivel()} 
  method nivelQueSigue()= niveles.filter({ n => nivelesCompeltos.any({ nc => n !=nc})}).first() // filtrame por los niveles que no están dentro de los niveles pasados por el jugador
  method borrarTodo(){
    personajePrincipal.partidaFinalizada()

  }
  
  method ganarPartida() {
    if(nivel.partidaGanada()){
      personajePrincipal.partidaFinalizada()
      self.pasarDeNivel()
      game.clear()
      self.iniciarNivel()
    }
  }
}