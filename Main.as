import flash.events.MouseEvent;
import flash.events.Event;
import fl.events.SliderEvent;

//Eventos con sus respectivas funciones
Agregar.addEventListener(MouseEvent.CLICK, addPelotita);
Quitar.addEventListener(MouseEvent.CLICK, removePelotita);
SlideBar.addEventListener(SliderEvent.THUMB_DRAG, changeTemperature);
addEventListener(Event.ENTER_FRAME, moveBalls);

//Declaración e inicialización de variables globales.
var pelotitas: Array = new Array();
var constanteGases = 0.08205746;
var temperatura = 273;
var contadorPelotitas = 0;
var volumen = 22.4;
var presion = 0;
var velocidad = 2.73;

// Inicialización de texto dinámico.
temperaturaInst.text = this.temperatura;
presionInst.text = this.presion;

/** Calcula la presion (P * V = nRT).
@param SliderEvent Ejecutado por medio de la barra deslizadora.
*/
function calculatePresion():void{
	
	this.presion = (this.temperatura * this.contadorPelotitas *
	this.constanteGases) / this.volumen;
	
	presionInst.text = this.presion;

}

/** Cambia la temperatura.
@param SliderEvent Ejecutado por medio de la barra deslizadora.
*/
function changeTemperature(event:SliderEvent):void{
	
	//Se toma el valor de la barra para la temperatura
	this.temperatura = SlideBar.value;
	temperaturaInst.text = this.temperatura;

	//Se recalcula la presion y velocidad
	this.velocidad = this.temperatura / 100;
	if (this.velocidad <= 0.5 && this.velocidad > 0){
		this.velocidad = 1;
	}
	calculatePresion();
	
}

/** Función ejecutada cada frame
@param Event Ejecutado por medio de un evento.
*/
function moveBalls(event:Event):void{
	
	//Se recorren dos arrays iguales para comparar cada posición
	//con todas las posiciones para el análisis de colisiones.
	for (var i:int = 0; i < pelotitas.length; i++){
		var a:Pelotita = pelotitas[ i ];
		for( var j:int = i+1; j < pelotitas.length; j++){
			var b:Pelotita = pelotitas[ j ];
			var isColliding:Boolean = a.hitTestObject( b );
			if(isColliding){
				this.analizeCollision(a, b);
			}
		}
		
		//Movimiento de la pelotita en base a la velocidad
		for (var m:int = 0; m < Math.round(this.velocidad); m++){
			a.mover();
		}
	}
	
}


/** Agrega pelotitas, recalculando la presión.
@param MouseEvent Ejecutado por medio de un evento.
*/
function addPelotita(event:MouseEvent):void{
	
	//Creación de la pelotita
	var pelotita:Pelotita = new Pelotita(recipienteInst.width,
	recipienteInst.height, recipienteInst.x, recipienteInst.y);
	
	//Agregar al escenario
	addChild(pelotita);
	
	//Posiciones iniciales
	pelotita.x = pelotita.posicionInicialX;
	pelotita.y = pelotita.posicionInicialY;
	
	//Variables para el manejo del array de pelotitas
	this.contadorPelotitas+=1;	
	pelotita.name = 'pelotita' + String(this.contadorPelotitas);
	pelotitas.push(pelotita);
	
	//Calculo de presion
	calculatePresion();
	
}

/** Remueve pelotitas, recalculando la presión.
@param MouseEvent Ejecutado por medio de un evento.
*/
function removePelotita(event:MouseEvent):void{
	
	//Cambio en el array y recalculo de presión
	if (this.contadorPelotitas > 0){
		removeChild(getChildByName('pelotita'+this.contadorPelotitas));
		this.contadorPelotitas -= 1;
		pelotitas.pop();
		calculatePresion();	
	}

	
}

/** Funcion para cambiar las direcciones en las colisiones.
@param pelotitaA una de las pelotitas de las colisiones.
@param pelotitaB la otra pelotita en la colisión.
*/
function analizeCollision(pelotitaA:Pelotita, pelotitaB:Pelotita){
	
	//Todavía no esta terminado, por el momento la idea es analizar
	//todas las variantes en ambos ejes para que funcione, luego
	//habría que recodificar en base a patrones iguales.
	if (pelotitaA.directionY == 'bottom' && pelotitaB.directionY == 'bottom'){
		
		if (pelotitaB.y - pelotitaA.y <= pelotitaA.width
		    && pelotitaB.y - pelotitaA.y > 0){
				
			pelotitaA.changeDirection('top');
				
		}else{
	
			pelotitaB.changeDirection('top');
				
		}
	
	}	
	else if (pelotitaA.directionY == 'bottom' && pelotitaB.directionY == 'top'){
		
		if (pelotitaB.y - pelotitaA.y <= pelotitaA.width
			&& pelotitaB.y - pelotitaA.y > 0){

			pelotitaA.changeDirection('top');
			pelotitaB.changeDirection('bottom');
				
		}
	}
	else if (pelotitaA.directionY == 'top' && pelotitaB.directionY == 'bottom'){
		
		if (pelotitaA.y - pelotitaB.y <= pelotitaA.width
			&& pelotitaA.y - pelotitaB.y > 0){

			pelotitaA.changeDirection('bottom');
			pelotitaB.changeDirection('top');
				
		}		
	}
	else{

		if (pelotitaA.y - pelotitaB.y <= pelotitaA.width
		&& pelotitaA.y - pelotitaB.y > 0){
			
			pelotitaB.changeDirection('bottom');	
			
		}else{
			
			pelotitaA.changeDirection('bottom');
		}
	}
	
	if (pelotitaA.directionX == 'right' && pelotitaB.directionX == 'right'){
		
		if (pelotitaA.x - pelotitaB.x <= pelotitaA.width
		    && pelotitaA.x - pelotitaB.x > 0){
				
			pelotitaB.changeDirection('left');
				
		}else{
	
			pelotitaA.changeDirection('left');
				
		}	
	}
	else if (pelotitaA.directionX == 'right' && pelotitaB.directionX == 'left'){
		
		if (pelotitaB.x - pelotitaA.x <= pelotitaA.width
		    && pelotitaB.x - pelotitaA.x > 0){
				
			pelotitaA.changeDirection('left');
			pelotitaB.changeDirection('right');
				
		}
	}
	else if (pelotitaA.directionX == 'left' && pelotitaB.directionX == 'right'){
		
		if (pelotitaA.x - pelotitaB.x <= pelotitaA.width
		    && pelotitaA.x - pelotitaB.x > 0){
				
			pelotitaA.changeDirection('right');
			pelotitaB.changeDirection('left');
		}
		
}
	else{
		
		if (pelotitaA.x - pelotitaB.x <= pelotitaA.width
		&& pelotitaA.x - pelotitaB.x > 0){
			
			pelotitaA.changeDirection('right');	
			
		}else{
			
			pelotitaB.changeDirection('bottom');
		}		
		
	}

}
