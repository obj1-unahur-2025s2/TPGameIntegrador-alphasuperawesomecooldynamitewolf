//import TPGameIntegrador-alphasuperawesomecooldynamitewolf.menu.*
import enemigos.*
import juegoBase.*
import castillo.*
import wollok.game.*
import pantalla.* 
import menu.*
import armas.*
import controles.*

class Nivel{
    const property enemigos = []
    const nivel // identificador -nivel
    const enemigosPorOleada 
    var enemigosGenerados =0
    var enemigosVivos=0                 //x,y
    const cantidadDeRey=1
    var reysGenerados=0
    var partidaSigue=true //sirve para las oleadas, ayuda a datenerlas
    const ubicacionesPosiblesDeTorre=[[8,3],[11,0],[11,3],[16,0],[14,4],[16,6]] //debe estar ordenada //[8,3] es tomado como game.at()
    const ubicacionesCamino = [] //Camino por donde pasan los enemigos
    const ubicacionActualJugador=[]
    const pantalla   //pasar la imagen de clase Pantalla al crear el nivel.
    //const fondoNivelActual ==> Aca declaramos la imagen del fondo al instanciar el nivel. Y lo pasamos como parametro como game.boardGround(fondoNivelActual)
    // Inicializa el nivel
    method eliminarEnemigos(){
        enemigos.forEach({ e => game.removeVisual(e)})
    }
    method partidaSigue() =partidaSigue      
    method iniciar(){
        enemigosGenerados=0
        reysGenerados=0
        partidaSigue=true
        pantalla.iniciar()
        enemigosVivos=enemigosPorOleada
        game.addVisual(personajePrincipal)
        self.generarOleada()
        game.addVisual(castillo)     
        self.agregarContadores()      
        castillo.activarColision()
        game.boardGround("fondo.png") //Al ser clase, y reutilizarlo para los nivles habría que pasar la imagen del boarGround como parametro de alguna constante que la declaramos al instanciar el New Nivel

    }
    method agregarContadores() {
        if(!game.hasVisual(contadorMoneda) and !game.hasVisual(contadorVida)){
            game.addVisual(contadorVida)           
            game.addVisual(contadorMoneda)     
        }
    }
    method partidaFinalizada(){
        enemigosGenerados=0
        reysGenerados=0
        game.removeVisual(personajePrincipal)
        game.removeVisual(castillo)
        self.eliminarEnemigos();
        partidaSigue= false
    }
    method eliminarPantalla() {
      pantalla.eliminar()
    }
    //a cada enemigo se le agrega a su lista de posiciones todas las posiciones posibles
    method mapeoEnemigo() {
        const soloEnemigo=[]
        soloEnemigo.addAll(ubicacionesCamino) // evitar errores por paso de referencia.
        return soloEnemigo
    } 

    //ubicaciones actuales tanto cursor como de las torres
    method ubicacionActualJugador() =ubicacionActualJugador 
    method ubicacionesPosibles() =ubicacionesPosiblesDeTorre 
    //Posiciones de las torres, cursor
    method ubicacionSiguienteA(pos) {
        if(ubicacionActualJugador.size() !=ubicacionesPosiblesDeTorre.size()-1){
            ubicacionActualJugador.add(pos)
            return self.restaDeUbicaciones().get(0)
        }
        else{
            return self.reiniciarSiguientesUbi()
        }
        

    } 
    method reiniciarPartida(){
        //agregar visuales al reiniciar
        //if(!game.hasVisual(personajePrincipal))game.addVisual(personajePrincipal)
        if(!game.hasVisual(castillo)) game.addVisual(castillo)  
        castillo.activarColision() 
        if(!game.hasVisual(personajePrincipal)) game.addVisual(personajePrincipal)   
        //activar colisión del
        castillo.activarColision()
        enemigosGenerados=0
        reysGenerados=0
        partidaSigue=true
        enemigos.forEach({ e => game.removeVisual(e)})
        enemigos.clear()
        
    }
    method reiniciarSiguientesUbi() {
        ubicacionActualJugador.clear()
        return self.obtenerPrimeraDireccion() //entrega la primera direccion al jugador porque las posiciones se reiniciaron.
    }
    method obtenerPrimeraDireccion() =ubicacionesPosiblesDeTorre.get(0) 
    method reiniciarAnterioresUbi() {
        ubicacionActualJugador.addAll(ubicacionesPosiblesDeTorre)
        return self.ubicacionAnterior()
    }
    method obtenerUltimo() =ubicacionActualJugador.last()
    method ubicacionAnterior() {
        if(ubicacionActualJugador.size() >0){
            const moverse=self.obtenerUltimo()
            ubicacionActualJugador.remove(self.obtenerUltimo())
            return  moverse
        }
        else{
            return self.reiniciarAnterioresUbi()
        }
    }
    method restaDeUbicaciones() =ubicacionesPosiblesDeTorre.filter({u => not self.ubicacionActualJugador().any({ub=> ub ==u})}) //filtra por los que NO estan en las lista de la lista de posiciones del jugador
    //Metodo encargado de generar la oleada de enemigos
    method generarOleada(){
        game.removeTickEvent("oleada orco")
            //game.schedule( 4000, {self.generarOleada()})
        game.onTick(3000, "oleada orco", {
            if((enemigosGenerados < enemigosPorOleada )and partidaSigue){
            enemigosGenerados += 1
            enemigosVivos += 1
            // var imagenIdle
            // var imgenDaño
            const orco =new Orco(vida=9,daño=10,imagen="idleTroll.png",imagenIdle="idleTroll.png",imagenDaño="idleTrollDaño.png",nivelAct=self,posiciones=self.mapeoEnemigo()) //Imagino que esto es para las pruebas. Pero podríamos parametrizar los stats (no todos, algunos), para poder cambiar de nivel a nivel.
            enemigos.add(orco)
            game.addVisual(orco)
            orco.iniciar()
            self.generarOleada()
            }else{
                reysGenerados+=1
                self.generarRey()
            } 
        })
        }

