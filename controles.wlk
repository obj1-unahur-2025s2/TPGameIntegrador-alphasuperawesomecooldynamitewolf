//Copié todo lo relacionado a controles acá... no discriminé nada.. Despues lo pulimos para usarlos desde aca. Por ahora no quiero romper nada. Por eso no toco nada del codigo real.

object controles {
     method configurarTeclas() {
    //movimientos jugador  //meter limitaciones y q no salga del mapa , y solo ubicar en  donde se pueda situar 
	  keyboard.up().onPressDo({personajePrincipal.moverseHaciaArriba()})
	  keyboard.down().onPressDo({personajePrincipal.moverseHaciaAbajo()})
    	//teclas de opciones torres 
    keyboard.space().onPressDo({personajePrincipal.agregarTorre()}) //Z para poner la torre normal 
      //teclas opciones

    keyboard.w().onPressDo({torresOpciones.moverseHaciaArriba()})
    keyboard.s().onPressDo({torresOpciones.moverseHaciaAbajo()})

  }

  method moverseHaciaArriba() {
        if(self.position().y() >1 and self.position().y() <6 ){
		self.position(self.position().up(1))
        self.sensar()}
        else{
            position=game.at(1,3)
        }
	}
    method moverseHaciaAbajo()  {
        if(self.position().y() >3){
		self.position(self.position().down(1))
        self.sensar()}
        else{
            position=game.at(1,0)
        }
	}
}