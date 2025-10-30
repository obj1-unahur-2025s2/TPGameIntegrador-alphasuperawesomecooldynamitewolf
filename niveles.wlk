import enemigos.*
import juegoBase.*
import castillo.*
import wollok.game.*

class Nivel{
    var nivel
    var enemigosPorOleada 
    var enemigosGenerados
    var enemigosVivos                 //x,y
    const ubicacionesPosiblesDeTorre=[[5,4],[8, 3],[11, 0],[14, 3],[16,1],[15,6]] //debe estar ordenada 
    const ubicacionActualJugador =[] 
    // Inicializa el nivel                  
    method iniciar(){
        
        game.addVisual(personajePrincipal)
        game.addVisual(castillo)
        enemigosGenerados = 0
        enemigosVivos = 0
        self.generarOleada()
        
    }
    method ubicacionActualJugador() =ubicacionActualJugador 
    method ubicacionesPosibles() =ubicacionesPosiblesDeTorre 
    method ubicacionSiguienteA(pos) {
        ubicacionActualJugador.add(pos)
        console.println(ubicacionesPosiblesDeTorre)
        console.println(ubicacionActualJugador)
        console.println(self.restaDeUbicaciones())
        return self.restaDeUbicaciones().get(0)
    }
    method obtenerUltimo() =ubicacionActualJugador.last()
    method ubicacionAnterior(pos) {
        const moverse=self.obtenerUltimo()
        ubicacionActualJugador.remove(self.obtenerUltimo())
        return  moverse
    }
    method restaDeUbicaciones() =ubicacionesPosiblesDeTorre.filter({u => not self.ubicacionActualJugador().any({ub=> ub ==u})}) //filtra por los que NO estan en las lista de la lista de posiciones del jugador
    method generarOleada(){
        if(enemigosGenerados < enemigosPorOleada){
            enemigosGenerados += 1
            enemigosVivos += 1
            const troll =new Enemigo(vida=100,daño=10,rango=10,imagen="idleTroll.png")
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
    method iniciar() {
        const torreNormal=new Torre(nivelTorre=1,costo=2,daño=10,position=game.at(0,0),positionOpcion=opciones.get(0)) //al iniciar las opciones se guardan en la lista las torres 
        torreNormal.elegirDiseño(0)
        torres.add(torreNormal)
        const torreCañon=new Torre(nivelTorre=2,costo=4,daño=10,position=game.at(0,0),positionOpcion=opciones.get(1))
        torreCañon.elegirDiseño(1)
        torres.add(torreCañon)

    }    
    method posicionActualComoColeccion() =[position.x(),position.y()]
    method torreSeleccionada() = torres.find({t=> t.posicionDeOpcion() == self.posicionActualComoColeccion()})
    method seleccionar()=self.torreSeleccionada()
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
        if(self.position().y() <6 )
		self.position(self.position().up(1))
        self.sensar()
	}
    method moverseHaciaAbajo()  {
        if(self.position().y() >3)
		self.position(self.position().down(1))
        self.sensar()
	}
}
//---------(Entorno)--------
const nivelPrueba = new Nivel(nivel=0,enemigosPorOleada=1,enemigosGenerados=0,enemigosVivos=0) //un nivel para probar diseños. --cambiar a tutorial mas adelante
object cursorMenu {
  
  



}