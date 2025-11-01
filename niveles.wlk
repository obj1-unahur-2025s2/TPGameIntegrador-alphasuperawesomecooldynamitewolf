import enemigos.*
import juegoBase.*
import castillo.*
import wollok.game.*
import pantalla.* 
class Nivel{
    var nivel
    var enemigosPorOleada 
    var enemigosGenerados
    var enemigosVivos                 //x,y
    const ubicacionesPosiblesDeTorre=[[8,3],[11,0],[11,3],[16,0],[14,4],[15,6]] //debe estar ordenada //[8,3] es tomado como game.at()
    const ubicacionesCamino = [] //Camino por donde pasan los enemigos
    const ubicacionActualJugador =[]
    const pantalla   //pasar la imagen de clase Pantalla al crear el nivel.
    // Inicializa el nivel                  
    method iniciar(){
        enemigosGenerados = 0
        enemigosVivos = 0
        self.pantalla()
        game.addVisual(personajePrincipal)
        game.addVisual(castillo)
        self.generarOleada()
        game.boardGround("fondo.png")
    }
    method mapeoEnemigo() =ubicacionesCamino 
    method ubicacionActualJugador() =ubicacionActualJugador 
    method ubicacionesPosibles() =ubicacionesPosiblesDeTorre 
    method ubicacionSiguienteA(pos) {
        if(self.restaDeUbicaciones().size() !=1){
            ubicacionActualJugador.add(pos)
            return self.restaDeUbicaciones().get(0)
        }
        return self.reiniciarSiguientesUbi(pos)

    } 
    method reiniciarSiguientesUbi(unaPos) {
        ubicacionActualJugador.clear()
        ubicacionActualJugador.add(unaPos)
        return self.restaDeUbicaciones().get(0)
    }
    method reiniciarAnterioresUbi(unaPos) {
        ubicacionActualJugador.clear()
        ubicacionActualJugador.addAll(ubicacionesPosiblesDeTorre)
        return ubicacionActualJugador.last().get(0)
    }
    method obtenerUltimo() =ubicacionActualJugador.last()
    method ubicacionAnterior(unaPos) {
        if(ubicacionActualJugador.size() !=0){
            const moverse=self.obtenerUltimo()
            ubicacionActualJugador.remove(self.obtenerUltimo())
            return  moverse
        }
        else{
            return self.reiniciarAnterioresUbi(unaPos)
        }
    }
    method restaDeUbicaciones() =ubicacionesPosiblesDeTorre.filter({u => not self.ubicacionActualJugador().any({ub=> ub ==u})}) //filtra por los que NO estan en las lista de la lista de posiciones del jugador
    method generarOleada(){
        if(enemigosGenerados < enemigosPorOleada){
            enemigosGenerados += 1
            enemigosVivos += 1
            const troll =new Enemigo(vida=100,daño=10,rango=10,imagen="idleTroll.png",nivelAct=self)
            game.addVisual(troll)
            troll.iniciar()
        }
    }

    // Llamar cuando un enemigo muere
    method enemigoMuerto(){
        enemigosVivos -= 1
        if(enemigosVivos == 0){
            self.pasarSiguienteNivel()
        }
    }

    method pasarSiguienteNivel(){
        nivel += 1
        enemigosPorOleada += 2  // Cada nivel más difícil
    }
    method pantalla() = pantalla.iniciar()
    /*method nivelFinal(){
        if(nivel == 10){

        }
    }*/
}


///usos, se podria utilizar para saber cuantas torres hay para ubicar,  si es que en algun nivel especifico ya no se permite dicha torre etc.
object torresOpciones {
  //listar torres posibles que se pueden elegir 
    const opciones=[[1,3],[1,4]] //1,3 -> torre flecha // 1,4 -> torre cañon
    const torres=[]
    method image() ="cursor.png"
    var property position = game.at(1, 3) 
    
    method posicionActualComoColeccion() =[position.x(),position.y()] // "como coleccion" refiere a  la posicion que refleja dentro del menu, y esta la mete en una coleccion para luego comparar.
    
    //metodo el cual genera torres, las cuales deben recibir por parametro la posicion asi son colocadas, (es posible que se generen varias constantes, como que no. porque son eliminadas al iniciar. )
    method torreSeleccionada(x,y) {
        torres.clear() //<- elimina para poder crear repeticion. 
        const torreNormal=new Torre(nivelTorre=1,costo=2,daño=10,rango=2,position=game.at(x,y),positionOpcion=opciones.get(0)) //al iniciar las opciones se guardan en la lista las torres 
        torreNormal.elegirDiseño(0)
        torres.add(torreNormal)
        const torreCañon=new Torre(nivelTorre=2,costo=4,daño=15,rango=1,position=game.at(x,y),positionOpcion=opciones.get(1))
        torreCañon.elegirDiseño(1)
        torres.add(torreCañon)
        return torres.find({t=> t.posicionDeOpcion() == self.posicionActualComoColeccion()})
    }  

    
    method sensar() {
        game.onCollideDo(
		self,
		{ algo =>
            
		}   //adaptarlo despues.
	    )
    }
    method obtenerTorreNormal() = torres.get(0)
    method obtenerTorreCañon() = torres.get(1)
    //movimientos
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
//---------(Entorno)--------
const nivelUnoFondo=new Pantalla(imagen="nivel2Fondo.png")
const nivelPrueba = new Nivel(nivel=0,enemigosPorOleada=1,enemigosGenerados=0,enemigosVivos=0 , ubicacionesCamino = [[19,5],[18,5],[17,5],[16,4],[16,3],[16,2],[15,2],[14,2],[13,2],[12,2],[11,2],[10,2],[9,2],[8,2],[8,1]],pantalla=nivelUnoFondo) //un nivel para probar diseños. --cambiar a tutorial mas adelante