    method generarRey() {
        if(reysGenerados<=cantidadDeRey and partidaSigue){
            const orcoRey =new OrcoRey(vida=20,daño=15,imagen="idleTrollMiniBoss.png",imagenIdle="idleTrollMiniBoss.png",imagenDaño="idleTrollMiniBossDaño.png",nivelAct=self,posiciones=self.mapeoEnemigo())
            enemigos.add(orcoRey)
            game.addVisual(orcoRey)
            orcoRey.iniciar()
        }
                
    } 
    // Llamar cuando un enemigo muere
    /*method enemigoMuerto(){
        enemigosVivos -= 1
        if(enemigosVivos == 0){
            self.pasarSiguienteNivel() //Tiene que haber un mensaje, pantalla o algo que suavice la trancisión de un nivel a otro. Que no quede llamado así de una porque ni te va a dar tiempo a ver que ganaste el nivel y pasas al siguiente.
        }
    }*/

    //Pasa a siguiente nivel una vez que gana
    
    /*
    method pasarSiguienteNivel(){
        nivel += 1
        enemigosPorOleada += 2  // Cada nivel más difícil
        
    }
    */

    /*method nivelFinal(){
        if(nivel == 10){

        }
    }*/
}


///usos, se podria utilizar para saber cuantas torres hay para ubicar,  si es que en algun nivel especifico ya no se permite dicha torre etc.

//---------(Entorno)--------
const nivelUnoFondo=new Pantalla(imagen="nivel1FondoPixel.png")
const nivelDosFondo=new Pantalla(imagen="nivel2Fondo.png")
const nivelPrueba = new Nivel(nivel=0,enemigosPorOleada=10, ubicacionesCamino = [[19,5],[18,5],[17,5],[16,4],[16,3],[16,2],[15,2],[14,2],[13,2],[12,2],[11,2],[10,2],[9,2],[8,2],[8,1],[8,0]],pantalla=nivelUnoFondo) //un nivel para probar diseños. --cambiar a tutorial mas adelante
const nivel1= new Nivel(nivel=1,enemigosPorOleada=4, ubicacionesCamino = [[19,5],[18,5],[17,5],[16,4],[16,3],[16,2],[15,2],[14,2],[13,2],[12,2],[11,2],[10,2],[9,2],[8,2],[8,1],[8,0]],pantalla=nivelUnoFondo) //un nivel para probar diseños. --cambiar a tutorial mas adelante
const nivel2= new Nivel(nivel=2,enemigosPorOleada=8, ubicacionesCamino = [[19,5],[18,5],[17,5],[16,4],[16,3],[16,2],[15,2],[14,2],[13,2],[12,2],[11,2],[10,2],[9,2],[8,2],[8,1],[8,0]],pantalla=nivelDosFondo) //un nivel para probar diseños. --cambiar a tutorial mas adelante
const nivel3= new Nivel(nivel=3,enemigosPorOleada=12, ubicacionesCamino = [[19,5],[18,5],[17,5],[16,4],[16,3],[16,2],[15,2],[14,2],[13,2],[12,2],[11,2],[10,2],[9,2],[8,2],[8,1],[8,0]],pantalla=nivelUnoFondo) //un nivel para probar diseños. --cambiar a tutorial mas adelante
